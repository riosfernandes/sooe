INSERT INTO situacao (descricao) VALUES ('Ativo');
INSERT INTO situacao (descricao) VALUES ('Inativo');

INSERT INTO tipo_usuario (descricao) VALUES ('Administrador');
INSERT INTO tipo_usuario (descricao) VALUES ('Comum');

INSERT INTO usuario (nome, login, email, tipo_usuario_id, situacao_id, senha) 
VALUES ('Adm', 'adm', 'adm@adm.com.br', 1, 1, md5('123') );


INSERT INTO categoria_servico (id, descricao, sigla) VALUES (1, 'categoria01', 'c1');
INSERT INTO categoria_servico (id, descricao, sigla) VALUES (2, 'categoria02', 'c2');

INSERT INTO cla (id, categoria_id, descricao, sigla) VALUES (1,1, 'cla1', '01');
INSERT INTO cla (id, categoria_id, descricao, sigla) VALUES (2, 1,'cla2', '02');

INSERT INTO familia (id, categoria_id, cla_id, descricao, sigla) VALUES (1, 1, 1, 'familia1', '01');

INSERT INTO familia (id, categoria_id, cla_id, descricao, sigla) VALUES (2, 1, 1, 'familia2', '02');


INSERT INTO servico (id, familia_id, cla_id, categoria_id, sco, fgv, descricao) VALUES (1, 1, 1, 1, 'alvenaria com.... etc', 'alv.001.001.000011/', '000011');