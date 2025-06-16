-- TRUNCATE TABLE mc_sgv_ocorrencia_sac

-- c) Verificar se a tabela está vazia (ANTES da execução da procedure)
SELECT COUNT(*) FROM mc_sgv_ocorrencia_sac;

-- d) Executar a procedure
BEGIN
  PR_SGV_CARGA_RESUMO_OCORR_SAC;
END;
/

-- e) Confirmar transações (caso não esteja com commit automático)
COMMIT;

-- f) Verificar se a tabela foi carregada (DEPOIS da execução da procedure)
SELECT COUNT(*) FROM mc_sgv_ocorrencia_sac;

-- a) Criação da stored procedure a partir do bloco anônimo

CREATE OR REPLACE PROCEDURE PR_SGV_CARGA_RESUMO_OCORR_SAC IS

    -- b) Declaração do cursor para buscar os dados de SAC, produto e cliente
    CURSOR c_abertura_sac IS
        SELECT s.nr_sac,
               s.dt_abertura_sac,
               s.hr_abertura_sac,
               s.tp_sac,
               s.nr_indice_satisfacao,
               s.cd_produto,
               p.ds_produto,
               p.vl_unitario AS vl_unitario_prod,
               p.vl_perc_lucro,
               s.nr_cliente,
               c.nm_cliente
        FROM mc_sgv_sac s
        INNER JOIN mc_produto p ON s.cd_produto = p.cd_produto
        INNER JOIN mc_cliente c ON s.nr_cliente = c.nr_cliente;

    -- Variáveis auxiliares
    r_cursor_sac c_abertura_sac%ROWTYPE;
    v_ds_tipo_classificacao_sac mc_sgv_ocorrencia_sac.ds_tipo_classificacao_sac%TYPE;
    v_ds_indice_satisfacao_atd_sac mc_sgv_ocorrencia_sac.ds_indice_satisfacao_atd_sac%TYPE;
    v_vl_unitario_lucro_produto mc_sgv_ocorrencia_sac.vl_unitario_lucro_produto%TYPE;
    v_vl_icms_produto mc_sgv_ocorrencia_sac.vl_icms_produto%TYPE;
    v_sg_estado mc_estado.sg_estado%TYPE;
    v_nm_estado mc_estado.nm_estado%TYPE;
    v_nr_ocorrencia_sac NUMBER;

BEGIN

    -- b) Limpar os dados da tabela MC_SGV_OCORRENCIA_SAC
    EXECUTE IMMEDIATE 'TRUNCATE TABLE mc_sgv_ocorrencia_sac';

    -- c) (Fora da procedure: você fará um SELECT COUNT(*) para validar)

    -- d) Abrir o cursor e processar os registros
    OPEN c_abertura_sac;
    LOOP
        FETCH c_abertura_sac INTO r_cursor_sac;
        EXIT WHEN c_abertura_sac%NOTFOUND;

        -- Converter tipo de SAC para texto
        IF r_cursor_sac.tp_sac = 'D' THEN
            v_ds_tipo_classificacao_sac := 'DUVIDA';
        ELSIF r_cursor_sac.tp_sac = 'S' THEN
            v_ds_tipo_classificacao_sac := 'SUGESTAO';
        ELSE
            v_ds_tipo_classificacao_sac := 'OUTRO';
        END IF;

        -- Gerar descrição do índice de satisfação via procedure externa
        prc_mc_gera_indice_satisfacao_atd(r_cursor_sac.nr_indice_satisfacao, v_ds_indice_satisfacao_atd_sac);

        -- Calcular lucro do produto
        v_vl_unitario_lucro_produto := r_cursor_sac.vl_unitario_prod - 
                                       (r_cursor_sac.vl_unitario_prod * (r_cursor_sac.vl_perc_lucro / 100));

        -- Tentar buscar o estado e nome do estado do cliente
        BEGIN
            SELECT cid.sg_estado, est.nm_estado
            INTO v_sg_estado, v_nm_estado
            FROM mc_estado est
            INNER JOIN mc_cidade cid ON cid.sg_estado = est.sg_estado
            INNER JOIN mc_bairro b ON b.cd_cidade = cid.cd_cidade
            INNER JOIN mc_logradouro l ON l.cd_bairro = b.cd_bairro
            INNER JOIN mc_end_cli ec ON l.cd_logradouro = ec.cd_logradouro_cli
            WHERE ec.nr_cliente = r_cursor_sac.nr_cliente
            AND ROWNUM < 2;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_sg_estado := '';
                v_nm_estado := '';
        END;

        -- Calcular valor do ICMS com função externa
        v_vl_icms_produto := fun_mc_gera_aliquota_media_icms_estado(v_sg_estado);

        -- Gerar número da ocorrência
        SELECT NVL(MAX(nr_ocorrencia_sac), 0) + 1
        INTO v_nr_ocorrencia_sac
        FROM mc_sgv_ocorrencia_sac;

        -- Inserir os dados na tabela consolidada
        BEGIN
            INSERT INTO mc_sgv_ocorrencia_sac (
                nr_ocorrencia_sac, dt_abertura_sac, hr_abertura_sac, 
                ds_tipo_classificacao_sac, ds_indice_satisfacao_atd_sac,
                cd_produto, ds_produto, vl_unitario_produto,
                vl_perc_lucro, vl_unitario_lucro_produto,
                sg_estado, nm_estado, nr_cliente, nm_cliente,
                vl_icms_produto
            )
            VALUES (
                v_nr_ocorrencia_sac, r_cursor_sac.dt_abertura_sac, r_cursor_sac.hr_abertura_sac,
                v_ds_tipo_classificacao_sac, v_ds_indice_satisfacao_atd_sac,
                r_cursor_sac.cd_produto, r_cursor_sac.ds_produto, r_cursor_sac.vl_unitario_prod,
                r_cursor_sac.vl_perc_lucro, v_vl_unitario_lucro_produto,
                v_sg_estado, v_nm_estado, r_cursor_sac.nr_cliente, r_cursor_sac.nm_cliente,
                v_vl_icms_produto
            );
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20222, 'Erro crítico: ' || SQLERRM);
        END;

    END LOOP;

    -- e) Confirmar as transações pendentes
    COMMIT;

    CLOSE c_abertura_sac;

    -- Mensagem de sucesso
    DBMS_OUTPUT.PUT_LINE('Processamento concluído com sucesso!');

END;
/


