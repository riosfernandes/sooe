-- ------------------------------------------------------------- --
-- Script para criação e carregamento de dados 2012-07-25 10:08  --
-- ------------------------------------------------------------- --

-- ---------------------------------------------------- --
-- script gerado pelo mysql workbench 2012-07-25 10:08  --
-- ---------------------------------------------------- --
use sooe;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE  TABLE IF NOT EXISTS `sooe`.`Servico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `familia_id` INT(11) NOT NULL ,
  `cla_id` INT(11) NOT NULL ,
  `categoria_id` INT(11) NOT NULL ,
  `sco` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Cód. SCO: 	 Ex .: AD05.05.0050' ,
  `fgv` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Cód. FGV:  Ex.: 000001 ' ,
  `descricao` VARCHAR(700) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`, `familia_id`, `cla_id`, `categoria_id`) ,
  INDEX `fk_Servico_Familia1` (`familia_id` ASC, `cla_id` ASC, `categoria_id` ASC) ,
  CONSTRAINT `fk_Servico_Familia1`
    FOREIGN KEY (`familia_id` , `cla_id` , `categoria_id` )
    REFERENCES `sooe`.`Familia` (`id` , `Cla_id` , `Categoria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'tudo que tem preço e unidade de medida. Tbm conhecido como i' /* comment truncated */;

CREATE  TABLE IF NOT EXISTS `sooe`.`Projeto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `projeto_pai_id` INT(11) NOT NULL ,
  `fase_id` INT(11) NOT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Projeto_Projeto1` (`projeto_pai_id` ASC) ,
  INDEX `fk_Projeto_Fases1` (`fase_id` ASC) ,
  CONSTRAINT `fk_Projeto_Projeto1`
    FOREIGN KEY (`projeto_pai_id` )
    REFERENCES `sooe`.`Projeto` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projeto_Fases1`
    FOREIGN KEY (`fase_id` )
    REFERENCES `sooe`.`Fase` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE  TABLE IF NOT EXISTS `sooe`.`Recurso` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `Tipo_Recurso_id` INT(11) NOT NULL ,
  `Tipo_Unidade_id` INT(11) NOT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`, `Tipo_Recurso_id`, `Tipo_Unidade_id`) ,
  INDEX `fk_Recurso_Tipo_Recurso1` (`Tipo_Recurso_id` ASC) ,
  INDEX `fk_Recurso_Tipo_Unidade1` (`Tipo_Unidade_id` ASC) ,
  CONSTRAINT `fk_Recurso_Tipo_Recurso1`
    FOREIGN KEY (`Tipo_Recurso_id` )
    REFERENCES `sooe`.`Tipo_Recurso` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_Tipo_Unidade1`
    FOREIGN KEY (`Tipo_Unidade_id` )
    REFERENCES `sooe`.`Tipo_Unidade` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'tbm conhecido como item elementar.';

CREATE  TABLE IF NOT EXISTS `sooe`.`Fase` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'mantem a situação do projeto em fases: \n1.estimativa;\n2.em a' /* comment truncated */;

CREATE  TABLE IF NOT EXISTS `sooe`.`Servico_has_Servico` (
  `servico_pai_id` INT(11) NOT NULL ,
  `servico_filho_id` INT(11) NOT NULL ,
  PRIMARY KEY (`servico_pai_id`, `servico_filho_id`) ,
  INDEX `fk_Servico_has_Servico_Servico1` (`servico_filho_id` ASC) ,
  INDEX `fk_Servico_has_Servico_Servico` (`servico_pai_id` ASC) ,
  CONSTRAINT `fk_Servico_has_Servico_Servico`
    FOREIGN KEY (`servico_pai_id` )
    REFERENCES `sooe`.`Servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Servico_Servico1`
    FOREIGN KEY (`servico_filho_id` )
    REFERENCES `sooe`.`Servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE  TABLE IF NOT EXISTS `sooe`.`Atividade` (
  `servico_id` INT(11) NOT NULL ,
  `projeto_id` INT(11) NOT NULL ,
  `percentual_lucro` DECIMAL(5,2) NULL DEFAULT NULL ,
  PRIMARY KEY (`servico_id`, `projeto_id`) ,
  INDEX `fk_Servico_has_Projeto_Projeto1` (`projeto_id` ASC) ,
  INDEX `fk_Servico_has_Projeto_Servico1` (`servico_id` ASC) ,
  CONSTRAINT `fk_Servico_has_Projeto_Servico1`
    FOREIGN KEY (`servico_id` )
    REFERENCES `sooe`.`Servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Projeto_Projeto1`
    FOREIGN KEY (`projeto_id` )
    REFERENCES `sooe`.`Projeto` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE  TABLE IF NOT EXISTS `sooe`.`Composicao` (
  `servico_id` INT(11) NOT NULL ,
  `recurso_id` INT(11) NOT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`servico_id`, `recurso_id`) ,
  INDEX `fk_Servico_has_Recurso_Recurso1` (`recurso_id` ASC) ,
  INDEX `fk_Servico_has_Recurso_Servico1` (`servico_id` ASC) ,
  CONSTRAINT `fk_Servico_has_Recurso_Servico1`
    FOREIGN KEY (`servico_id` )
    REFERENCES `sooe`.`Servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Recurso_Recurso1`
    FOREIGN KEY (`recurso_id` )
    REFERENCES `sooe`.`Recurso` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE  TABLE IF NOT EXISTS `sooe`.`Tipo_Recurso` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'tbm conhecido como CATEGORIA\nhumano (mão de obra);\nmaterial;' /* comment truncated */;

CREATE  TABLE IF NOT EXISTS `sooe`.`Tipo_Unidade` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'm3;\nm2;\nkg;\nml;\nh (horas);';

CREATE  TABLE IF NOT EXISTS `sooe`.`Fornecedor` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'ou tabela de preço da onde (rio, sp?)';

CREATE  TABLE IF NOT EXISTS `sooe`.`Preco` (
  `recurso_id` INT(11) NOT NULL ,
  `fornecedor_id` INT(11) NOT NULL ,
  `vigencia` DATETIME NULL DEFAULT NULL ,
  `valor` DECIMAL(18,5) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`recurso_id`, `fornecedor_id`) ,
  INDEX `fk_Recurso_has_Fornecedor_Fornecedor1` (`fornecedor_id` ASC) ,
  INDEX `fk_Recurso_has_Fornecedor_Recurso1` (`recurso_id` ASC) ,
  CONSTRAINT `fk_Recurso_has_Fornecedor_Recurso1`
    FOREIGN KEY (`recurso_id` )
    REFERENCES `sooe`.`Recurso` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`fornecedor_id` )
    REFERENCES `sooe`.`Fornecedor` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE  TABLE IF NOT EXISTS `sooe`.`Categoria_Servico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  `sigla` CHAR(2) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE  TABLE IF NOT EXISTS `sooe`.`Cla` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `categoria_id` INT(11) NOT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `sigla` CHAR(2) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`, `categoria_id`) ,
  INDEX `fk_Cla_Servico_Categoria_Servico1` (`categoria_id` ASC) ,
  CONSTRAINT `fk_Cla_Servico_Categoria_Servico1`
    FOREIGN KEY (`categoria_id` )
    REFERENCES `sooe`.`Categoria_Servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;

CREATE  TABLE IF NOT EXISTS `sooe`.`Familia` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `Cla_id` INT(11) NOT NULL ,
  `Categoria_id` INT(11) NOT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `sigla` CHAR(2) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`, `Cla_id`, `Categoria_id`) ,
  INDEX `fk_Familia_Cla_Servico1` (`Cla_id` ASC, `Categoria_id` ASC) ,
  CONSTRAINT `fk_Familia_Cla_Servico1`
    FOREIGN KEY (`Cla_id` , `Categoria_id` )
    REFERENCES `sooe`.`Cla` (`id` , `categoria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ----------------------------------------------------- --
--  Script montado manualmente! Atenção ao atualizar.    --
-- ----------------------------------------------------- --

-- cria estrutura para usuario
CREATE  TABLE IF NOT EXISTS `situacao` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'situacao de usuario. Ativo, Inativo';

CREATE  TABLE IF NOT EXISTS `tipo_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = 'tipo de usuário: Administrador, Normal etc';

CREATE  TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `login` VARCHAR(12) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `tipo_usuario_id` INT NOT NULL ,
  `situacao_id` INT NOT NULL ,
  `senha` VARCHAR(32) NOT NULL ,
  `senha_anterior1` VARCHAR(32) NULL ,
  `senha_anterior2` VARCHAR(32) NULL ,
  `senha_anterior3` VARCHAR(32) NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  `ultima_troca` DATETIME NULL ,
  `ultimo_acesso` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) ,
  INDEX `fk_usuario_situacao1` (`situacao_id` ASC) ,
  INDEX `fk_usuario_tipo_usuario1` (`tipo_usuario_id` ASC) ,
  CONSTRAINT `fk_usuario_situacao1`
    FOREIGN KEY (`situacao_id` )
    REFERENCES `situacao` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_id` )
    REFERENCES `tipo_usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_swedish_ci
COMMENT = '';


-- --------------------------------------------------- ---
--                   CARREGAR TABELAS                   --
-- --------------------------------------------------- ---

-- Situação
INSERT INTO situacao (descricao) VALUES ('Ativo');
INSERT INTO situacao (descricao) VALUES ('Inativo');

-- tipo de usuário
INSERT INTO tipo_usuario (descricao) VALUES ('Administrador');
INSERT INTO tipo_usuario (descricao) VALUES ('Comum');

-- usuário
INSERT INTO usuario (nome, login, email, tipo_usuario_id, situacao_id, senha) 
VALUES ('Adm', 'adm', 'adm@adm.com.br', 1, 1, md5('123') );

-- categoria
INSERT INTO categoria_servico (descricao, sigla) VALUES ('categoria01', 'c1');
INSERT INTO categoria_servico (descricao, sigla) VALUES ('categoria02', 'c2');

-- clã
INSERT INTO cla (categoria_id, descricao, sigla) VALUES (1, 'cla1', '01');
INSERT INTO cla (categoria_id, descricao, sigla) VALUES (1,'cla2', '02');

-- familia
INSERT INTO familia (categoria_id, cla_id, descricao, sigla) VALUES (1, 1, 'familia1', '01');
INSERT INTO familia (categoria_id, cla_id, descricao, sigla) VALUES (1, 1, 'familia2', '02');

-- servicos http://www2.rio.rj.gov.br/sco/
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0050 (/)', 'Analise granulometrica sem sedimentacao.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0053 (/)', 'Analise granulometrica completa, em amostra de solo, de acordo com a NBR7181 e NBR6457, compreendendo as fases de peneiramento e sedimentacao, quando constatada a presenca de particulas finas em sua composicao.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0100 (/)', 'Ensaio de adensamento endometrico em amostra de solo, envolvendo, no minimo, 10 estagios de carga, inclusive um laco de descarregamento e recarregamento, de acordo com as recomendacoes estabelecidas na NBR12007.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0150 (/)', 'Ensaio de cizalhamento direto em solo, com, no minimo, 3 niveis de tensao normal aplicada a amostra e com apresentacao das curvas de tensao cisalhante por deslocamento horizontal e deslocamento vertical por deslocamento horizontal, em mm, para cada um dos 3 niveis de tensao.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0200 (/)', 'Ensaio de laboratorio, para determinacao da Densidade Real dos graos de amostra de solo, de acordo com as recomendacoes de preparo descritas na NBR6457.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0250 (/)', 'Ensaio para determinacao, em laboratorio, do Limite de Liquidez de amostra de solo fino, de acordo com as recomendacoes da NBR7180 e da NBR6457.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0300 (/)', 'Ensaio para determinacao, em laboratorio, do Limite de Plasticidade de amostra de solo fino, de acordo com as recomendacoes da NBR7180 e da NBR6457.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0325 (/)', 'Ensaio para determinacao de massa especifica aparente "in situ" (DPTM-92/64).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0350 (/)', 'Ensaio para determinacao, em laboratorio, do Peso Especifico Aparente de amostra de solo, de acordo com as recomendacoes da NBR6457.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0450 (/)', 'Ensaio para determinacao do Indice de Suporte California (CBR) - 3 pontos - obtido com energia Proctor Normal, atraves de, no minimo, 5 corpos de prova, conforme recomendacoes da NBR9895.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0500 (/)', 'Ensaio para determinacao, no campo, da umidade aparente do solo, atraves do Metodo "speedy".');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0550 (/)', 'Ensaio para determinacao da umidade natural de amostras de solo, em laboratorio.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0600 (/)', 'Extracao e acondicionamento de amostra indeformada de solo, com pistao estacionario de 100mm e de acordo com as recomendacoes estabelecidas na NBR9820.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0650 (B)', 'Instalacao de medidor de nivel de agua, inclusive transporte da equipe.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0700 (/)', 'Sondagem manual com pa e picareta, por metro linear ou fracao.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0703 (/)', 'Sondagem manual com trado e cavadeira, por metro linear ou fracao.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.05.0706 (A)', 'Sondagem de reconhecimento, a trado manual, com diametro de 100mm.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.10.0050 (/)', 'Sondagem rotativa vertical, em rocha alterada, com coroa de Widia ou similar, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.10.0100 (/)', 'Sondagem rotativa vertical, em rocha alterada, com coroa de Widia ou similar, diametro N (75mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.10.0150 (/)', 'Sondagem rotativa vertical, em solo, com coroa de Widia ou similar, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.10.0200 (/)', 'Sondagem rotativa vertical, em solo, com coroa de Widia ou similar, diametro N (75mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.15.0050 (/)', 'Sondagem rotativa com Coroa de diamante, em rocha sa, diametro HW, inclinada (qualquer inclinacao diferente da vertical), inclusive deslocamento dentro do canteiro e instalacao da sonda no furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.15.0100 (/)', 'Sondagem rotativa com Coroa de diamante, em rocha sa, diametro NW, inclinada (qualquer inclinacao diferente da vertical), inclusive deslocamento dentro do canteiro e instalacao da sonda no furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.15.0150 (/)', 'Sondagem rotativa vertical, em rocha alterada, com coroa de diamante, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.15.0200 (/)', 'Sondagem rotativa vertical, em rocha alterada, com coroa de diamante, diametro H (99mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.15.0250 (/)', 'Sondagem rotativa vertical, em rocha sa, com coroa de diamante, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.15.0300 (/)', 'Sondagem rotativa vertical, em rocha sa, com coroa de diamante, diametro N (75mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.15.0400 (/)', 'Sondagem rotativa vertical, em rocha sa, com coroa de diamante, diametro H (99mm), inclusive deslocamento e posicionamento em cada furo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 05.20.0050 (/)', 'Sondagem a percussao com diametro ate 3", com ensaio de penetracao (SPT) a cada metro, incluindo relatorio contendo classificacao tatil visual das amostras, perfis individuais dos furos, planta de localizacao e respectivas cotas das sondagens. Inclui deslocamento ate 50m de distancia e instalacao do tripe em cada furo dentro do canteiro, excluindo mobilizacao e desmobilizacao.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 10.05.0050 (/)', 'Marcacao de obra, sem instrumento topografico, considerada a projecao horizontal da area envolvente.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 10.10.0100 (/)', 'Locacao de obra com aparelho topografico, sobre cerca de marcacao, inclusive construcao desta e sua pre-locacao e o fornecimento do material e tendo, por medicao, o perimetro a construir.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.05.0050 (/)', 'Deslocamento, entre furos, de equipamento de sondagem a percurssao, incluindo desmontagem e remontagem.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.10.0050 (/)', 'Carga e descarga de equipamentos pesados em carretas, exclusive o custo horario do equipamento, durante a operacao.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.10.0100 (A)', 'Transporte de andaime suspenso, tipo leve, para pintura, inclusive ida e volta do caminhao, carga e descarga (considerar o minimo de 40unxKm, para calculo deste transporte).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.10.0150 (A)', 'Transporte de andaime suspenso, tipo pesado, para revestimento, inclusive ida e volta do caminhao, carga e descarga (considerar o minimo de 200unxKm, para calculo deste transporte).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.10.0200 (/)', 'Transporte de andaime tubular, considerando-se a area de projecao vertical do andaime, inclusive ida e volta do caminhao, carga e descarga (considerar o minimo de 315m2xKm, para calculo deste transporte).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.10.0250 (/)', 'Transporte de elevador de obras constituido por cabine aberta, com plataforma, guinchos e cabos de 16m de altura.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.10.0300 (/)', 'Transporte de equipamentos pesados em carretas, exclusive a carga e descarga e o custo horario dos equipamentos transportados.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.10.0350 (A)', 'Transporte maritimo de carga de qualquer natureza, exclusive despesas de carga e descarga, no trajeto da Ilha do Governador ate a Ilha de Paqueta ou vice-versa, em embarcacao apropriada (considerar apenas a viagem com a carga).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0050 (C)', 'Caminhoneta de servico, com cabine e cacamba, com motor bicombustivel, cabine simples, com ar condicionado e direcao hidraulica, capacidade de carga minima de 650Kg, tracao 4 x 2, com motorista, material de operacao e material de manutencao. Custo horario produtivo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0100 (B)', 'Caminhoneta de servico, com cabine e cacamba, com motor bicombustivel, cabine simples, com ar condicionado e direcao hidraulica, capacidade de carga minima de 650Kg, tracao 4 x 2, com motorista e material de operacao. Custo horario improdutivo (motor funcionando).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0150 (B)', 'Caminhoneta de servico, com cabine e cacamba, com motor bicombustivel, cabine simples, com ar condicionado e direcao hidraulica, capacidade de carga minima de 650Kg, tracao 4 x 2, com motorista. Custo horario improdutivo (motor desligado).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0200 (/)', 'Caminhoneta de servico, capacidade para 09 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV, modelo Standard. Custo horario diurno (entre 05:00h e 22:00h).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0250 (A)', 'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo horario produtivo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0300 (/)', 'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista e material de operacao, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo horario improdutivo (motor funcionando).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0350 (/)', 'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo horario improdutivo (motor desligado).');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0401 (A)', 'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV, autonomia de 3000Km/mes. Custo mensal.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0403 (A)', 'Caminhoneta de Servico (kilometragem adicional), capacidade para 9 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo do quilometro adicional.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0550 (A)', 'Carreta para transporte pesado, com capacidade de carga util de 60/80t, com motorista operador, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor diesel de 330CV, chassis extensivel ate 21m e semi-reboque de 4 eixos. Custo horario produtivo.');
INSERT INTO servico (familia_id, cla_id, categoria_id, sco, descricao) VALUES (1, 1, 1, 'AD 15.15.0600 (A)', 'Carreta para transporte pesado, com capacidade de carga util de 60/80t, com motorista operador e material de operacao, com as seguintes especificacoes minimas: motor diesel de 330CV, chassis extensivel ate 21m e semi-reboque de 4 eixos. Custo horario improdutivo (motor funcionando).');