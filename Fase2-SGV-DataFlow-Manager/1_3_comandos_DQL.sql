-- Selecionando todas categorias de produtos e seus respectivos produtos
SELECT
    c.cd_categoria AS "cod_categoria",
    c.ds_categoria AS "categoria",
    p.cd_produto AS "cod_produto",
    p.ds_produto AS "descricao_produto",
    p.vl_unitario AS "valor_unitario",
    p.tp_embalagem AS "tipo_embalagem",
    p.vl_perc_lucro AS "valor_percentual_lucro" 
FROM mc_categoria_prod c
LEFT JOIN mc_produto p ON c.cd_categoria = p.cd_categoria
WHERE c.tp_categoria = 'P'
ORDER BY
    c.ds_categoria ASC,
    p.ds_produto ASC;

-- Selecionando dados de clientes pessoas fisicas
SELECT
    c.nr_cliente AS "codigo",
    c.nm_cliente AS "cliente",
    c.ds_email AS "email",
    c.nr_telefone AS "telefone",
    c.nm_login AS "login",
    to_char(cf.dt_nascimento, 'dd-mm-yyyy') AS "data_nascimento",
    to_char(cf.dt_nascimento, 'day') AS "dia_semana",
    FLOOR(MONTHS_BETWEEN(SYSDATE, cf.dt_nascimento) / 12) AS "idade",
    cf.fl_sexo_biologico AS "sexo_biologico",
    cf.nr_cpf AS "cpf"
FROM mc_cliente c
JOIN mc_cli_fisica cf ON c.nr_cliente = cf.nr_cliente;

-- Selecionando visualizacao dos videos dos produtos e ordenando por data e hora mais recentes
SELECT
    v.cd_produto AS "cod_produto",
    pd.ds_produto AS "nome_produto",
    v.dt_visualizacao AS "data",
    v.nr_hora_visualizacao AS "hora"
FROM mc_sgv_visualizacao_video v
LEFT JOIN mc_produto pd ON v.cd_produto = pd.cd_produto
ORDER BY
    v.dt_visualizacao DESC,
    v.nr_hora_visualizacao DESC;