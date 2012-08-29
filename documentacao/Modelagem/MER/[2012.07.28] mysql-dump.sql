USE `sooe`;

unlock tables;

--
-- Dumping data for table `situacao`
--

INSERT INTO `situacao_usuario` (`id`, `descricao`) VALUES (1,'Ativo'),(2,'Inativo');

--
-- Dumping data for table `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`id`, `descricao`) VALUES (1,'Administrador'),(2,'Comum');

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `nome`, `login`, `email`, `tipo_usuario_id`, `situacao_usuario_id`, `senha`, `senha_anterior1`, `senha_anterior2`, `senha_anterior3`, `cadastro`, `ultima_troca`, `ultimo_acesso`) VALUES (1,'Adm','adm','adm@adm.com.br',1,1,'202cb962ac59075b964b07152d234b70',NULL,NULL,NULL,'2012-07-25 13:23:51',NULL,'2012-07-27 11:32:14');