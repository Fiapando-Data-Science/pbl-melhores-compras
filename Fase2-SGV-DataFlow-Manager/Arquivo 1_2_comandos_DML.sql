-- Comando SQL Item a) - Inserindo um cliente pessoa física
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, vl_medio_compra, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Daniel Hartman', 5, 250.00, 'A', 'daniel.hart@email.com', '11987654321', 'daniel.hart', 'Oculto999#');

-- Associando esse cliente como pessoa física
INSERT INTO mc_cli_fisica (nr_cliente, dt_nascimento, fl_sexo_biologico, ds_genero, nr_cpf)
VALUES (1, TO_DATE('15-05-1990', 'DD-MM-YYYY'), 'M', 'Masculino', '123.456.789-00');

-- Inserindo um cliente pessoa jurídica
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, vl_medio_compra, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Empresa Teste Ltda', 4, 15000.00, 'A', 'contato@empresateste.com', '1133345566', 'empresa.teste', 'Ordem999#');

-- Associando esse cliente como pessoa jurídica
INSERT INTO mc_cli_juridica (nr_cliente, dt_fundacao, nr_cnpj, nr_inscr_est)
VALUES (2, TO_DATE('01-01-2004', 'DD-MM-YYYY'), '12.345.678/0001-99', '123456789');

-- Inserindo endereços para os clientes
INSERT INTO mc_end_cli (nr_cliente, cd_logradouro_cli, nr_end, ds_complemento_end, dt_inicio, dt_termino, st_end) 
VALUES (1, 1, 638, 'Apartamento 202', TO_DATE('01-01-2025', 'DD-MM-YYYY'), NULL, 'A');

INSERT INTO mc_end_cli (nr_cliente, cd_logradouro_cli, nr_end, ds_complemento_end, dt_inicio, dt_termino, st_end) 
VALUES (2, 2, 1519, 'Próximo a praça', TO_DATE('01-01-2025', 'DD-MM-YYYY'), NULL, 'A');

-- Comando SQL Item b) - Tentativa de cadastrar um cliente com login duplicado
/*
ORA-00001: restrição exclusiva (RM566282.UK_mc_cliente_MM_LOGIN) violada
A tentativa falhou, pois login é ÚNICO
*/
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, vl_medio_compra, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Daniel dos Santos Hartzfield', 3, 100.00, 'A', 'daniel.hart@email.com', '11999998888', 'daniel.hart', 'senha789');


-- Comando SQL Item c) - Atualizar cargo e salário de um funcionário
UPDATE mc_funcionario 
SET ds_cargo = 'Gerente de Projetos', vl_salario = vl_salario * 1.12
WHERE nm_funcionario = 'Picolina Osorio Fortes';

-- Comando SQL Item d) - Atualizar status e data de término de um endereço de cliente
UPDATE mc_end_cli e
SET e.st_end = 'I', 
    e.dt_termino = TO_DATE('25-03-2025', 'DD-MM-YYYY')
WHERE e.cd_logradouro_cli IN (
    SELECT l.cd_logradouro
    FROM mc_logradouro l
    WHERE l.nm_logradouro = 'Rua das Flores'
);


-- Comando SQL Item e) - Tentativa de excluir um estado com cidade cadastrada
/*

Não foi possível deletar um estado que está relacionado com outras tabelas, pois viola diretamente a restrição de integridade.
Assim, seria necessário o comando ON DELETE CASCADE para deletar da forma correta.
Erro de SQL: ORA-02292: restrição de integridade (RM566282.FK_MC_BAIRRO_CIDADE) violada - registro filho localizado

*/

DELETE FROM mc_estado WHERE sg_estado = 'SP';

-- Comando SQL Item f) - Tentativa de atualizar o status de um produto com um valor inválido
/*
ORA-02290: restrição de verificação (RM566282.mc_produto_CK_ST_PROD) violada

*/
UPDATE mc_produto 
SET st_produto = 'X' 
WHERE cd_produto = 1;

