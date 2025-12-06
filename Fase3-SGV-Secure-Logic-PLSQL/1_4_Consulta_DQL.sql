-- Selecionando todas as categorias de produtos e o total de chamados em cada categoria
SELECT ct.cd_categoria, ct.tp_categoria, ct.ds_categoria, ct.dt_inicio, ct.dt_termino, ct.st_categoria, COUNT(s.nr_sac) AS TOTAL_CHAMADOS
    FROM mc_categoria_prod ct
        LEFT JOIN mc_produto p ON ct.cd_categoria = p.cd_categoria
        LEFT JOIN mc_sgv_sac s ON p.cd_produto = s.cd_produto
    GROUP BY ct.cd_categoria, ct.tp_categoria, ct.ds_categoria, ct.dt_inicio, ct.dt_termino, ct.st_categoria
    ORDER BY ct.cd_categoria ASC;
