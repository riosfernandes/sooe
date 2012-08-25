CREATE DATABASE  IF NOT EXISTS `sooe` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sooe`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: sooe
-- ------------------------------------------------------
-- Server version	5.5.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `servico_x_servico`
--

DROP TABLE IF EXISTS `servico_x_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico_x_servico` (
  `servico_pai_id` bigint(20) NOT NULL,
  `servico_filho_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`servico_pai_id`,`servico_filho_id`),
  KEY `fk_Servico_has_Servico_Servico1_idx` (`servico_filho_id`),
  KEY `fk_Servico_has_Servico_Servico_idx` (`servico_pai_id`),
  CONSTRAINT `fk_Servico_has_Servico_Servico` FOREIGN KEY (`servico_pai_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Servico_Servico1` FOREIGN KEY (`servico_filho_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projeto`
--

DROP TABLE IF EXISTS `projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projeto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `projeto_pai_id` bigint(20) DEFAULT NULL,
  `cliente_id` bigint(20) NOT NULL,
  `fase_id` bigint(20) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_Projeto_Projeto1_idx` (`projeto_pai_id`),
  KEY `fk_Projeto_Fases1_idx` (`fase_id`),
  KEY `fk_projeto_cliente1_idx` (`cliente_id`),
  CONSTRAINT `fk_projeto_cliente1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projeto_Fases1` FOREIGN KEY (`fase_id`) REFERENCES `fase_projeto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projeto_Projeto1` FOREIGN KEY (`projeto_pai_id`) REFERENCES `projeto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tributo_x_regiao`
--

DROP TABLE IF EXISTS `tributo_x_regiao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tributo_x_regiao` (
  `tributo_id` bigint(20) NOT NULL,
  `regiao_id` bigint(20) NOT NULL,
  `valor` decimal(5,2) NOT NULL,
  `vigencia` datetime NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tributo_id`,`regiao_id`),
  KEY `fk_insumo_has_regiao_regiao1_idx` (`regiao_id`),
  KEY `fk_insumo_has_regiao_insumo1_idx` (`tributo_id`),
  CONSTRAINT `fk_insumo_has_regiao_insumo1` FOREIGN KEY (`tributo_id`) REFERENCES `tributo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_regiao_regiao1` FOREIGN KEY (`regiao_id`) REFERENCES `regiao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_insumo`
--

DROP TABLE IF EXISTS `tipo_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_insumo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='tbm conhecido como CATEGORIA\nhumano (mão de obra);\nmaterial;';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fase_projeto`
--

DROP TABLE IF EXISTS `fase_projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fase_projeto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='mantem a situação do projeto em fases: \n1.estimativa;\n2.em a';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insumo_x_fornecedor`
--

DROP TABLE IF EXISTS `insumo_x_fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumo_x_fornecedor` (
  `insumo_id` bigint(20) NOT NULL,
  `fornecedor_id` bigint(20) NOT NULL,
  `vigencia` datetime NOT NULL,
  `valor` decimal(18,5) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fornecedor_id`,`insumo_id`),
  KEY `fk_Recurso_has_Fornecedor_Fornecedor1_idx` (`fornecedor_id`),
  KEY `fk_Recurso_has_Fornecedor_Recurso1_idx` (`insumo_id`),
  CONSTRAINT `fk_Recurso_has_Fornecedor_Fornecedor1` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_has_Fornecedor_Recurso1` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tributo_x_servico`
--

DROP TABLE IF EXISTS `tributo_x_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tributo_x_servico` (
  `tributo_id` bigint(20) NOT NULL,
  `servico_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tributo_id`,`servico_id`),
  KEY `fk_insumo_has_servico_servico1_idx` (`servico_id`),
  KEY `fk_insumo_has_servico_insumo1_idx` (`tributo_id`),
  CONSTRAINT `fk_insumo_has_servico_insumo1` FOREIGN KEY (`tributo_id`) REFERENCES `tributo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_servico_servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `familia_id` bigint(20) NOT NULL,
  `grupo_id` bigint(20) NOT NULL,
  `sco` varchar(45) DEFAULT NULL COMMENT 'Cód. SCO: 	 Ex .: AD05.05.0050',
  `fgv` varchar(45) DEFAULT NULL COMMENT 'Cód. FGV:  Ex.: 000001 ',
  `descricao` varchar(700) NOT NULL,
  `percentual_bonificacao` decimal(5,2) DEFAULT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_Servico_Familia1_idx` (`familia_id`),
  KEY `fk_servico_grupo1_idx` (`grupo_id`),
  CONSTRAINT `fk_Servico_Familia1` FOREIGN KEY (`familia_id`) REFERENCES `familia_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_grupo1` FOREIGN KEY (`grupo_id`) REFERENCES `grupo_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tudo que tem preço e unidade de medida. Tbm conhecido como i';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornecedor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_fornecedor_id` bigint(20) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(14) DEFAULT NULL,
  `inscricao_estadual` varchar(12) DEFAULT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_fornecedor_tipo_fornecedor1_idx` (`tipo_fornecedor_id`),
  CONSTRAINT `fk_fornecedor_tipo_fornecedor1` FOREIGN KEY (`tipo_fornecedor_id`) REFERENCES `tipo_fornecedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='ou tabela de preço da onde (rio, sp?)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tributo`
--

DROP TABLE IF EXISTS `tributo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tributo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_unidade_id` bigint(20) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_insumo_tipo_unidade1_idx` (`tipo_unidade_id`),
  CONSTRAINT `fk_insumo_tipo_unidade1` FOREIGN KEY (`tipo_unidade_id`) REFERENCES `tipo_unidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `familia_servico`
--

DROP TABLE IF EXISTS `familia_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `familia_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cla_servico_id` bigint(20) NOT NULL,
  `codigo` char(8) NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_familia_servico` (`cla_servico_id`,`codigo`),
  KEY `fk_familia_servico_cla_servico1_idx` (`cla_servico_id`),
  CONSTRAINT `fk_familia_servico_cla_servico1` FOREIGN KEY (`cla_servico_id`) REFERENCES `cla_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `composicao`
--

DROP TABLE IF EXISTS `composicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `composicao` (
  `servico_id` bigint(20) NOT NULL,
  `insumo_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`servico_id`,`insumo_id`),
  KEY `fk_Servico_has_Recurso_Recurso1_idx` (`insumo_id`),
  KEY `fk_Servico_has_Recurso_Servico1_idx` (`servico_id`),
  CONSTRAINT `fk_Servico_has_Recurso_Recurso1` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Recurso_Servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orcamento_x_servico`
--

DROP TABLE IF EXISTS `orcamento_x_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orcamento_x_servico` (
  `orcamento_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `servico_id` bigint(20) NOT NULL,
  `tipo_custo_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`orcamento_id`,`servico_id`),
  KEY `fk_orcamento_has_servico_servico1_idx` (`servico_id`),
  KEY `fk_orcamento_has_servico_orcamento1_idx` (`orcamento_id`),
  KEY `fk_orcamento_has_servico_tipo_custo1_idx` (`tipo_custo_id`),
  CONSTRAINT `fk_orcamento_has_servico_orcamento1` FOREIGN KEY (`orcamento_id`) REFERENCES `orcamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orcamento_has_servico_servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orcamento_has_servico_tipo_custo1` FOREIGN KEY (`tipo_custo_id`) REFERENCES `tipo_custo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cla_servico`
--

DROP TABLE IF EXISTS `cla_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cla_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `categoria_id` bigint(20) NOT NULL,
  `codigo` char(8) NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_cla_servico_categoria` (`categoria_id`,`codigo`),
  KEY `fk_Cla_Servico_Categoria_Servico1_idx` (`categoria_id`),
  CONSTRAINT `fk_Cla_Servico_Categoria_Servico1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `origem_insumo`
--

DROP TABLE IF EXISTS `origem_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `origem_insumo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_logradouro`
--

DROP TABLE IF EXISTS `tipo_logradouro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_logradouro` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo_usuario_x_usuario`
--

DROP TABLE IF EXISTS `grupo_usuario_x_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_usuario_x_usuario` (
  `usuario_id` bigint(20) NOT NULL,
  `grupo_usuario_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`usuario_id`,`grupo_usuario_id`),
  KEY `fk_grupo_usuario_x_usuario_grupo_usuario1_idx` (`grupo_usuario_id`),
  CONSTRAINT `fk_grupo_usuario_x_usuario_grupo_usuario1` FOREIGN KEY (`grupo_usuario_id`) REFERENCES `grupo_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_usuario_x_usuario_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo_servico`
--

DROP TABLE IF EXISTS `grupo_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grupo_id` bigint(20) DEFAULT NULL,
  `codigo` varchar(10) NOT NULL,
  `descricao` varchar(400) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_grupo_grupo1_idx` (`grupo_id`),
  CONSTRAINT `fk_grupo_grupo1` FOREIGN KEY (`grupo_id`) REFERENCES `grupo_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tributo_x_insumo`
--

DROP TABLE IF EXISTS `tributo_x_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tributo_x_insumo` (
  `tributo_id` bigint(20) NOT NULL,
  `insumo_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tributo_id`,`insumo_id`),
  KEY `fk_insumo_has_recurso_recurso1_idx` (`insumo_id`),
  KEY `fk_insumo_has_recurso_insumo1_idx` (`tributo_id`),
  CONSTRAINT `fk_insumo_has_recurso_insumo1` FOREIGN KEY (`tributo_id`) REFERENCES `tributo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumo_has_recurso_recurso1` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='tipo de usuário: Administrador, Normal etc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente_x_endereco`
--

DROP TABLE IF EXISTS `cliente_x_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente_x_endereco` (
  `cliente_id` bigint(20) NOT NULL,
  `endereco_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cliente_id`,`endereco_id`),
  KEY `fk_cliente_has_endereco_endereco1_idx` (`endereco_id`),
  KEY `fk_cliente_has_endereco_cliente1_idx` (`cliente_id`),
  CONSTRAINT `fk_cliente_has_endereco_cliente1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_endereco_endereco1` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `situacao_usuario`
--

DROP TABLE IF EXISTS `situacao_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situacao_usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='situacao de usuario. Ativo, Inativo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pais_id` bigint(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_estado_pais1_idx` (`pais_id`),
  CONSTRAINT `fk_estado_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_orcamento`
--

DROP TABLE IF EXISTS `tipo_orcamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_orcamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Irá manter a situação do orçamento:\n1. Estimativa;\n2. Venda; e\n3. Execução.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo_usuario`
--

DROP TABLE IF EXISTS `grupo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regiao`
--

DROP TABLE IF EXISTS `regiao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regiao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_fornecedor`
--

DROP TABLE IF EXISTS `tipo_fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_fornecedor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_custo`
--

DROP TABLE IF EXISTS `tipo_custo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_custo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_usuario_id` bigint(20) NOT NULL,
  `situacao_usuario_id` bigint(20) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `login` varchar(12) NOT NULL,
  `email` varchar(45) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `senha_anterior1` varchar(32) DEFAULT NULL,
  `senha_anterior2` varchar(32) DEFAULT NULL,
  `senha_anterior3` varchar(32) DEFAULT NULL,
  `ultima_troca` datetime DEFAULT NULL,
  `ultimo_acesso` datetime DEFAULT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  KEY `fk_usuario_tipo_usuario1_idx` (`tipo_usuario_id`),
  KEY `fk_usuario_situacao1_idx` (`situacao_usuario_id`),
  CONSTRAINT `fk_usuario_situacao1` FOREIGN KEY (`situacao_usuario_id`) REFERENCES `situacao_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_tipo_usuario1` FOREIGN KEY (`tipo_usuario_id`) REFERENCES `tipo_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cidade`
--

DROP TABLE IF EXISTS `cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `estado_id` bigint(20) NOT NULL,
  `regiao_id` bigint(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_cidade_regiao1_idx` (`regiao_id`),
  KEY `fk_cidade_estado1_idx` (`estado_id`),
  CONSTRAINT `fk_cidade_estado1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cidade_regiao1` FOREIGN KEY (`regiao_id`) REFERENCES `regiao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fornecedor_x_endereco`
--

DROP TABLE IF EXISTS `fornecedor_x_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornecedor_x_endereco` (
  `fornecedor_id` bigint(20) NOT NULL,
  `endereco_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`fornecedor_id`,`endereco_id`),
  KEY `fk_fornecedor_x_endereco_endereco1_idx` (`endereco_id`),
  CONSTRAINT `fk_fornecedor_x_endereco_endereco1` FOREIGN KEY (`endereco_id`) REFERENCES `endereco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_x_endereco_fornecedor1` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orcamento`
--

DROP TABLE IF EXISTS `orcamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orcamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `projeto_id` bigint(20) NOT NULL,
  `tipo_orcamento_id` bigint(20) NOT NULL,
  `descricao` varchar(400) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_Servico_has_Projeto_Projeto1_idx` (`projeto_id`),
  KEY `fk_orcamento_situacao_orcamento1_idx` (`tipo_orcamento_id`),
  CONSTRAINT `fk_orcamento_situacao_orcamento1` FOREIGN KEY (`tipo_orcamento_id`) REFERENCES `tipo_orcamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Projeto_Projeto1` FOREIGN KEY (`projeto_id`) REFERENCES `projeto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insumo`
--

DROP TABLE IF EXISTS `insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_recurso_id` bigint(20) NOT NULL,
  `tipo_unidade_id` bigint(20) NOT NULL,
  `origem_insumo_id` bigint(20) NOT NULL,
  `codigo` varchar(45) NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_Recurso_Tipo_Recurso1_idx` (`tipo_recurso_id`),
  KEY `fk_Recurso_Tipo_Unidade1_idx` (`tipo_unidade_id`),
  KEY `fk_insumo_origem_insumo1_idx` (`origem_insumo_id`),
  CONSTRAINT `fk_insumo_origem_insumo1` FOREIGN KEY (`origem_insumo_id`) REFERENCES `origem_insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_Tipo_Recurso1` FOREIGN KEY (`tipo_recurso_id`) REFERENCES `tipo_insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_Tipo_Unidade1` FOREIGN KEY (`tipo_unidade_id`) REFERENCES `tipo_unidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tbm conhecido como item elementar.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_logradouro_id` bigint(20) NOT NULL,
  `cidade_id` bigint(20) NOT NULL,
  `cep` varchar(45) DEFAULT NULL,
  `logradouro` varchar(255) DEFAULT NULL,
  `complemento` varchar(45) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_endereco_tipo_logradouro1_idx` (`tipo_logradouro_id`),
  KEY `fk_endereco_cidade1_idx` (`cidade_id`),
  CONSTRAINT `fk_endereco_cidade1` FOREIGN KEY (`cidade_id`) REFERENCES `cidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_tipo_logradouro1` FOREIGN KEY (`tipo_logradouro_id`) REFERENCES `tipo_logradouro` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categoria_servico`
--

DROP TABLE IF EXISTS `categoria_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo` char(8) NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_unidade`
--

DROP TABLE IF EXISTS `tipo_unidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_unidade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `sigla` varchar(10) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_tipo_unidade` (`sigla`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COMMENT='m3;\nm2;\nkg;\nml;\nh (horas);';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-25 17:43:01
