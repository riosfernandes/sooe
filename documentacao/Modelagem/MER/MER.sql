SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `sooe` DEFAULT CHARACTER SET latin1 ;
USE `sooe` ;

-- -----------------------------------------------------
-- Table `sooe`.`fase`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`fase` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'mantem a situação do projeto em fases: \n1.estimativa;\n2.em a';


-- -----------------------------------------------------
-- Table `sooe`.`cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`cliente` (
  `id` BIGINT NOT NULL ,
  `nome` VARCHAR(200) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`projeto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`projeto` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `projeto_pai_id` BIGINT NULL DEFAULT NULL ,
  `cliente_id` BIGINT NOT NULL ,
  `fase_id` BIGINT NOT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `percentual_bonificacao` DECIMAL(5,2) NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Projeto_Projeto1` (`projeto_pai_id` ASC) ,
  INDEX `fk_Projeto_Fases1` (`fase_id` ASC) ,
  INDEX `fk_projeto_cliente1` (`cliente_id` ASC) ,
  CONSTRAINT `fk_Projeto_Projeto1`
    FOREIGN KEY (`projeto_pai_id` )
    REFERENCES `sooe`.`projeto` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projeto_Fases1`
    FOREIGN KEY (`fase_id` )
    REFERENCES `sooe`.`fase` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projeto_cliente1`
    FOREIGN KEY (`cliente_id` )
    REFERENCES `sooe`.`cliente` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`tipo_orcamento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tipo_orcamento` (
  `id` BIGINT NOT NULL ,
  `descricao` VARCHAR(45) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Irá manter a situação do orçamento:\n1. Estimativa;\n2. Venda;' /* comment truncated */;


-- -----------------------------------------------------
-- Table `sooe`.`orcamento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`orcamento` (
  `id` BIGINT NOT NULL ,
  `projeto_id` BIGINT NOT NULL ,
  `tipo_orcamento_id` BIGINT NOT NULL ,
  `descricao` VARCHAR(400) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Servico_has_Projeto_Projeto1` (`projeto_id` ASC) ,
  INDEX `fk_orcamento_situacao_orcamento1` (`tipo_orcamento_id` ASC) ,
  CONSTRAINT `fk_Servico_has_Projeto_Projeto1`
    FOREIGN KEY (`projeto_id` )
    REFERENCES `sooe`.`projeto` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orcamento_situacao_orcamento1`
    FOREIGN KEY (`tipo_orcamento_id` )
    REFERENCES `sooe`.`tipo_orcamento` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`categoria_servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`categoria_servico` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `sigla` CHAR(2) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`cla_servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`cla_servico` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `categoria_id` BIGINT NOT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `sigla` CHAR(2) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Cla_Servico_Categoria_Servico1` (`categoria_id` ASC) ,
  CONSTRAINT `fk_Cla_Servico_Categoria_Servico1`
    FOREIGN KEY (`categoria_id` )
    REFERENCES `sooe`.`categoria_servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`familia_servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`familia_servico` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `Cla_id` BIGINT NOT NULL ,
  `Categoria_id` BIGINT NOT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `sigla` CHAR(2) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Familia_Cla_Servico1` (`Cla_id` ASC, `Categoria_id` ASC) ,
  CONSTRAINT `fk_Familia_Cla_Servico1`
    FOREIGN KEY (`Cla_id` , `Categoria_id` )
    REFERENCES `sooe`.`cla_servico` (`id` , `categoria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`grupo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`grupo` (
  `id` BIGINT NOT NULL ,
  `grupo_id` BIGINT NULL ,
  `descricao` VARCHAR(400) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_grupo_grupo1` (`grupo_id` ASC) ,
  CONSTRAINT `fk_grupo_grupo1`
    FOREIGN KEY (`grupo_id` )
    REFERENCES `sooe`.`grupo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`servico` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `familia_id` BIGINT NOT NULL ,
  `cla_id` BIGINT NOT NULL ,
  `categoria_id` BIGINT NOT NULL ,
  `grupo_id` BIGINT NOT NULL ,
  `sco` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Cód. SCO: 	 Ex .: AD05.05.0050' ,
  `fgv` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Cód. FGV:  Ex.: 000001 ' ,
  `descricao` VARCHAR(700) NULL DEFAULT NULL ,
  `percentual_bonificacao` DECIMAL(5,2) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Servico_Familia1` (`familia_id` ASC, `cla_id` ASC, `categoria_id` ASC) ,
  INDEX `fk_servico_grupo1` (`grupo_id` ASC) ,
  CONSTRAINT `fk_Servico_Familia1`
    FOREIGN KEY (`familia_id` , `cla_id` , `categoria_id` )
    REFERENCES `sooe`.`familia_servico` (`id` , `Cla_id` , `Categoria_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_grupo1`
    FOREIGN KEY (`grupo_id` )
    REFERENCES `sooe`.`grupo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 51
DEFAULT CHARACTER SET = latin1
COMMENT = 'tudo que tem preço e unidade de medida. Tbm conhecido como i';


-- -----------------------------------------------------
-- Table `sooe`.`tipo_recurso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tipo_recurso` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'tbm conhecido como CATEGORIA\nhumano (mão de obra);\nmaterial;';


-- -----------------------------------------------------
-- Table `sooe`.`tipo_unidade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tipo_unidade` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'm3;\nm2;\nkg;\nml;\nh (horas);';


-- -----------------------------------------------------
-- Table `sooe`.`insumo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`insumo` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `Tipo_Recurso_id` BIGINT NOT NULL ,
  `Tipo_Unidade_id` BIGINT NOT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Recurso_Tipo_Recurso1` (`Tipo_Recurso_id` ASC) ,
  INDEX `fk_Recurso_Tipo_Unidade1` (`Tipo_Unidade_id` ASC) ,
  CONSTRAINT `fk_Recurso_Tipo_Recurso1`
    FOREIGN KEY (`Tipo_Recurso_id` )
    REFERENCES `sooe`.`tipo_recurso` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_Tipo_Unidade1`
    FOREIGN KEY (`Tipo_Unidade_id` )
    REFERENCES `sooe`.`tipo_unidade` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'tbm conhecido como item elementar.';


-- -----------------------------------------------------
-- Table `sooe`.`composicao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`composicao` (
  `servico_id` BIGINT NOT NULL ,
  `insumo_id` BIGINT NOT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`servico_id`, `insumo_id`) ,
  INDEX `fk_Servico_has_Recurso_Recurso1` (`insumo_id` ASC) ,
  INDEX `fk_Servico_has_Recurso_Servico1` (`servico_id` ASC) ,
  CONSTRAINT `fk_Servico_has_Recurso_Servico1`
    FOREIGN KEY (`servico_id` )
    REFERENCES `sooe`.`servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Recurso_Recurso1`
    FOREIGN KEY (`insumo_id` )
    REFERENCES `sooe`.`insumo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`fornecedor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`fornecedor` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  `descricao` VARCHAR(45) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'ou tabela de preço da onde (rio, sp?)';


-- -----------------------------------------------------
-- Table `sooe`.`preco_insumo_fornecedor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`preco_insumo_fornecedor` (
  `insumo_id` BIGINT NOT NULL ,
  `fornecedor_id` BIGINT NOT NULL ,
  `vigencia` DATETIME NULL DEFAULT NULL ,
  `valor` DECIMAL(18,5) NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT NULL ,
  PRIMARY KEY (`fornecedor_id`, `insumo_id`) ,
  INDEX `fk_Recurso_has_Fornecedor_Fornecedor1` (`fornecedor_id` ASC) ,
  INDEX `fk_Recurso_has_Fornecedor_Recurso1` (`insumo_id` ASC) ,
  CONSTRAINT `fk_Recurso_has_Fornecedor_Recurso1`
    FOREIGN KEY (`insumo_id` )
    REFERENCES `sooe`.`insumo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`fornecedor_id` )
    REFERENCES `sooe`.`fornecedor` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`servico_has_servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`servico_has_servico` (
  `servico_pai_id` BIGINT NOT NULL ,
  `servico_filho_id` BIGINT NOT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`servico_pai_id`, `servico_filho_id`) ,
  INDEX `fk_Servico_has_Servico_Servico1` (`servico_filho_id` ASC) ,
  INDEX `fk_Servico_has_Servico_Servico` (`servico_pai_id` ASC) ,
  CONSTRAINT `fk_Servico_has_Servico_Servico`
    FOREIGN KEY (`servico_pai_id` )
    REFERENCES `sooe`.`servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Servico_Servico1`
    FOREIGN KEY (`servico_filho_id` )
    REFERENCES `sooe`.`servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`situacao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`situacao` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NOT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1
COMMENT = 'situacao de usuario. Ativo, Inativo';


-- -----------------------------------------------------
-- Table `sooe`.`tipo_usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tipo_usuario` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NOT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1
COMMENT = 'tipo de usuário: Administrador, Normal etc';


-- -----------------------------------------------------
-- Table `sooe`.`usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`usuario` (
  `id` BIGINT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NOT NULL ,
  `login` VARCHAR(12) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `tipo_usuario_id` INT(11) NOT NULL ,
  `situacao_id` INT(11) NOT NULL ,
  `senha` VARCHAR(32) NOT NULL ,
  `senha_anterior1` VARCHAR(32) NULL DEFAULT NULL ,
  `senha_anterior2` VARCHAR(32) NULL DEFAULT NULL ,
  `senha_anterior3` VARCHAR(32) NULL DEFAULT NULL ,
  `ultima_troca` DATETIME NULL DEFAULT NULL ,
  `ultimo_acesso` DATETIME NULL DEFAULT NULL ,
  `cadastro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) ,
  INDEX `fk_usuario_situacao1` (`situacao_id` ASC) ,
  INDEX `fk_usuario_tipo_usuario1` (`tipo_usuario_id` ASC) ,
  CONSTRAINT `fk_usuario_situacao1`
    FOREIGN KEY (`situacao_id` )
    REFERENCES `sooe`.`situacao` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_id` )
    REFERENCES `sooe`.`tipo_usuario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`tipo_logradouro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tipo_logradouro` (
  `id` BIGINT NOT NULL ,
  `descricao` VARCHAR(45) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`pais`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`pais` (
  `id` BIGINT NOT NULL ,
  `nome` VARCHAR(100) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`estado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`estado` (
  `id` BIGINT NOT NULL ,
  `pais_id` BIGINT NOT NULL ,
  `nome` VARCHAR(100) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_estado_pais1` (`pais_id` ASC) ,
  CONSTRAINT `fk_estado_pais1`
    FOREIGN KEY (`pais_id` )
    REFERENCES `sooe`.`pais` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`regiao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`regiao` (
  `id` BIGINT NOT NULL ,
  `nome` VARCHAR(100) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`cidade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`cidade` (
  `id` BIGINT NOT NULL ,
  `estado_id` BIGINT NOT NULL ,
  `pais_id` BIGINT NOT NULL ,
  `regiao_id` BIGINT NOT NULL ,
  `nome` VARCHAR(100) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cidade_estado1` (`estado_id` ASC, `pais_id` ASC) ,
  INDEX `fk_cidade_regiao1` (`regiao_id` ASC) ,
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado_id` , `pais_id` )
    REFERENCES `sooe`.`estado` (`id` , `pais_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cidade_regiao1`
    FOREIGN KEY (`regiao_id` )
    REFERENCES `sooe`.`regiao` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`endereco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`endereco` (
  `id` BIGINT NOT NULL ,
  `tipo_logradouro_id` BIGINT NOT NULL ,
  `cidade_id` BIGINT NOT NULL ,
  `cep` VARCHAR(45) NULL ,
  `logradouro` VARCHAR(255) NULL ,
  `complemento` VARCHAR(45) NULL ,
  `numero` VARCHAR(10) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_endereco_tipo_logradouro1` (`tipo_logradouro_id` ASC) ,
  INDEX `fk_endereco_cidade1` (`cidade_id` ASC) ,
  CONSTRAINT `fk_endereco_tipo_logradouro1`
    FOREIGN KEY (`tipo_logradouro_id` )
    REFERENCES `sooe`.`tipo_logradouro` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_cidade1`
    FOREIGN KEY (`cidade_id` )
    REFERENCES `sooe`.`cidade` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`cliente_has_endereco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`cliente_has_endereco` (
  `cliente_id` BIGINT NOT NULL ,
  `endereco_id` BIGINT NOT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`cliente_id`, `endereco_id`) ,
  INDEX `fk_cliente_has_endereco_endereco1` (`endereco_id` ASC) ,
  INDEX `fk_cliente_has_endereco_cliente1` (`cliente_id` ASC) ,
  CONSTRAINT `fk_cliente_has_endereco_cliente1`
    FOREIGN KEY (`cliente_id` )
    REFERENCES `sooe`.`cliente` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_endereco_endereco1`
    FOREIGN KEY (`endereco_id` )
    REFERENCES `sooe`.`endereco` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`tipo_custo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tipo_custo` (
  `id` BIGINT NOT NULL ,
  `descricao` VARCHAR(255) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`orcamento_has_servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`orcamento_has_servico` (
  `orcamento_id` BIGINT NOT NULL ,
  `servico_id` BIGINT NOT NULL ,
  `tipo_custo_id` BIGINT NOT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`orcamento_id`, `servico_id`) ,
  INDEX `fk_orcamento_has_servico_servico1` (`servico_id` ASC) ,
  INDEX `fk_orcamento_has_servico_orcamento1` (`orcamento_id` ASC) ,
  INDEX `fk_orcamento_has_servico_tipo_custo1` (`tipo_custo_id` ASC) ,
  CONSTRAINT `fk_orcamento_has_servico_orcamento1`
    FOREIGN KEY (`orcamento_id` )
    REFERENCES `sooe`.`orcamento` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orcamento_has_servico_servico1`
    FOREIGN KEY (`servico_id` )
    REFERENCES `sooe`.`servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orcamento_has_servico_tipo_custo1`
    FOREIGN KEY (`tipo_custo_id` )
    REFERENCES `sooe`.`tipo_custo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`fornecedor_has_endereco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`fornecedor_has_endereco` (
  `fornecedor_id` BIGINT NOT NULL ,
  `endereco_id` BIGINT NOT NULL ,
  PRIMARY KEY (`fornecedor_id`, `endereco_id`) ,
  INDEX `fk_fornecedor_has_endereco_endereco1` (`endereco_id` ASC) ,
  INDEX `fk_fornecedor_has_endereco_fornecedor1` (`fornecedor_id` ASC) ,
  CONSTRAINT `fk_fornecedor_has_endereco_fornecedor1`
    FOREIGN KEY (`fornecedor_id` )
    REFERENCES `sooe`.`fornecedor` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_has_endereco_endereco1`
    FOREIGN KEY (`endereco_id` )
    REFERENCES `sooe`.`endereco` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `sooe`.`tributo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tributo` (
  `id` BIGINT NOT NULL ,
  `tipo_unidade_id` BIGINT NOT NULL ,
  `descricao` VARCHAR(255) NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_insumo_tipo_unidade1` (`tipo_unidade_id` ASC) ,
  CONSTRAINT `fk_insumo_tipo_unidade1`
    FOREIGN KEY (`tipo_unidade_id` )
    REFERENCES `sooe`.`tipo_unidade` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`tributo_has_insumo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tributo_has_insumo` (
  `tributo_id` BIGINT NOT NULL ,
  `insumo_id` BIGINT NOT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`tributo_id`, `insumo_id`) ,
  INDEX `fk_insumo_has_recurso_recurso1` (`insumo_id` ASC) ,
  INDEX `fk_insumo_has_recurso_insumo1` (`tributo_id` ASC) ,
  CONSTRAINT `fk_insumo_has_recurso_insumo1`
    FOREIGN KEY (`tributo_id` )
    REFERENCES `sooe`.`tributo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_recurso_recurso1`
    FOREIGN KEY (`insumo_id` )
    REFERENCES `sooe`.`insumo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`preco_tributo_regiao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`preco_tributo_regiao` (
  `tributo_id` BIGINT NOT NULL ,
  `regiao_id` BIGINT NOT NULL ,
  `valor` DECIMAL(5,2) NULL ,
  `vigencia` DATETIME NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`tributo_id`, `regiao_id`) ,
  INDEX `fk_insumo_has_regiao_regiao1` (`regiao_id` ASC) ,
  INDEX `fk_insumo_has_regiao_insumo1` (`tributo_id` ASC) ,
  CONSTRAINT `fk_insumo_has_regiao_insumo1`
    FOREIGN KEY (`tributo_id` )
    REFERENCES `sooe`.`tributo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_regiao_regiao1`
    FOREIGN KEY (`regiao_id` )
    REFERENCES `sooe`.`regiao` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sooe`.`tributo_has_servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `sooe`.`tributo_has_servico` (
  `tributo_id` BIGINT NOT NULL ,
  `servico_id` BIGINT NOT NULL ,
  `cadastro` TIMESTAMP NULL ,
  PRIMARY KEY (`tributo_id`, `servico_id`) ,
  INDEX `fk_insumo_has_servico_servico1` (`servico_id` ASC) ,
  INDEX `fk_insumo_has_servico_insumo1` (`tributo_id` ASC) ,
  CONSTRAINT `fk_insumo_has_servico_insumo1`
    FOREIGN KEY (`tributo_id` )
    REFERENCES `sooe`.`tributo` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_servico_servico1`
    FOREIGN KEY (`servico_id` )
    REFERENCES `sooe`.`servico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
