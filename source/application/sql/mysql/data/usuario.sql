INSERT INTO situacao (descricao) VALUES ('Ativo');
INSERT INTO situacao (descricao) VALUES ('Inativo');

INSERT INTO tipo_usuario (descricao) VALUES ('Administrador');
INSERT INTO tipo_usuario (descricao) VALUES ('Comum');

INSERT INTO usuario (nome, login, email, tipo_usuario_id, situacao_id, senha) 
VALUES ('Adm', 'adm', 'adm@adm.com.br', 1, 1, md5('123') );