-- Comando SQL Item g) - Confirmar todas as transações pendentes
COMMIT;

-- Comandos de população para a parte de DQL
-- Cliente Daniel Hartman (nr_cliente = 1)
INSERT INTO mc_sgv_visualizacao_video (
    nr_cliente, cd_produto, nr_sequencia, dt_visualizacao,
    nr_hora_visualizacao, nr_minuto_video, nr_segundo_video
) VALUES (1, 3, 1, TO_DATE('2025-04-08', 'YYYY-MM-DD'), 18, 0, 30);

INSERT INTO mc_sgv_visualizacao_video (
    nr_cliente, cd_produto, nr_sequencia, dt_visualizacao,
    nr_hora_visualizacao, nr_minuto_video, nr_segundo_video
) VALUES (1, 3, 1, TO_DATE('2025-04-08', 'YYYY-MM-DD'), 19, 1, 10);

-- Adcionando clientes para consulta
-- Cliente 3
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, vl_medio_compra, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Carla Souza', 4, 180.00, 'A', 'carla.souza@email.com', '31988776655', 'carla.souza', 'SenhaForte123!');

INSERT INTO mc_cli_fisica (nr_cliente, dt_nascimento, fl_sexo_biologico, ds_genero, nr_cpf)
VALUES ((select nr_cliente from mc_cliente where nm_login = 'carla.souza'), TO_DATE('22-08-1988', 'DD-MM-YYYY'), 'F', 'Feminino', '321.654.987-00');

INSERT INTO mc_end_cli (nr_cliente, cd_logradouro_cli, nr_end, ds_complemento_end, dt_inicio, dt_termino, st_end)
VALUES ((select nr_cliente from mc_cliente where nm_login = 'carla.souza'), 5, 120, 'Apto 101', TO_DATE('10-03-2024', 'DD-MM-YYYY'), NULL, 'A');

-- Cliente 4
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, vl_medio_compra, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Lucas Ferreira', 3, 95.50, 'A', 'lucas.ferreira@email.com', '11993335577', 'lucas.ferreira', 'Segura456@');

INSERT INTO mc_cli_fisica (nr_cliente, dt_nascimento, fl_sexo_biologico, ds_genero, nr_cpf)
VALUES ((select nr_cliente from mc_cliente where nm_login = 'lucas.ferreira'), TO_DATE('02-11-1995', 'DD-MM-YYYY'), 'M', 'Masculino', '456.789.123-00');

INSERT INTO mc_end_cli (nr_cliente, cd_logradouro_cli, nr_end, ds_complemento_end, dt_inicio, dt_termino, st_end)
VALUES ((select nr_cliente from mc_cliente where nm_login = 'lucas.ferreira'), 3, 480, NULL, TO_DATE('01-06-2023', 'DD-MM-YYYY'), NULL, 'A');

-- Cliente 5
INSERT INTO mc_cliente (nm_cliente, qt_estrelas, vl_medio_compra, st_cliente, ds_email, nr_telefone, nm_login, ds_senha)
VALUES ('Marina Lopes', 5, 320.75, 'A', 'marina.lopes@email.com', '32999887766', 'marina.lopes', 'MarinaTop789!');

INSERT INTO mc_cli_fisica (nr_cliente, dt_nascimento, fl_sexo_biologico, ds_genero, nr_cpf)
VALUES ((select nr_cliente from mc_cliente where nm_login = 'marina.lopes'), TO_DATE('09-01-1985', 'DD-MM-YYYY'), 'F', 'Feminino', '789.123.456-00');

INSERT INTO mc_end_cli (nr_cliente, cd_logradouro_cli, nr_end, ds_complemento_end, dt_inicio, dt_termino, st_end)
VALUES ((select nr_cliente from mc_cliente where nm_login = 'marina.lopes'), 8, 300, 'Bloco B, Apto 302', TO_DATE('15-09-2022', 'DD-MM-YYYY'), NULL, 'A');


-- Comitando novamente
COMMIT;
