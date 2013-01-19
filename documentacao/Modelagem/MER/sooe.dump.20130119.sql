CREATE DATABASE  IF NOT EXISTS `sooe` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sooe`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: sooe
-- ------------------------------------------------------
-- Server version	5.5.24-log

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
-- Dumping data for table `servico_x_servico`
--

LOCK TABLES `servico_x_servico` WRITE;
/*!40000 ALTER TABLE `servico_x_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `servico_x_servico` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipo_insumo`
--

LOCK TABLES `tipo_insumo` WRITE;
/*!40000 ALTER TABLE `tipo_insumo` DISABLE KEYS */;
INSERT INTO `tipo_insumo` VALUES (1,'Material','2012-09-04 21:19:43'),(2,'Equipamento','2012-09-04 21:20:21'),(3,'Mão de Obra','2012-09-04 21:20:25');
/*!40000 ALTER TABLE `tipo_insumo` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='mantem a situação do projeto em fases: \n1.estimativa;\n2.em a';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fase_projeto`
--

LOCK TABLES `fase_projeto` WRITE;
/*!40000 ALTER TABLE `fase_projeto` DISABLE KEYS */;
/*!40000 ALTER TABLE `fase_projeto` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `insumo_x_fornecedor`
--

LOCK TABLES `insumo_x_fornecedor` WRITE;
/*!40000 ALTER TABLE `insumo_x_fornecedor` DISABLE KEYS */;
INSERT INTO `insumo_x_fornecedor` VALUES (1,1,'2013-01-01 00:00:00',3.40000,'2013-01-14 23:26:00');
/*!40000 ALTER TABLE `insumo_x_fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

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
  `codigo` varchar(20) NOT NULL,
  `descricao` varchar(700) NOT NULL,
  `percentual_bonificacao` decimal(5,2) DEFAULT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `fk_Servico_Familia1_idx` (`familia_id`),
  KEY `fk_servico_grupo1_idx` (`grupo_id`),
  CONSTRAINT `fk_Servico_Familia1` FOREIGN KEY (`familia_id`) REFERENCES `familia_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_grupo1` FOREIGN KEY (`grupo_id`) REFERENCES `grupo_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tudo que tem preço e unidade de medida. Tbm conhecido como i';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornecedor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_fornecedor_id` bigint(20) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(14) DEFAULT NULL,
  `inscricao_estadual` varchar(12) DEFAULT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `fk_fornecedor_tipo_fornecedor1_idx` (`tipo_fornecedor_id`),
  CONSTRAINT `fk_fornecedor_tipo_fornecedor1` FOREIGN KEY (`tipo_fornecedor_id`) REFERENCES `tipo_fornecedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='ou tabela de preço da onde (rio, sp?)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
INSERT INTO `fornecedor` VALUES (1,1,'0010001','Casa Rosada Material de Construção',NULL,NULL,'2013-01-14 23:26:00'),(2,1,'0010002','Leroy Merlin',NULL,NULL,'2013-01-14 23:26:00'),(3,3,'0030001','Casa Cor',NULL,NULL,'2013-01-14 23:26:00'),(4,3,'0030002','Deca',NULL,NULL,'2013-01-14 23:26:00');
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familia_servico`
--

DROP TABLE IF EXISTS `familia_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `familia_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cla_servico_id` bigint(20) NOT NULL,
  `codigo` varchar(8) NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_familia_servico` (`cla_servico_id`,`codigo`),
  KEY `fk_familia_servico_cla_servico1_idx` (`cla_servico_id`),
  CONSTRAINT `fk_familia_servico_cla_servico1` FOREIGN KEY (`cla_servico_id`) REFERENCES `cla_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familia_servico`
--

LOCK TABLES `familia_servico` WRITE;
/*!40000 ALTER TABLE `familia_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `familia_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variavel_custo`
--

DROP TABLE IF EXISTS `variavel_custo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variavel_custo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_unidade_id` bigint(20) NOT NULL,
  `tipo_variavel_custo_id` bigint(20) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `fk_insumo_tipo_unidade1_idx` (`tipo_unidade_id`),
  KEY `fk_variavel_custo_tipo_variavel_custo1_idx` (`tipo_variavel_custo_id`),
  CONSTRAINT `fk_variavel_custo_tipo_variavel_custo1` FOREIGN KEY (`tipo_variavel_custo_id`) REFERENCES `tipo_variavel_custo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variavel_custo`
--

LOCK TABLES `variavel_custo` WRITE;
/*!40000 ALTER TABLE `variavel_custo` DISABLE KEYS */;
/*!40000 ALTER TABLE `variavel_custo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variavel_custo_x_servico`
--

DROP TABLE IF EXISTS `variavel_custo_x_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variavel_custo_x_servico` (
  `variavel_custo_id` bigint(20) NOT NULL,
  `servico_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`variavel_custo_id`,`servico_id`),
  KEY `fk_insumo_has_servico_servico1_idx` (`servico_id`),
  KEY `fk_insumo_has_servico_insumo1_idx` (`variavel_custo_id`),
  CONSTRAINT `fk_insumo_has_servico_insumo1` FOREIGN KEY (`variavel_custo_id`) REFERENCES `variavel_custo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variavel_custo_x_servico`
--

LOCK TABLES `variavel_custo_x_servico` WRITE;
/*!40000 ALTER TABLE `variavel_custo_x_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `variavel_custo_x_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composicao`
--

DROP TABLE IF EXISTS `composicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `composicao` (
  `servico_id` bigint(20) NOT NULL,
  `insumo_id` bigint(20) NOT NULL,
  `qtde` decimal(18,4) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`servico_id`,`insumo_id`),
  KEY `fk_Servico_has_Recurso_Recurso1_idx` (`insumo_id`),
  KEY `fk_Servico_has_Recurso_Servico1_idx` (`servico_id`),
  CONSTRAINT `fk_Servico_has_Recurso_Recurso1` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Recurso_Servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composicao`
--

LOCK TABLES `composicao` WRITE;
/*!40000 ALTER TABLE `composicao` DISABLE KEYS */;
/*!40000 ALTER TABLE `composicao` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `orcamento_x_servico`
--

LOCK TABLES `orcamento_x_servico` WRITE;
/*!40000 ALTER TABLE `orcamento_x_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `orcamento_x_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cla_servico`
--

DROP TABLE IF EXISTS `cla_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cla_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `categoria_id` bigint(20) NOT NULL,
  `codigo` varchar(8) NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `un_cla_servico_categoria` (`categoria_id`,`codigo`),
  KEY `fk_Cla_Servico_Categoria_Servico1_idx` (`categoria_id`),
  CONSTRAINT `fk_Cla_Servico_Categoria_Servico1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cla_servico`
--

LOCK TABLES `cla_servico` WRITE;
/*!40000 ALTER TABLE `cla_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `cla_servico` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `origem_insumo`
--

LOCK TABLES `origem_insumo` WRITE;
/*!40000 ALTER TABLE `origem_insumo` DISABLE KEYS */;
INSERT INTO `origem_insumo` VALUES (1,'Própria',NULL),(2,'Terceirizado',NULL);
/*!40000 ALTER TABLE `origem_insumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custo_indireto_x_composicao`
--

DROP TABLE IF EXISTS `custo_indireto_x_composicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custo_indireto_x_composicao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `composicao_servico_id` bigint(20) NOT NULL,
  `composicao_insumo_id` bigint(20) NOT NULL,
  `qtde_unid_custo_indireto` decimal(18,4) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_custo_indireto_x_composicao_composicao1_idx` (`composicao_servico_id`,`composicao_insumo_id`),
  CONSTRAINT `fk_custo_indireto_x_composicao_composicao1` FOREIGN KEY (`composicao_servico_id`, `composicao_insumo_id`) REFERENCES `composicao` (`servico_id`, `insumo_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custo_indireto_x_composicao`
--

LOCK TABLES `custo_indireto_x_composicao` WRITE;
/*!40000 ALTER TABLE `custo_indireto_x_composicao` DISABLE KEYS */;
/*!40000 ALTER TABLE `custo_indireto_x_composicao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variavel_custo_x_insumo`
--

DROP TABLE IF EXISTS `variavel_custo_x_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variavel_custo_x_insumo` (
  `variavel_custo_id` bigint(20) NOT NULL,
  `insumo_id` bigint(20) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`variavel_custo_id`,`insumo_id`),
  KEY `fk_insumo_has_recurso_recurso1_idx` (`insumo_id`),
  KEY `fk_insumo_has_recurso_insumo1_idx` (`variavel_custo_id`),
  CONSTRAINT `fk_insumo_has_recurso_insumo1` FOREIGN KEY (`variavel_custo_id`) REFERENCES `variavel_custo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variavel_custo_x_insumo`
--

LOCK TABLES `variavel_custo_x_insumo` WRITE;
/*!40000 ALTER TABLE `variavel_custo_x_insumo` DISABLE KEYS */;
/*!40000 ALTER TABLE `variavel_custo_x_insumo` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipo_logradouro`
--

LOCK TABLES `tipo_logradouro` WRITE;
/*!40000 ALTER TABLE `tipo_logradouro` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_logradouro` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `grupo_usuario_x_usuario`
--

LOCK TABLES `grupo_usuario_x_usuario` WRITE;
/*!40000 ALTER TABLE `grupo_usuario_x_usuario` DISABLE KEYS */;
INSERT INTO `grupo_usuario_x_usuario` VALUES (1,1,'2012-08-29 17:03:32'),(6,1,'2012-08-29 13:44:59'),(6,3,'2012-08-29 13:44:59'),(7,1,'2012-08-29 21:24:34'),(8,2,'2012-08-30 15:23:10');
/*!40000 ALTER TABLE `grupo_usuario_x_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regiao`
--

DROP TABLE IF EXISTS `regiao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regiao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regiao`
--

LOCK TABLES `regiao` WRITE;
/*!40000 ALTER TABLE `regiao` DISABLE KEYS */;
/*!40000 ALTER TABLE `regiao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_servico`
--

DROP TABLE IF EXISTS `grupo_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `grupo_id` bigint(20) DEFAULT NULL,
  `codigo` varchar(20) NOT NULL,
  `descricao` varchar(400) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `fk_grupo_grupo1_idx` (`grupo_id`),
  CONSTRAINT `fk_grupo_grupo1` FOREIGN KEY (`grupo_id`) REFERENCES `grupo_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_servico`
--

LOCK TABLES `grupo_servico` WRITE;
/*!40000 ALTER TABLE `grupo_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custo_indireto_composicao_x_insumo`
--

DROP TABLE IF EXISTS `custo_indireto_composicao_x_insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custo_indireto_composicao_x_insumo` (
  `custo_indireto_composicao_id` bigint(20) NOT NULL,
  `insumo_id` bigint(20) NOT NULL,
  `qtde` decimal(18,4) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`custo_indireto_composicao_id`,`insumo_id`),
  KEY `fk_custo_indireto_x_composicao_has_insumo_insumo1_idx` (`insumo_id`),
  KEY `fk_custo_indireto_x_composicao_has_insumo_custo_indireto_x__idx` (`custo_indireto_composicao_id`),
  CONSTRAINT `fk_custo_indireto_x_composicao_has_insumo_custo_indireto_x_co1` FOREIGN KEY (`custo_indireto_composicao_id`) REFERENCES `custo_indireto_x_composicao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_custo_indireto_x_composicao_has_insumo_insumo1` FOREIGN KEY (`insumo_id`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custo_indireto_composicao_x_insumo`
--

LOCK TABLES `custo_indireto_composicao_x_insumo` WRITE;
/*!40000 ALTER TABLE `custo_indireto_composicao_x_insumo` DISABLE KEYS */;
/*!40000 ALTER TABLE `custo_indireto_composicao_x_insumo` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` VALUES (1,'Administrador','2012-08-25 21:06:58'),(2,'Comum','2012-08-25 21:06:58');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `cliente_x_endereco`
--

LOCK TABLES `cliente_x_endereco` WRITE;
/*!40000 ALTER TABLE `cliente_x_endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_x_endereco` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `situacao_usuario`
--

LOCK TABLES `situacao_usuario` WRITE;
/*!40000 ALTER TABLE `situacao_usuario` DISABLE KEYS */;
INSERT INTO `situacao_usuario` VALUES (1,'Ativo','2012-08-25 21:06:58'),(2,'Inativo','2012-08-25 21:06:58'),(3,'Novo','2012-08-27 13:05:32');
/*!40000 ALTER TABLE `situacao_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `sigla` varchar(5) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sigla_UNIQUE` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

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
  `sigla` varchar(5) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sigla_UNIQUE` (`sigla`),
  KEY `fk_estado_pais1_idx` (`pais_id`),
  CONSTRAINT `fk_estado_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Irá manter a situação do orçamento:\n1. Estimativa;\n2. Venda; e\n3. Execução.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_orcamento`
--

LOCK TABLES `tipo_orcamento` WRITE;
/*!40000 ALTER TABLE `tipo_orcamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_orcamento` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_usuario`
--

LOCK TABLES `grupo_usuario` WRITE;
/*!40000 ALTER TABLE `grupo_usuario` DISABLE KEYS */;
INSERT INTO `grupo_usuario` VALUES (1,'Administrador','2012-08-25 21:36:10'),(2,'Operador','2012-08-25 21:36:31'),(3,'Engenheiros','2012-08-25 22:07:11'),(4,'Compras','2012-08-25 22:07:15'),(5,'Orçamentos','2012-08-25 22:07:23'),(6,'Auditores','2012-08-25 22:07:36');
/*!40000 ALTER TABLE `grupo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_variavel_custo`
--

DROP TABLE IF EXISTS `tipo_variavel_custo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_variavel_custo` (
  `id` bigint(20) NOT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_variavel_custo`
--

LOCK TABLES `tipo_variavel_custo` WRITE;
/*!40000 ALTER TABLE `tipo_variavel_custo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_variavel_custo` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_fornecedor`
--

LOCK TABLES `tipo_fornecedor` WRITE;
/*!40000 ALTER TABLE `tipo_fornecedor` DISABLE KEYS */;
INSERT INTO `tipo_fornecedor` VALUES (1,'Primário','2013-01-14 23:26:00'),(2,'Mão de Obra','2013-01-14 23:28:00'),(3,'Material Pesado','2013-01-14 23:28:35'),(4,'Material Leve','2013-01-14 23:29:00'),(5,'Acabamentos','2013-01-14 23:29:30');
/*!40000 ALTER TABLE `tipo_fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_custo`
--

LOCK TABLES `tipo_custo` WRITE;
/*!40000 ALTER TABLE `tipo_custo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_custo` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,1,1,'Adm','adm','adm@adm.com.br','202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,NULL,'2013-01-19 00:43:58','2012-07-25 16:23:51'),(6,1,1,'Alfredo','alfredo','alfredo.justino@gmail.com','186047c23f09ea4126937a570ac01201','e10adc3949ba59abbe56e057f20f883e','21232f297a57a5a743894a0e4a801fc3','5c2bf15004e661d7b7c9394617143d07','2012-08-29 21:23:51','2013-01-19 00:43:58','2012-08-29 13:44:59'),(7,1,1,'Marcio','mjustino','','21232f297a57a5a743894a0e4a801fc3','e5ef3b270e25cbc8e164c62dc3f0de39',NULL,NULL,'2012-08-29 21:36:08','2013-01-19 00:43:58','2012-08-29 21:24:34'),(8,1,1,'Éder','eamador','','e10adc3949ba59abbe56e057f20f883e','202cb962ac59075b964b07152d234b70','664ee74ec6f46a95346d33bbd91fc0b7',NULL,'2012-08-30 21:49:21','2013-01-19 00:43:58','2012-08-30 15:23:10');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `projeto`
--

LOCK TABLES `projeto` WRITE;
/*!40000 ALTER TABLE `projeto` DISABLE KEYS */;
/*!40000 ALTER TABLE `projeto` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `fornecedor_x_endereco`
--

LOCK TABLES `fornecedor_x_endereco` WRITE;
/*!40000 ALTER TABLE `fornecedor_x_endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedor_x_endereco` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `orcamento`
--

LOCK TABLES `orcamento` WRITE;
/*!40000 ALTER TABLE `orcamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `orcamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumo`
--

DROP TABLE IF EXISTS `insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_insumo_id` bigint(20) NOT NULL,
  `tipo_unidade_id` bigint(20) NOT NULL,
  `origem_insumo_id` bigint(20) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  KEY `fk_Recurso_Tipo_Unidade1_idx` (`tipo_unidade_id`),
  KEY `fk_insumo_origem_insumo1_idx` (`origem_insumo_id`),
  KEY `fk_Recurso_Tipo_Recurso1_idx` (`tipo_insumo_id`),
  CONSTRAINT `fk_insumo_origem_insumo1` FOREIGN KEY (`origem_insumo_id`) REFERENCES `origem_insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_Tipo_Recurso1` FOREIGN KEY (`tipo_insumo_id`) REFERENCES `tipo_insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_Tipo_Unidade1` FOREIGN KEY (`tipo_unidade_id`) REFERENCES `tipo_unidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='tbm conhecido como item elementar.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumo`
--

LOCK TABLES `insumo` WRITE;
/*!40000 ALTER TABLE `insumo` DISABLE KEYS */;
INSERT INTO `insumo` VALUES (1,2,1,1,'00005','Areia','2012-09-04 21:22:23');
/*!40000 ALTER TABLE `insumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variavel_custo_x_regiao`
--

DROP TABLE IF EXISTS `variavel_custo_x_regiao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variavel_custo_x_regiao` (
  `variavel_custo_id` bigint(20) NOT NULL,
  `regiao_id` bigint(20) NOT NULL,
  `valor` decimal(5,2) NOT NULL,
  `vigencia` datetime NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`variavel_custo_id`,`regiao_id`),
  KEY `fk_insumo_has_regiao_regiao1_idx` (`regiao_id`),
  KEY `fk_insumo_has_regiao_insumo1_idx` (`variavel_custo_id`),
  CONSTRAINT `fk_insumo_has_regiao_insumo1` FOREIGN KEY (`variavel_custo_id`) REFERENCES `variavel_custo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variavel_custo_x_regiao`
--

LOCK TABLES `variavel_custo_x_regiao` WRITE;
/*!40000 ALTER TABLE `variavel_custo_x_regiao` DISABLE KEYS */;
/*!40000 ALTER TABLE `variavel_custo_x_regiao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `cidade`
--

LOCK TABLES `cidade` WRITE;
/*!40000 ALTER TABLE `cidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `cidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_servico`
--

DROP TABLE IF EXISTS `categoria_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_servico` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(8) NOT NULL,
  `descricao` varchar(300) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_servico`
--

LOCK TABLES `categoria_servico` WRITE;
/*!40000 ALTER TABLE `categoria_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria_servico` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='m3;\nm2;\nkg;\nml;\nh (horas);';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_unidade`
--

LOCK TABLES `tipo_unidade` WRITE;
/*!40000 ALTER TABLE `tipo_unidade` DISABLE KEYS */;
INSERT INTO `tipo_unidade` VALUES (1,'Kilograma','kg','2012-09-04 21:20:39'),(2,'Metro Cúbico','m3','2012-09-04 21:20:51');
/*!40000 ALTER TABLE `tipo_unidade` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-19 10:35:10
