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
