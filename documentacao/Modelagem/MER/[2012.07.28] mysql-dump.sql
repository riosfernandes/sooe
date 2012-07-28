CREATE DATABASE  IF NOT EXISTS `sooe` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sooe`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: wkatavsilva.intranet.intra    Database: sooe
-- ------------------------------------------------------
-- Server version	5.1.53-community

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
-- Table structure for table `situacao`
--

DROP TABLE IF EXISTS `situacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='situacao de usuario. Ativo, Inativo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacao`
--

LOCK TABLES `situacao` WRITE;
/*!40000 ALTER TABLE `situacao` DISABLE KEYS */;
INSERT INTO `situacao` (`id`, `descricao`) VALUES (1,'Ativo'),(2,'Inativo');
/*!40000 ALTER TABLE `situacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_recurso`
--

DROP TABLE IF EXISTS `tipo_recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_recurso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tbm conhecido como CATEGORIA\nhumano (mão de obra);\nmaterial;';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_recurso`
--

LOCK TABLES `tipo_recurso` WRITE;
/*!40000 ALTER TABLE `tipo_recurso` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_recurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='tipo de usuário: Administrador, Normal etc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` (`id`, `descricao`) VALUES (1,'Administrador'),(2,'Comum');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preco`
--

DROP TABLE IF EXISTS `preco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preco` (
  `recurso_id` int(11) NOT NULL,
  `fornecedor_id` int(11) NOT NULL,
  `vigencia` datetime DEFAULT NULL,
  `valor` decimal(18,5) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`recurso_id`,`fornecedor_id`),
  KEY `fk_Recurso_has_Fornecedor_Fornecedor1` (`fornecedor_id`),
  KEY `fk_Recurso_has_Fornecedor_Recurso1` (`recurso_id`),
  CONSTRAINT `fk_Recurso_has_Fornecedor_Recurso1` FOREIGN KEY (`recurso_id`) REFERENCES `recurso` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_has_Fornecedor_Fornecedor1` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preco`
--

LOCK TABLES `preco` WRITE;
/*!40000 ALTER TABLE `preco` DISABLE KEYS */;
/*!40000 ALTER TABLE `preco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_unidade`
--

DROP TABLE IF EXISTS `tipo_unidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_unidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='m3;\nm2;\nkg;\nml;\nh (horas);';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_unidade`
--

LOCK TABLES `tipo_unidade` WRITE;
/*!40000 ALTER TABLE `tipo_unidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_unidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familia`
--

DROP TABLE IF EXISTS `familia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `familia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Cla_id` int(11) NOT NULL,
  `Categoria_id` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `sigla` char(2) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`Cla_id`,`Categoria_id`),
  KEY `fk_Familia_Cla_Servico1` (`Cla_id`,`Categoria_id`),
  CONSTRAINT `fk_Familia_Cla_Servico1` FOREIGN KEY (`Cla_id`, `Categoria_id`) REFERENCES `cla` (`id`, `categoria_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familia`
--

LOCK TABLES `familia` WRITE;
/*!40000 ALTER TABLE `familia` DISABLE KEYS */;
INSERT INTO `familia` (`id`, `Cla_id`, `Categoria_id`, `descricao`, `sigla`, `cadastro`) VALUES (1,1,1,'familia1','01',NULL),(2,1,1,'familia2','02',NULL);
/*!40000 ALTER TABLE `familia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atividade`
--

DROP TABLE IF EXISTS `atividade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atividade` (
  `servico_id` int(11) NOT NULL,
  `projeto_id` int(11) NOT NULL,
  `percentual_lucro` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`servico_id`,`projeto_id`),
  KEY `fk_Servico_has_Projeto_Projeto1` (`projeto_id`),
  KEY `fk_Servico_has_Projeto_Servico1` (`servico_id`),
  CONSTRAINT `fk_Servico_has_Projeto_Servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Projeto_Projeto1` FOREIGN KEY (`projeto_id`) REFERENCES `projeto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atividade`
--

LOCK TABLES `atividade` WRITE;
/*!40000 ALTER TABLE `atividade` DISABLE KEYS */;
INSERT INTO `atividade` (`servico_id`, `projeto_id`, `percentual_lucro`) VALUES (1,1,NULL),(1,28,NULL),(1,29,NULL),(1,30,NULL),(1,31,NULL),(1,32,NULL),(1,33,NULL),(1,34,NULL),(1,35,NULL),(1,36,NULL),(15,30,NULL),(15,31,NULL),(15,32,NULL),(15,33,NULL),(15,34,NULL),(15,35,NULL),(15,36,NULL),(19,36,NULL),(24,36,NULL),(40,29,NULL);
/*!40000 ALTER TABLE `atividade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurso`
--

DROP TABLE IF EXISTS `recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Tipo_Recurso_id` int(11) NOT NULL,
  `Tipo_Unidade_id` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `cadastro` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`,`Tipo_Recurso_id`,`Tipo_Unidade_id`),
  KEY `fk_Recurso_Tipo_Recurso1` (`Tipo_Recurso_id`),
  KEY `fk_Recurso_Tipo_Unidade1` (`Tipo_Unidade_id`),
  CONSTRAINT `fk_Recurso_Tipo_Recurso1` FOREIGN KEY (`Tipo_Recurso_id`) REFERENCES `tipo_recurso` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recurso_Tipo_Unidade1` FOREIGN KEY (`Tipo_Unidade_id`) REFERENCES `tipo_unidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tbm conhecido como item elementar.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso`
--

LOCK TABLES `recurso` WRITE;
/*!40000 ALTER TABLE `recurso` DISABLE KEYS */;
/*!40000 ALTER TABLE `recurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico_has_servico`
--

DROP TABLE IF EXISTS `servico_has_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico_has_servico` (
  `servico_pai_id` int(11) NOT NULL,
  `servico_filho_id` int(11) NOT NULL,
  PRIMARY KEY (`servico_pai_id`,`servico_filho_id`),
  KEY `fk_Servico_has_Servico_Servico1` (`servico_filho_id`),
  KEY `fk_Servico_has_Servico_Servico` (`servico_pai_id`),
  CONSTRAINT `fk_Servico_has_Servico_Servico` FOREIGN KEY (`servico_pai_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Servico_Servico1` FOREIGN KEY (`servico_filho_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_has_servico`
--

LOCK TABLES `servico_has_servico` WRITE;
/*!40000 ALTER TABLE `servico_has_servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `servico_has_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projeto`
--

DROP TABLE IF EXISTS `projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projeto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projeto_pai_id` int(11) DEFAULT NULL,
  `fase_id` int(11) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Projeto_Projeto1` (`projeto_pai_id`),
  KEY `fk_Projeto_Fases1` (`fase_id`),
  CONSTRAINT `fk_Projeto_Projeto1` FOREIGN KEY (`projeto_pai_id`) REFERENCES `projeto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projeto_Fases1` FOREIGN KEY (`fase_id`) REFERENCES `fase` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projeto`
--

LOCK TABLES `projeto` WRITE;
/*!40000 ALTER TABLE `projeto` DISABLE KEYS */;
INSERT INTO `projeto` (`id`, `projeto_pai_id`, `fase_id`, `cadastro`, `descricao`) VALUES (1,NULL,NULL,'2012-07-25 19:03:09','Teste'),(2,NULL,NULL,'2012-07-26 15:34:31','teste'),(3,NULL,NULL,'2012-07-26 15:34:44','teste'),(4,NULL,NULL,'2012-07-26 15:34:59','teste'),(5,NULL,NULL,'2012-07-26 15:45:13','test'),(6,NULL,NULL,'2012-07-26 15:46:59','test'),(7,NULL,NULL,'2012-07-26 15:48:37','test'),(8,NULL,NULL,'2012-07-26 15:49:15','test'),(9,NULL,NULL,'2012-07-26 15:51:21','test'),(10,NULL,NULL,'2012-07-26 15:51:48','test'),(11,NULL,NULL,'2012-07-26 15:56:27','test'),(12,NULL,NULL,'2012-07-26 15:59:08','test'),(13,NULL,NULL,'2012-07-26 16:09:44','tae'),(14,NULL,NULL,'2012-07-26 16:11:53','tae'),(15,NULL,NULL,'2012-07-26 16:12:46','tae'),(16,NULL,NULL,'2012-07-26 16:31:24','tes'),(17,NULL,NULL,'2012-07-26 16:32:32','test'),(18,NULL,NULL,'2012-07-26 17:02:43','test'),(19,NULL,NULL,'2012-07-26 17:03:20','test'),(20,NULL,NULL,'2012-07-26 17:07:05','test'),(21,NULL,NULL,'2012-07-26 17:14:00','test'),(22,NULL,NULL,'2012-07-26 17:14:30','teste'),(23,NULL,NULL,'2012-07-26 17:14:43','teste'),(24,NULL,NULL,'2012-07-26 17:16:59','teste'),(25,NULL,NULL,'2012-07-26 17:19:45','teste'),(26,NULL,NULL,'2012-07-26 17:31:10','teste'),(27,NULL,NULL,'2012-07-26 17:31:42','teste'),(28,NULL,NULL,'2012-07-26 17:33:10','testte'),(29,NULL,NULL,'2012-07-26 17:34:40','teste01'),(30,NULL,NULL,'2012-07-26 18:30:35','tes'),(31,NULL,NULL,'2012-07-26 18:30:49','tes'),(32,NULL,NULL,'2012-07-26 18:30:55','tes'),(33,NULL,NULL,'2012-07-26 18:31:12','tes'),(34,NULL,NULL,'2012-07-26 18:32:06','tes'),(35,NULL,NULL,'2012-07-26 18:32:13','tes'),(36,NULL,NULL,'2012-07-26 18:32:30','tes');
/*!40000 ALTER TABLE `projeto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `login` varchar(12) NOT NULL,
  `email` varchar(45) NOT NULL,
  `tipo_usuario_id` int(11) NOT NULL,
  `situacao_id` int(11) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `senha_anterior1` varchar(32) DEFAULT NULL,
  `senha_anterior2` varchar(32) DEFAULT NULL,
  `senha_anterior3` varchar(32) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ultima_troca` datetime DEFAULT NULL,
  `ultimo_acesso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  KEY `fk_usuario_situacao1` (`situacao_id`),
  KEY `fk_usuario_tipo_usuario1` (`tipo_usuario_id`),
  CONSTRAINT `fk_usuario_situacao1` FOREIGN KEY (`situacao_id`) REFERENCES `situacao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_tipo_usuario1` FOREIGN KEY (`tipo_usuario_id`) REFERENCES `tipo_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id`, `nome`, `login`, `email`, `tipo_usuario_id`, `situacao_id`, `senha`, `senha_anterior1`, `senha_anterior2`, `senha_anterior3`, `cadastro`, `ultima_troca`, `ultimo_acesso`) VALUES (1,'Adm','adm','adm@adm.com.br',1,1,'202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2012-07-25 13:23:51',NULL,'2012-07-27 11:32:14');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `familia_id` int(11) NOT NULL,
  `cla_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `sco` varchar(45) DEFAULT NULL COMMENT 'Cód. SCO: 	 Ex .: AD05.05.0050',
  `fgv` varchar(45) DEFAULT NULL COMMENT 'Cód. FGV:  Ex.: 000001 ',
  `descricao` varchar(700) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`familia_id`,`cla_id`,`categoria_id`),
  KEY `fk_Servico_Familia1` (`familia_id`,`cla_id`,`categoria_id`),
  CONSTRAINT `fk_Servico_Familia1` FOREIGN KEY (`familia_id`, `cla_id`, `categoria_id`) REFERENCES `familia` (`id`, `Cla_id`, `Categoria_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 COMMENT='tudo que tem preço e unidade de medida. Tbm conhecido como i';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
INSERT INTO `servico` (`id`, `familia_id`, `cla_id`, `categoria_id`, `sco`, `fgv`, `descricao`, `cadastro`) VALUES (1,1,1,1,'AD 05.05.0050 (/)',NULL,'Analise granulometrica sem sedimentacao.',NULL),(2,1,1,1,'AD 05.05.0053 (/)',NULL,'Analise granulometrica completa, em amostra de solo, de acordo com a NBR7181 e NBR6457, compreendendo as fases de peneiramento e sedimentacao, quando constatada a presenca de particulas finas em sua composicao.',NULL),(3,1,1,1,'AD 05.05.0100 (/)',NULL,'Ensaio de adensamento endometrico em amostra de solo, envolvendo, no minimo, 10 estagios de carga, inclusive um laco de descarregamento e recarregamento, de acordo com as recomendacoes estabelecidas na NBR12007.',NULL),(4,1,1,1,'AD 05.05.0150 (/)',NULL,'Ensaio de cizalhamento direto em solo, com, no minimo, 3 niveis de tensao normal aplicada a amostra e com apresentacao das curvas de tensao cisalhante por deslocamento horizontal e deslocamento vertical por deslocamento horizontal, em mm, para cada um dos 3 niveis de tensao.',NULL),(5,1,1,1,'AD 05.05.0200 (/)',NULL,'Ensaio de laboratorio, para determinacao da Densidade Real dos graos de amostra de solo, de acordo com as recomendacoes de preparo descritas na NBR6457.',NULL),(6,1,1,1,'AD 05.05.0250 (/)',NULL,'Ensaio para determinacao, em laboratorio, do Limite de Liquidez de amostra de solo fino, de acordo com as recomendacoes da NBR7180 e da NBR6457.',NULL),(7,1,1,1,'AD 05.05.0300 (/)',NULL,'Ensaio para determinacao, em laboratorio, do Limite de Plasticidade de amostra de solo fino, de acordo com as recomendacoes da NBR7180 e da NBR6457.',NULL),(8,1,1,1,'AD 05.05.0325 (/)',NULL,'Ensaio para determinacao de massa especifica aparente \"in situ\" (DPTM-92/64).',NULL),(9,1,1,1,'AD 05.05.0350 (/)',NULL,'Ensaio para determinacao, em laboratorio, do Peso Especifico Aparente de amostra de solo, de acordo com as recomendacoes da NBR6457.',NULL),(10,1,1,1,'AD 05.05.0450 (/)',NULL,'Ensaio para determinacao do Indice de Suporte California (CBR) - 3 pontos - obtido com energia Proctor Normal, atraves de, no minimo, 5 corpos de prova, conforme recomendacoes da NBR9895.',NULL),(11,1,1,1,'AD 05.05.0500 (/)',NULL,'Ensaio para determinacao, no campo, da umidade aparente do solo, atraves do Metodo \"speedy\".',NULL),(12,1,1,1,'AD 05.05.0550 (/)',NULL,'Ensaio para determinacao da umidade natural de amostras de solo, em laboratorio.',NULL),(13,1,1,1,'AD 05.05.0600 (/)',NULL,'Extracao e acondicionamento de amostra indeformada de solo, com pistao estacionario de 100mm e de acordo com as recomendacoes estabelecidas na NBR9820.',NULL),(14,1,1,1,'AD 05.05.0650 (B)',NULL,'Instalacao de medidor de nivel de agua, inclusive transporte da equipe.',NULL),(15,1,1,1,'AD 05.05.0700 (/)',NULL,'Sondagem manual com pa e picareta, por metro linear ou fracao.',NULL),(16,1,1,1,'AD 05.05.0703 (/)',NULL,'Sondagem manual com trado e cavadeira, por metro linear ou fracao.',NULL),(17,1,1,1,'AD 05.05.0706 (A)',NULL,'Sondagem de reconhecimento, a trado manual, com diametro de 100mm.',NULL),(18,1,1,1,'AD 05.10.0050 (/)',NULL,'Sondagem rotativa vertical, em rocha alterada, com coroa de Widia ou similar, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(19,1,1,1,'AD 05.10.0100 (/)',NULL,'Sondagem rotativa vertical, em rocha alterada, com coroa de Widia ou similar, diametro N (75mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(20,1,1,1,'AD 05.10.0150 (/)',NULL,'Sondagem rotativa vertical, em solo, com coroa de Widia ou similar, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(21,1,1,1,'AD 05.10.0200 (/)',NULL,'Sondagem rotativa vertical, em solo, com coroa de Widia ou similar, diametro N (75mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(22,1,1,1,'AD 05.15.0050 (/)',NULL,'Sondagem rotativa com Coroa de diamante, em rocha sa, diametro HW, inclinada (qualquer inclinacao diferente da vertical), inclusive deslocamento dentro do canteiro e instalacao da sonda no furo.',NULL),(23,1,1,1,'AD 05.15.0100 (/)',NULL,'Sondagem rotativa com Coroa de diamante, em rocha sa, diametro NW, inclinada (qualquer inclinacao diferente da vertical), inclusive deslocamento dentro do canteiro e instalacao da sonda no furo.',NULL),(24,1,1,1,'AD 05.15.0150 (/)',NULL,'Sondagem rotativa vertical, em rocha alterada, com coroa de diamante, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(25,1,1,1,'AD 05.15.0200 (/)',NULL,'Sondagem rotativa vertical, em rocha alterada, com coroa de diamante, diametro H (99mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(26,1,1,1,'AD 05.15.0250 (/)',NULL,'Sondagem rotativa vertical, em rocha sa, com coroa de diamante, diametro B (60mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(27,1,1,1,'AD 05.15.0300 (/)',NULL,'Sondagem rotativa vertical, em rocha sa, com coroa de diamante, diametro N (75mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(28,1,1,1,'AD 05.15.0400 (/)',NULL,'Sondagem rotativa vertical, em rocha sa, com coroa de diamante, diametro H (99mm), inclusive deslocamento e posicionamento em cada furo.',NULL),(29,1,1,1,'AD 05.20.0050 (/)',NULL,'Sondagem a percussao com diametro ate 3\", com ensaio de penetracao (SPT) a cada metro, incluindo relatorio contendo classificacao tatil visual das amostras, perfis individuais dos furos, planta de localizacao e respectivas cotas das sondagens. Inclui deslocamento ate 50m de distancia e instalacao do tripe em cada furo dentro do canteiro, excluindo mobilizacao e desmobilizacao.',NULL),(30,1,1,1,'AD 10.05.0050 (/)',NULL,'Marcacao de obra, sem instrumento topografico, considerada a projecao horizontal da area envolvente.',NULL),(31,1,1,1,'AD 10.10.0100 (/)',NULL,'Locacao de obra com aparelho topografico, sobre cerca de marcacao, inclusive construcao desta e sua pre-locacao e o fornecimento do material e tendo, por medicao, o perimetro a construir.',NULL),(32,1,1,1,'AD 15.05.0050 (/)',NULL,'Deslocamento, entre furos, de equipamento de sondagem a percurssao, incluindo desmontagem e remontagem.',NULL),(33,1,1,1,'AD 15.10.0050 (/)',NULL,'Carga e descarga de equipamentos pesados em carretas, exclusive o custo horario do equipamento, durante a operacao.',NULL),(34,1,1,1,'AD 15.10.0100 (A)',NULL,'Transporte de andaime suspenso, tipo leve, para pintura, inclusive ida e volta do caminhao, carga e descarga (considerar o minimo de 40unxKm, para calculo deste transporte).',NULL),(35,1,1,1,'AD 15.10.0150 (A)',NULL,'Transporte de andaime suspenso, tipo pesado, para revestimento, inclusive ida e volta do caminhao, carga e descarga (considerar o minimo de 200unxKm, para calculo deste transporte).',NULL),(36,1,1,1,'AD 15.10.0200 (/)',NULL,'Transporte de andaime tubular, considerando-se a area de projecao vertical do andaime, inclusive ida e volta do caminhao, carga e descarga (considerar o minimo de 315m2xKm, para calculo deste transporte).',NULL),(37,1,1,1,'AD 15.10.0250 (/)',NULL,'Transporte de elevador de obras constituido por cabine aberta, com plataforma, guinchos e cabos de 16m de altura.',NULL),(38,1,1,1,'AD 15.10.0300 (/)',NULL,'Transporte de equipamentos pesados em carretas, exclusive a carga e descarga e o custo horario dos equipamentos transportados.',NULL),(39,1,1,1,'AD 15.10.0350 (A)',NULL,'Transporte maritimo de carga de qualquer natureza, exclusive despesas de carga e descarga, no trajeto da Ilha do Governador ate a Ilha de Paqueta ou vice-versa, em embarcacao apropriada (considerar apenas a viagem com a carga).',NULL),(40,1,1,1,'AD 15.15.0050 (C)',NULL,'Caminhoneta de servico, com cabine e cacamba, com motor bicombustivel, cabine simples, com ar condicionado e direcao hidraulica, capacidade de carga minima de 650Kg, tracao 4 x 2, com motorista, material de operacao e material de manutencao. Custo horario produtivo.',NULL),(41,1,1,1,'AD 15.15.0100 (B)',NULL,'Caminhoneta de servico, com cabine e cacamba, com motor bicombustivel, cabine simples, com ar condicionado e direcao hidraulica, capacidade de carga minima de 650Kg, tracao 4 x 2, com motorista e material de operacao. Custo horario improdutivo (motor funcionando).',NULL),(42,1,1,1,'AD 15.15.0150 (B)',NULL,'Caminhoneta de servico, com cabine e cacamba, com motor bicombustivel, cabine simples, com ar condicionado e direcao hidraulica, capacidade de carga minima de 650Kg, tracao 4 x 2, com motorista. Custo horario improdutivo (motor desligado).',NULL),(43,1,1,1,'AD 15.15.0200 (/)',NULL,'Caminhoneta de servico, capacidade para 09 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV, modelo Standard. Custo horario diurno (entre 05:00h e 22:00h).',NULL),(44,1,1,1,'AD 15.15.0250 (A)',NULL,'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo horario produtivo.',NULL),(45,1,1,1,'AD 15.15.0300 (/)',NULL,'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista e material de operacao, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo horario improdutivo (motor funcionando).',NULL),(46,1,1,1,'AD 15.15.0350 (/)',NULL,'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo horario improdutivo (motor desligado).',NULL),(47,1,1,1,'AD 15.15.0401 (A)',NULL,'Caminhoneta de Servico, capacidade de 9 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV, autonomia de 3000Km/mes. Custo mensal.',NULL),(48,1,1,1,'AD 15.15.0403 (A)',NULL,'Caminhoneta de Servico (kilometragem adicional), capacidade para 9 passageiros ou 1t, com motorista, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor a gasolina de 53CV. Custo do quilometro adicional.',NULL),(49,1,1,1,'AD 15.15.0550 (A)',NULL,'Carreta para transporte pesado, com capacidade de carga util de 60/80t, com motorista operador, material de operacao e material de manutencao, com as seguintes especificacoes minimas: motor diesel de 330CV, chassis extensivel ate 21m e semi-reboque de 4 eixos. Custo horario produtivo.',NULL),(50,1,1,1,'AD 15.15.0600 (A)',NULL,'Carreta para transporte pesado, com capacidade de carga util de 60/80t, com motorista operador e material de operacao, com as seguintes especificacoes minimas: motor diesel de 330CV, chassis extensivel ate 21m e semi-reboque de 4 eixos. Custo horario improdutivo (motor funcionando).',NULL);
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cla`
--

DROP TABLE IF EXISTS `cla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cla` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria_id` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `sigla` char(2) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`categoria_id`),
  KEY `fk_Cla_Servico_Categoria_Servico1` (`categoria_id`),
  CONSTRAINT `fk_Cla_Servico_Categoria_Servico1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cla`
--

LOCK TABLES `cla` WRITE;
/*!40000 ALTER TABLE `cla` DISABLE KEYS */;
INSERT INTO `cla` (`id`, `categoria_id`, `descricao`, `sigla`, `cadastro`) VALUES (1,1,'cla1','01',NULL),(2,1,'cla2','02',NULL);
/*!40000 ALTER TABLE `cla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornecedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cadastro` timestamp NULL DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='ou tabela de preço da onde (rio, sp?)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedor`
--

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composicao`
--

DROP TABLE IF EXISTS `composicao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `composicao` (
  `servico_id` int(11) NOT NULL,
  `recurso_id` int(11) NOT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`servico_id`,`recurso_id`),
  KEY `fk_Servico_has_Recurso_Recurso1` (`recurso_id`),
  KEY `fk_Servico_has_Recurso_Servico1` (`servico_id`),
  CONSTRAINT `fk_Servico_has_Recurso_Servico1` FOREIGN KEY (`servico_id`) REFERENCES `servico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_has_Recurso_Recurso1` FOREIGN KEY (`recurso_id`) REFERENCES `recurso` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
-- Table structure for table `categoria_servico`
--

DROP TABLE IF EXISTS `categoria_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_servico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  `sigla` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_servico`
--

LOCK TABLES `categoria_servico` WRITE;
/*!40000 ALTER TABLE `categoria_servico` DISABLE KEYS */;
INSERT INTO `categoria_servico` (`id`, `descricao`, `cadastro`, `sigla`) VALUES (1,'categoria01',NULL,'c1'),(2,'categoria02',NULL,'c2');
/*!40000 ALTER TABLE `categoria_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fase`
--

DROP TABLE IF EXISTS `fase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `cadastro` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='mantem a situação do projeto em fases: \n1.estimativa;\n2.em a';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fase`
--

LOCK TABLES `fase` WRITE;
/*!40000 ALTER TABLE `fase` DISABLE KEYS */;
/*!40000 ALTER TABLE `fase` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-07-28  9:58:13
