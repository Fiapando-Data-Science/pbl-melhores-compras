TRUNCATE TABLE mc_sgv_ocorrencia_sac;

SET SERVEROUTPUT ON;

DECLARE
    
    -- (a) Criando cursor com junções necessárias
    CURSOR sac_cursor IS
        SELECT 
            s.nr_sac,
            s.dt_abertura_sac,
            s.hr_abertura_sac,
            s.tp_sac,
            p.cd_produto,
            p.ds_produto,
            p.vl_unitario,
            p.vl_perc_lucro,
            e.sg_estado,
            e.nm_estado,
            c.nr_cliente,
            c.nm_cliente
            
            
        FROM mc_sgv_sac s
        JOIN mc_produto p       ON s.cd_produto = p.cd_produto
        JOIN mc_cliente c       ON s.nr_cliente = c.nr_cliente
        JOIN mc_end_cli ec      ON c.nr_cliente = ec.nr_cliente
        JOIN mc_logradouro l    ON ec.cd_logradouro_cli = l.cd_logradouro
        JOIN mc_bairro b        ON l.cd_bairro = b.cd_bairro
        JOIN mc_cidade cid     ON b.cd_cidade = cid.cd_cidade
        JOIN mc_estado e        ON cid.sg_estado = e.sg_estado;
        
BEGIN
    
    -- (b) Colocando o cursor em loop e aplicando as regras
    FOR sac IN sac_cursor LOOP
        INSERT INTO mc_sgv_ocorrencia_sac (
            nr_ocorrencia_sac,
            dt_abertura_sac,
            hr_abertura_sac,
            ds_tipo_classificacao_sac,
            cd_produto,
            ds_produto,
            vl_unitario_produto,
            vl_perc_lucro,
            vl_unitario_lucro_produto,
            sg_estado,
            nm_estado,
            nr_cliente,
            nm_cliente,
            vl_icms_produto
            
        ) VALUES (
            sac.nr_sac,
            sac.dt_abertura_sac,
            sac.hr_abertura_sac,
            
            -- Classificando tp_sac:
            CASE sac.tp_sac
                WHEN 'S' THEN 'SUGESTÃO'
                WHEN 'D' THEN 'DÚVIDA'
                WHEN 'E' THEN 'ELOGIO'
                ELSE 'CLASSIFICAÇÃO INVÁLIDA'
            END,
            
            sac.cd_produto,
            sac.ds_produto,
            sac.vl_unitario,
            sac.vl_perc_lucro,
        
            -- Calculando o lucro unitário
            (sac.vl_unitario * sac.vl_perc_lucro / 100),
            
            sac.sg_estado,
            sac.nm_estado,
            sac.nr_cliente,
            sac.nm_cliente,
            
            -- ICMS deixado em branco como solicitado
            NULL
            
            
        );
        
            -- Mostrar na saída os dados inseridos
        DBMS_OUTPUT.PUT_LINE('Inserido SAC nº ' || sac.nr_sac || 
                         ' | Produto: ' || sac.ds_produto ||
                         ' | Cliente: ' || sac.nm_cliente ||
                         ' | Estado: ' || sac.sg_estado);
    END LOOP;
    
    -- (c) Finalizando com COMMIT e tratamento de erro
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || SQLERRM);
END;
/
SELECT * FROM mc_sgv_ocorrencia_sac;

        