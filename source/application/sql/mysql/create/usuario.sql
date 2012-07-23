CREATE  TABLE IF NOT EXISTS `situacao` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) );

CREATE  TABLE IF NOT EXISTS `tipo_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `descricao` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) );

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
    ON UPDATE NO ACTION);
