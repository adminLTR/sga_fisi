CREATE DATABASE  IF NOT EXISTS `sga_fisi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sga_fisi`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: sga_fisi
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `area_academica`
--

DROP TABLE IF EXISTS `area_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `area_academica` (
  `areaca_iCodigo` int NOT NULL AUTO_INCREMENT,
  `areaca_vcCodigo` varchar(4) NOT NULL,
  `areaca_vcNombre` varchar(64) NOT NULL,
  `areaca_bActivo` int NOT NULL,
  PRIMARY KEY (`areaca_iCodigo`),
  UNIQUE KEY `areaca_vcCodigo` (`areaca_vcCodigo`),
  UNIQUE KEY `areaca_vcNombre` (`areaca_vcNombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area_academica`
--

LOCK TABLES `area_academica` WRITE;
/*!40000 ALTER TABLE `area_academica` DISABLE KEYS */;
INSERT INTO `area_academica` VALUES (1,'A','Ciencias de la salud',1),(2,'B','Ciencias básicas',1),(3,'C','Ingeniería',1),(4,'D','Ciencias económicas y de la gestión',1),(5,'E','Humanidades y ciencias jurídicas y sociales',1);
/*!40000 ALTER TABLE `area_academica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula`
--

DROP TABLE IF EXISTS `aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aula` (
  `aul_iCodigo` int NOT NULL AUTO_INCREMENT,
  `aul_vcCodigo` varchar(16) NOT NULL,
  `aul_iCapacidad` int NOT NULL,
  `loc_iCodigo_id` int NOT NULL,
  `aul_imgImage` varchar(100) DEFAULT NULL,
  `aul_vcLatitud` varchar(20) DEFAULT NULL,
  `aul_vcLongitud` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`aul_iCodigo`),
  KEY `aula_loc_iCodigo_id_56baa96e_fk_local_loc_iCodigo` (`loc_iCodigo_id`),
  CONSTRAINT `aula_loc_iCodigo_id_56baa96e_fk_local_loc_iCodigo` FOREIGN KEY (`loc_iCodigo_id`) REFERENCES `local` (`loc_iCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula`
--

LOCK TABLES `aula` WRITE;
/*!40000 ALTER TABLE `aula` DISABLE KEYS */;
/*!40000 ALTER TABLE `aula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Área académica',7,'add_areaacademica'),(26,'Can change Área académica',7,'change_areaacademica'),(27,'Can delete Área académica',7,'delete_areaacademica'),(28,'Can view Área académica',7,'view_areaacademica'),(29,'Can add Día',8,'add_dia'),(30,'Can change Día',8,'change_dia'),(31,'Can delete Día',8,'delete_dia'),(32,'Can view Día',8,'view_dia'),(33,'Can add Facultad',9,'add_facultad'),(34,'Can change Facultad',9,'change_facultad'),(35,'Can delete Facultad',9,'delete_facultad'),(36,'Can view Facultad',9,'view_facultad'),(37,'Can add Escuela',10,'add_escuela'),(38,'Can change Escuela',10,'change_escuela'),(39,'Can delete Escuela',10,'delete_escuela'),(40,'Can view Escuela',10,'view_escuela'),(41,'Can add Curso',11,'add_curso'),(42,'Can change Curso',11,'change_curso'),(43,'Can delete Curso',11,'delete_curso'),(44,'Can view Curso',11,'view_curso'),(45,'Can add Tipo de curso',12,'add_cursotipo'),(46,'Can change Tipo de curso',12,'change_cursotipo'),(47,'Can delete Tipo de curso',12,'delete_cursotipo'),(48,'Can view Tipo de curso',12,'view_cursotipo'),(49,'Can add Tipo de dictado',13,'add_cursotipodictado'),(50,'Can change Tipo de dictado',13,'change_cursotipodictado'),(51,'Can delete Tipo de dictado',13,'delete_cursotipodictado'),(52,'Can view Tipo de dictado',13,'view_cursotipodictado'),(53,'Can add Plan de estudio',14,'add_planestudio'),(54,'Can change Plan de estudio',14,'change_planestudio'),(55,'Can delete Plan de estudio',14,'delete_planestudio'),(56,'Can view Plan de estudio',14,'view_planestudio'),(57,'Can add Grupo',15,'add_grupo'),(58,'Can change Grupo',15,'change_grupo'),(59,'Can delete Grupo',15,'delete_grupo'),(60,'Can view Grupo',15,'view_grupo'),(61,'Can add Pre requisito',16,'add_cursoprerequisito'),(62,'Can change Pre requisito',16,'change_cursoprerequisito'),(63,'Can delete Pre requisito',16,'delete_cursoprerequisito'),(64,'Can view Pre requisito',16,'view_cursoprerequisito'),(65,'Can add Horas de dictado de curso',17,'add_cursohorasdictado'),(66,'Can change Horas de dictado de curso',17,'change_cursohorasdictado'),(67,'Can delete Horas de dictado de curso',17,'delete_cursohorasdictado'),(68,'Can view Horas de dictado de curso',17,'view_cursohorasdictado'),(69,'Can add Curso equivalente',18,'add_cursoequivalente'),(70,'Can change Curso equivalente',18,'change_cursoequivalente'),(71,'Can delete Curso equivalente',18,'delete_cursoequivalente'),(72,'Can view Curso equivalente',18,'view_cursoequivalente'),(73,'Can add Aula',19,'add_aula'),(74,'Can change Aula',19,'change_aula'),(75,'Can delete Aula',19,'delete_aula'),(76,'Can view Aula',19,'view_aula'),(77,'Can add Local',20,'add_local'),(78,'Can change Local',20,'change_local'),(79,'Can delete Local',20,'delete_local'),(80,'Can view Local',20,'view_local'),(81,'Can add Grupo horario',21,'add_grupohorario'),(82,'Can change Grupo horario',21,'change_grupohorario'),(83,'Can delete Grupo horario',21,'delete_grupohorario'),(84,'Can view Grupo horario',21,'view_grupohorario'),(85,'Can add Semestre',22,'add_semestre'),(86,'Can change Semestre',22,'change_semestre'),(87,'Can delete Semestre',22,'delete_semestre'),(88,'Can view Semestre',22,'view_semestre');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$L8TvIV1frcfAFChWYAeYY8$zWYFsNtvNH8hR3E0nkVD2s1NzgC80J4n0PayuF/nFDM=','2023-11-13 18:19:15.959399',1,'admin','','','',1,1,'2023-11-13 18:19:05.175800');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `cur_iCodigo` int NOT NULL AUTO_INCREMENT,
  `cur_vcCodigo` varchar(16) NOT NULL,
  `cur_vcNombre` varchar(64) NOT NULL,
  `cur_fCreditos` decimal(6,1) NOT NULL,
  `cur_fCreditosRequisito` decimal(6,1) NOT NULL,
  `cur_iSemestre` int DEFAULT NULL,
  `curare_iCodigo_id` int NOT NULL,
  `curtip_iCodigo_id` int NOT NULL,
  `plaest_iCodigo_id` int NOT NULL,
  PRIMARY KEY (`cur_iCodigo`),
  KEY `curso_curtip_iCodigo_id_959e0640_fk_curso_tipo_curtip_iCodigo` (`curtip_iCodigo_id`),
  KEY `curso_plaest_iCodigo_id_7614fd10_fk_plan_estudio_plaest_iCodigo` (`plaest_iCodigo_id`),
  KEY `curso_curare_iCodigo_id_81928e32_fk_area_acad` (`curare_iCodigo_id`),
  CONSTRAINT `curso_curare_iCodigo_id_81928e32_fk_area_acad` FOREIGN KEY (`curare_iCodigo_id`) REFERENCES `area_academica` (`areaca_iCodigo`),
  CONSTRAINT `curso_curtip_iCodigo_id_959e0640_fk_curso_tipo_curtip_iCodigo` FOREIGN KEY (`curtip_iCodigo_id`) REFERENCES `curso_tipo` (`curtip_iCodigo`),
  CONSTRAINT `curso_plaest_iCodigo_id_7614fd10_fk_plan_estudio_plaest_iCodigo` FOREIGN KEY (`plaest_iCodigo_id`) REFERENCES `plan_estudio` (`plaest_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'INE002','PROGRAMACIÓN Y COMPUTACIÓN',2.0,0.0,0,3,2,3),(2,'INO101','REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA I',3.0,0.0,1,3,1,3),(3,'INO102','MÉTODOS DE ESTUDIO UNIVERSITARIO',2.0,0.0,1,3,1,3),(4,'INO103','DESARROLLO PERSONAL Y LIDERAZGO',2.0,0.0,1,3,1,3),(5,'INO104','CÁLCULO I',4.0,0.0,1,3,1,3),(6,'INO105','BIOLOGÍA PARA CIENCIAS E INGENIERÍA',4.0,0.0,1,3,1,3),(7,'INO106','ÁLGEBRA Y GEOMETRÍA ANALÍTICA',4.0,0.0,1,3,1,3),(8,'INO107','MEDIO AMBIENTE Y DESARROLLO SOSTENIBLE',3.0,0.0,1,3,1,3),(9,'INE013','EMPRENDIMIENTO E INNOVACIÓN',2.0,0.0,0,3,2,3),(10,'INO202','INVESTIGACIÓN FORMATIVA',3.0,0.0,2,3,1,3),(11,'INO201','REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA II',3.0,0.0,2,3,1,3),(12,'INO203','REALIDAD NACIONAL Y MUNDIAL',2.0,0.0,2,3,1,3),(13,'INO204','CÁLCULO II',4.0,0.0,2,3,1,3),(14,'INO205','FÍSICA I',4.0,0.0,2,3,1,3),(15,'INO206','QUÍMICA GENERAL',4.0,0.0,2,3,1,3),(16,'INO207','INTRODUCCIÓN A LAS CIENCIAS E INGENIERÍA',2.0,0.0,2,3,1,3),(17,'202W0301','ALGORÍTMICA I',4.0,0.0,3,3,1,3),(18,'202W0302','ESTADÍSTICA',3.0,0.0,3,3,1,3),(19,'202W0303','FISICA ELÉCTRONICA',3.0,0.0,3,3,1,3),(20,'202W0304','INGENIERÍA ECONÓMICA',3.0,0.0,3,3,1,3),(21,'202W0305','INTRODUCCIÓN AL DESARROLLO DE SOFTWARE',3.0,0.0,3,3,1,3),(22,'202W0306','MATEMÁTICA BÁSICA',4.0,0.0,3,3,1,3),(23,'202W0307','ORGANIZACIÓN Y ADMINISTRACIÓN',3.0,0.0,3,3,1,3),(24,'202W0401','ALGORÍTMICA II',4.0,0.0,4,3,1,3),(25,'202W0402','CONTABILIDAD PARA LA GESTIÓN',3.0,0.0,4,3,1,3),(26,'202W0403','INNOVACIÓN, TECNOLOGÍA Y EMPRENDIMIENTO',3.0,0.0,4,3,1,3),(27,'202W0404','MATEMÁTICA DISCRETA',3.0,0.0,4,3,1,3),(28,'202W0405','PROBABILIDADES',3.0,0.0,4,3,1,3),(29,'202W0406','PROCESOS DE SOFTWARE',3.0,0.0,4,3,1,3),(30,'202W0407','SISTEMAS DIGITALES',3.0,0.0,4,3,1,3),(31,'202W0501','ANÁLISIS Y DISEÑO DE ALGORITMOS',3.0,0.0,5,3,1,3),(32,'202W0502','ARQUITECTURA DE COMPUTADORAS',3.0,0.0,5,3,1,3),(33,'202W0503','CALIDAD DE SOFTWARE',3.0,0.0,5,3,1,3),(34,'202W0504','COMPUTACIÓN VISUAL',3.0,0.0,5,3,1,3),(35,'202W0505','ESTRUCTURA DE DATOS',4.0,0.0,5,3,1,3),(36,'202W0506','ECONOMÍA PARA LA GESTIÓN',3.0,0.0,5,3,1,3),(37,'202W0507','INGENIERÍA DE REQUISITOS',4.0,0.0,5,3,1,3),(38,'202W0601','ASEGURAMIENTO DE LA CALIDAD DEL SOFTWARE',3.0,0.0,6,3,1,3),(39,'202W0602','BASE DE DATOS I',4.0,0.0,6,3,1,3),(40,'202W0603','DISEÑO DE SOFTWARE',4.0,0.0,6,3,1,3),(41,'202W0604','FORMACIÓN DE EMPRESAS DE SOFTWARE',3.0,0.0,6,3,1,3),(42,'202W0605','GESTIÓN DE LA CONFIGURACIÓN DEL SOFTWARE',3.0,0.0,6,3,1,3),(43,'202W0606','INTERACCIÓN HOMBRE COMPUTADOR',3.0,0.0,6,3,1,3),(44,'202W0607','SISTEMAS OPERATIVOS',3.0,0.0,6,3,1,3),(45,'202W0701','ARQUITECTURA DE SOFTWARE',4.0,0.0,7,3,1,3),(46,'202W0702','BASE DE DATOS II',4.0,0.0,7,3,1,3),(47,'202W0703','EXPERIENCIA DE USUARIO Y USABILIDAD',3.0,0.0,7,3,1,3),(48,'202W0704','GESTIÓN DE PROYECTO DE SOFTWARE',3.0,0.0,7,3,1,3),(49,'202W0705','INTELIGENCIA ARTIFICIAL',3.0,0.0,7,3,1,3),(50,'202W0706','MÉTODOS FORMALES PARA PRUEBAS',3.0,0.0,7,3,1,3),(51,'202W0707','REDES Y TRANSMISIÓN DE DATOS',3.0,0.0,7,3,1,3),(52,'202W0801','AUTOMATIZACIÓN Y CONTROL DE SOFTWARE',3.0,0.0,8,3,1,3),(53,'202W0802','INTELIGENCIA DE NEGOCIOS',3.0,0.0,8,3,1,3),(54,'202W0803','METODOLOGÍA DE LA INVESTIGACIÓN',2.0,0.0,8,3,1,3),(55,'202W0804','MINERÍA DE DATOS',3.0,0.0,8,3,1,3),(56,'202W0805','PROGRAMACIÓN CONCURRENTE Y PARALELA',3.0,0.0,8,3,1,3),(57,'202W0806','SEGURIDAD DEL SOFTWARE',3.0,0.0,8,3,1,3),(58,'202W0807','TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB',3.0,0.0,8,3,1,3),(59,'202W0808','VERIFICACIÓN Y VALIDACIÓN DE SOFTWARE',3.0,0.0,8,3,1,3),(60,'202W0901','DESARROLLO DE TESIS I',2.0,0.0,9,3,1,3),(61,'202W0902','GARANTÍA DE SOFTWARE',3.0,0.0,9,3,1,3),(62,'202W0903','GERENCIA DE TECNOLOGÍA DE LA INFORMACIÓN',3.0,0.0,9,3,1,3),(63,'202W0904','GESTIÓN DE MANTENIMIENTO DEL SOFTWARE',3.0,0.0,9,3,1,3),(64,'202W0905','GESTIÓN DE RIESGO DEL SOFTWARE',3.0,0.0,9,3,1,3),(65,'202W0906','INTERNET DE LAS COSAS',3.0,0.0,9,3,1,3),(66,'202W0907','TALLER DE CONSTRUCCIÓN DE SOFTWARE MÓVIL',3.0,0.0,9,3,1,3),(67,'202W0908','SOFTWARE INTELIGENTE',3.0,0.0,9,3,1,3),(68,'202W1002','DESARROLLO DE TESIS II',2.0,0.0,10,3,1,3),(69,'202W1001','ANALÍTICA DE DATOS',3.0,0.0,10,3,1,3),(70,'202W1003','PRÁCTICA PRE PROFESIONAL',4.0,0.0,10,3,1,3),(71,'202W1004','TALLER DE APLICACIONES SOCIALES',3.0,0.0,10,3,1,3),(72,'202W1005','TENDENCIAS DE ARQUITECTURA DE SOFTWARE',3.0,0.0,10,3,1,3),(73,'202W1006','TENDENCIAS EN INGENIERÍA DE SOFTWARE Y GESTIÓN',3.0,0.0,10,3,1,3);
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_equivalente`
--

DROP TABLE IF EXISTS `curso_equivalente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_equivalente` (
  `cureqi_iCodigo` int NOT NULL AUTO_INCREMENT,
  `cur_iCodigo_id` int NOT NULL,
  `equ_iCodigo_id` int NOT NULL,
  PRIMARY KEY (`cureqi_iCodigo`),
  KEY `curso_equivalente_cur_iCodigo_id_c175b16b_fk_curso_cur_iCodigo` (`cur_iCodigo_id`),
  KEY `curso_equivalente_equ_iCodigo_id_87b27e78_fk_curso_cur_iCodigo` (`equ_iCodigo_id`),
  CONSTRAINT `curso_equivalente_cur_iCodigo_id_c175b16b_fk_curso_cur_iCodigo` FOREIGN KEY (`cur_iCodigo_id`) REFERENCES `curso` (`cur_iCodigo`),
  CONSTRAINT `curso_equivalente_equ_iCodigo_id_87b27e78_fk_curso_cur_iCodigo` FOREIGN KEY (`equ_iCodigo_id`) REFERENCES `curso` (`cur_iCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_equivalente`
--

LOCK TABLES `curso_equivalente` WRITE;
/*!40000 ALTER TABLE `curso_equivalente` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso_equivalente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_horasdictado`
--

DROP TABLE IF EXISTS `curso_horasdictado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_horasdictado` (
  `curhor_iCodigo` int NOT NULL AUTO_INCREMENT,
  `curhor_iHoras` int NOT NULL,
  `cur_iCodigo_id` int NOT NULL,
  `curtip_iCodigo_id` int NOT NULL,
  PRIMARY KEY (`curhor_iCodigo`),
  KEY `curso_horasdictado_cur_iCodigo_id_dba58dd8_fk_curso_cur_iCodigo` (`cur_iCodigo_id`),
  KEY `curso_horasdictado_curtip_iCodigo_id_0e9b3d85_fk_curso_tip` (`curtip_iCodigo_id`),
  CONSTRAINT `curso_horasdictado_cur_iCodigo_id_dba58dd8_fk_curso_cur_iCodigo` FOREIGN KEY (`cur_iCodigo_id`) REFERENCES `curso` (`cur_iCodigo`),
  CONSTRAINT `curso_horasdictado_curtip_iCodigo_id_0e9b3d85_fk_curso_tip` FOREIGN KEY (`curtip_iCodigo_id`) REFERENCES `curso_tipodictado` (`curtip_iCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_horasdictado`
--

LOCK TABLES `curso_horasdictado` WRITE;
/*!40000 ALTER TABLE `curso_horasdictado` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso_horasdictado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_prerequisito`
--

DROP TABLE IF EXISTS `curso_prerequisito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_prerequisito` (
  `curpre_iCodigo` int NOT NULL AUTO_INCREMENT,
  `cur_iCodigo_id` int NOT NULL,
  `req_iCodigo_id` int NOT NULL,
  PRIMARY KEY (`curpre_iCodigo`),
  KEY `curso_prerequisito_cur_iCodigo_id_c56c8def_fk_curso_cur_iCodigo` (`cur_iCodigo_id`),
  KEY `curso_prerequisito_req_iCodigo_id_d7d32e25_fk_curso_cur_iCodigo` (`req_iCodigo_id`),
  CONSTRAINT `curso_prerequisito_cur_iCodigo_id_c56c8def_fk_curso_cur_iCodigo` FOREIGN KEY (`cur_iCodigo_id`) REFERENCES `curso` (`cur_iCodigo`),
  CONSTRAINT `curso_prerequisito_req_iCodigo_id_d7d32e25_fk_curso_cur_iCodigo` FOREIGN KEY (`req_iCodigo_id`) REFERENCES `curso` (`cur_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_prerequisito`
--

LOCK TABLES `curso_prerequisito` WRITE;
/*!40000 ALTER TABLE `curso_prerequisito` DISABLE KEYS */;
INSERT INTO `curso_prerequisito` VALUES (1,11,2),(2,13,5),(3,24,17),(4,25,23),(5,26,20),(6,27,22),(7,28,18),(8,29,21),(9,29,20),(10,30,19),(11,31,24),(12,31,28),(13,32,30),(14,33,29),(15,34,27),(16,35,24),(17,36,25),(18,37,29),(19,38,33),(20,39,35),(21,40,37),(22,40,35),(23,41,36),(24,41,26),(25,42,29),(26,43,34),(27,44,32),(28,45,39),(29,45,40),(30,45,38),(31,46,39),(32,47,40),(33,47,43),(34,48,41),(35,49,43),(36,50,33),(37,50,42),(38,51,44),(39,52,51),(40,53,31),(41,53,46),(42,54,45),(43,54,49),(44,55,46),(45,56,44),(46,57,38),(47,57,51),(48,58,45),(49,58,46),(50,58,47),(51,58,51),(52,59,50),(53,60,54),(54,61,57),(55,62,48),(56,63,58),(57,64,48),(58,65,52),(59,66,58),(60,66,59),(61,67,49),(62,69,53),(63,69,67),(64,68,60),(65,70,66),(66,71,66),(67,72,66),(68,73,62);
/*!40000 ALTER TABLE `curso_prerequisito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_tipo`
--

DROP TABLE IF EXISTS `curso_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_tipo` (
  `curtip_iCodigo` int NOT NULL AUTO_INCREMENT,
  `curtip_vcNombre` varchar(32) NOT NULL,
  `curtip_bActivo` int NOT NULL,
  PRIMARY KEY (`curtip_iCodigo`),
  UNIQUE KEY `curtip_vcNombre` (`curtip_vcNombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_tipo`
--

LOCK TABLES `curso_tipo` WRITE;
/*!40000 ALTER TABLE `curso_tipo` DISABLE KEYS */;
INSERT INTO `curso_tipo` VALUES (1,'Obligatorio',1),(2,'Electivo',1),(3,'Optativo',1),(4,'Alternativo',1);
/*!40000 ALTER TABLE `curso_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_tipodictado`
--

DROP TABLE IF EXISTS `curso_tipodictado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_tipodictado` (
  `curtip_iCodigo` int NOT NULL AUTO_INCREMENT,
  `curtip_vcNombre` varchar(16) NOT NULL,
  PRIMARY KEY (`curtip_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_tipodictado`
--

LOCK TABLES `curso_tipodictado` WRITE;
/*!40000 ALTER TABLE `curso_tipodictado` DISABLE KEYS */;
INSERT INTO `curso_tipodictado` VALUES (1,'Presencial'),(2,'Virtual'),(3,'Híbrido');
/*!40000 ALTER TABLE `curso_tipodictado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dia`
--

DROP TABLE IF EXISTS `dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dia` (
  `dia_iCodigo` int NOT NULL AUTO_INCREMENT,
  `dia_iNumero` int NOT NULL,
  `dia_vcNombre` varchar(16) NOT NULL,
  PRIMARY KEY (`dia_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dia`
--

LOCK TABLES `dia` WRITE;
/*!40000 ALTER TABLE `dia` DISABLE KEYS */;
INSERT INTO `dia` VALUES (1,1,'Lunes'),(2,2,'Martes'),(3,3,'Miércoles'),(4,4,'Jueves'),(5,5,'Viernes'),(6,6,'Sábado'),(7,7,'Domingo');
/*!40000 ALTER TABLE `dia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-11-13 18:29:03.559848','1','Ingeniería de Sistemas - Facultad de Ingeniería de Sistemas e Informática',1,'[{\"added\": {}}]',10,1),(2,'2023-11-13 18:29:33.383504','2','Ingeniería de Software - Facultad de Ingeniería de Sistemas e Informática',1,'[{\"added\": {}}]',10,1),(3,'2023-11-13 18:42:18.746477','1','2009',1,'[{\"added\": {}}]',14,1),(4,'2023-11-13 18:43:29.364371','1','2009',2,'[{\"changed\": {\"fields\": [\"Resoluci\\u00f3n rectoral\"]}}]',14,1),(5,'2023-11-13 18:44:05.368920','2','2015',1,'[{\"added\": {}}]',14,1),(6,'2023-11-13 18:44:39.999641','3','2019',1,'[{\"added\": {}}]',14,1),(7,'2023-11-13 18:45:27.629334','1','Obligatorio',1,'[{\"added\": {}}]',12,1),(8,'2023-11-13 18:45:40.168971','2','Electivo',1,'[{\"added\": {}}]',12,1),(9,'2023-11-13 18:45:52.233622','3','Optativo',1,'[{\"added\": {}}]',12,1),(10,'2023-11-13 18:46:06.686896','4','Alternativo',1,'[{\"added\": {}}]',12,1),(11,'2023-11-13 18:48:17.525814','1','Presencial',1,'[{\"added\": {}}]',13,1),(12,'2023-11-13 18:48:21.830397','2','Virtual',1,'[{\"added\": {}}]',13,1),(13,'2023-11-13 18:48:29.047087','3','Híbrido',1,'[{\"added\": {}}]',13,1),(14,'2023-11-13 18:49:42.720984','3','2019',2,'[{\"changed\": {\"fields\": [\"Resoluci\\u00f3n rectoral\"]}}]',14,1),(15,'2023-11-13 18:50:19.263514','4','2023',1,'[{\"added\": {}}]',14,1),(16,'2023-11-13 18:50:30.582381','4','2023',2,'[{\"changed\": {\"fields\": [\"Cr\\u00e9ditos\"]}}]',14,1),(17,'2023-11-13 18:50:44.254110','1','2009',2,'[{\"changed\": {\"fields\": [\"Activo\"]}}]',14,1),(18,'2023-11-13 18:50:48.969880','1','2009',2,'[{\"changed\": {\"fields\": [\"Activo\"]}}]',14,1),(19,'2023-11-13 18:57:43.948464','1','2019, INE002, PROGRAMACIÓN Y COMPUTACIÓN',1,'[{\"added\": {}}]',11,1),(20,'2023-11-13 18:58:39.284304','2','2019, INO101, REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA I',1,'[{\"added\": {}}]',11,1),(21,'2023-11-13 18:59:11.237482','3','2019, INO102, MÉTODOS DE ESTUDIO UNIVERSITARIO',1,'[{\"added\": {}}]',11,1),(22,'2023-11-13 18:59:56.435915','4','2019, INO103, DESARROLLO PERSONAL Y LIDERAZGO',1,'[{\"added\": {}}]',11,1),(23,'2023-11-13 19:00:38.419917','5','2019, INO104, CÁLCULO I',1,'[{\"added\": {}}]',11,1),(24,'2023-11-13 19:01:11.325871','6','2019, INO105, BIOLOGÍA PARA CIENCIAS E INGENIERÍA',1,'[{\"added\": {}}]',11,1),(25,'2023-11-13 19:02:23.504230','7','2019, INO106, ÁLGEBRA Y GEOMETRÍA ANALÍTICA',1,'[{\"added\": {}}]',11,1),(26,'2023-11-13 19:03:12.626704','8','2019, INO107, MEDIO AMBIENTE Y DESARROLLO SOSTENIBLE',1,'[{\"added\": {}}]',11,1),(27,'2023-11-13 19:04:35.355228','9','2019, INE013, EMPRENDIMIENTO E INNOVACIÓN',1,'[{\"added\": {}}]',11,1),(28,'2023-11-13 19:23:34.350063','10','2019, INO201, REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA II',1,'[{\"added\": {}}]',11,1),(29,'2023-11-13 19:23:46.770791','3','2018',2,'[{\"changed\": {\"fields\": [\"C\\u00f3digo\"]}}]',14,1),(30,'2023-11-13 19:24:18.812550','1','2018, INE002, PROGRAMACIÓN Y COMPUTACIÓN',2,'[{\"changed\": {\"fields\": [\"Semestre\"]}}]',11,1),(31,'2023-11-13 19:24:25.064461','9','2018, INE013, EMPRENDIMIENTO E INNOVACIÓN',2,'[{\"changed\": {\"fields\": [\"Semestre\"]}}]',11,1),(32,'2023-11-13 19:26:34.744340','11','2018, INO201, REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA II',1,'[{\"added\": {}}]',11,1),(33,'2023-11-13 19:27:32.479711','10','2018, INO202, INVESTIGACIÓN FORMATIVA',2,'[{\"changed\": {\"fields\": [\"C\\u00f3digo\", \"Nombre\"]}}]',11,1),(34,'2023-11-13 19:28:01.950166','12','2018, INO203, REALIDAD NACIONAL Y MUNDIAL',1,'[{\"added\": {}}]',11,1),(35,'2023-11-13 19:34:22.167868','13','2018, INO204, CÁLCULO II',1,'[{\"added\": {}}]',11,1),(36,'2023-11-13 19:34:49.483144','14','2018, INO205, FÍSICA I',1,'[{\"added\": {}}]',11,1),(37,'2023-11-13 19:35:20.843261','15','2018, INO206, QUÍMICA GENERAL',1,'[{\"added\": {}}]',11,1),(38,'2023-11-13 19:36:12.541510','16','2018, INO207, INTRODUCCIÓN A LAS CIENCIAS E INGENIERÍA',1,'[{\"added\": {}}]',11,1),(39,'2023-11-13 19:39:36.938860','17','2018, 202W0301, ALGORÍTMICA I',1,'[{\"added\": {}}]',11,1),(40,'2023-11-13 19:40:04.604921','18','2018, 202W0302, ESTADÍSTICA',1,'[{\"added\": {}}]',11,1),(41,'2023-11-13 19:40:29.329529','19','2018, 202W0303, FISICA ELÉCTRONICA',1,'[{\"added\": {}}]',11,1),(42,'2023-11-13 19:40:53.104745','20','2018, 202W0304, INGENIERÍA ECONÓMICA',1,'[{\"added\": {}}]',11,1),(43,'2023-11-13 19:42:26.455231','21','2018, 202W0305, INTRODUCCIÓN AL DESARROLLO DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(44,'2023-11-13 19:44:26.074415','22','2018, 202W0306, MATEMÁTICA BÁSICA',1,'[{\"added\": {}}]',11,1),(45,'2023-11-13 19:44:53.115077','23','2018, 202W0307, ORGANIZACIÓN Y ADMINISTRACIÓN',1,'[{\"added\": {}}]',11,1),(46,'2023-11-13 19:45:49.233370','24','2018, 202W0401, ALGORÍTMICA II',1,'[{\"added\": {}}]',11,1),(47,'2023-11-13 19:46:27.541344','25','2018, 202W0402, CONTABILIDAD PARA LA GESTIÓN',1,'[{\"added\": {}}]',11,1),(48,'2023-11-13 19:47:26.210756','26','2018, 202W0403, INNOVACIÓN, TECNOLOGÍA Y EMPRENDIMIENTO',1,'[{\"added\": {}}]',11,1),(49,'2023-11-13 19:48:01.960266','27','2018, 202W0404, MATEMÁTICA DISCRETA',1,'[{\"added\": {}}]',11,1),(50,'2023-11-13 19:48:38.282217','28','2018, 202W0405, PROBABILIDADES',1,'[{\"added\": {}}]',11,1),(51,'2023-11-13 19:49:08.084333','29','2018, 202W0406, PROCESOS DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(52,'2023-11-13 19:50:22.671068','30','2018, 202W0407, SISTEMAS DIGITALES',1,'[{\"added\": {}}]',11,1),(53,'2023-11-13 20:09:59.784825','31','2018, 202W0501, ANÁLISIS Y DISEÑO DE ALGORITMOS',1,'[{\"added\": {}}]',11,1),(54,'2023-11-13 20:10:25.166647','32','2018, 202W0502, ARQUITECTURA DE COMPUTADORAS',1,'[{\"added\": {}}]',11,1),(55,'2023-11-13 20:11:03.883440','33','2018, 202W0503, CALIDAD DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(56,'2023-11-13 20:17:20.522709','34','2018, 202W0504, COMPUTACIÓN VISUAL',1,'[{\"added\": {}}]',11,1),(57,'2023-11-13 20:18:09.703434','35','2018, 202W0505, ESTRUCTURA DE DATOS',1,'[{\"added\": {}}]',11,1),(58,'2023-11-13 20:18:48.170607','36','2018, 202W0506, ECONOMÍA PARA LA GESTIÓN',1,'[{\"added\": {}}]',11,1),(59,'2023-11-13 20:19:34.897013','37','2018, 202W0507, INGENIERÍA DE REQUISITOS',1,'[{\"added\": {}}]',11,1),(60,'2023-11-13 20:27:32.085179','38','2018, 202W0601, ASEGURAMIENTO DE LA CALIDAD DEL SOFTWARE',1,'[{\"added\": {}}]',11,1),(61,'2023-11-13 20:28:18.910578','39','2018, 202W0602, BASE DE DATOS I',1,'[{\"added\": {}}]',11,1),(62,'2023-11-13 20:29:10.141138','40','2018, 202W0603, DISEÑO DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(63,'2023-11-13 20:31:35.800679','41','2018, 202W0604, FORMACIÓN DE EMPRESAS DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(64,'2023-11-13 20:32:02.092543','42','2018, 202W0605, GESTIÓN DE LA CONFIGURACIÓN DEL SOFTWARE',1,'[{\"added\": {}}]',11,1),(65,'2023-11-13 20:32:48.499934','43','2018, 202W0606, INTERACCIÓN HOMBRE COMPUTADOR',1,'[{\"added\": {}}]',11,1),(66,'2023-11-13 20:33:11.034140','44','2018, 202W0607, SISTEMAS OPERATIVOS',1,'[{\"added\": {}}]',11,1),(67,'2023-11-13 20:33:58.396028','45','2018, 202W0701, ARQUITECTURA DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(68,'2023-11-13 22:13:51.764424','46','2018, 202W0702, BASE DE DATOS II',1,'[{\"added\": {}}]',11,1),(69,'2023-11-13 22:14:37.256085','47','2018, 202W0703, EXPERIENCIA DE USUARIO Y USABILIDAD',1,'[{\"added\": {}}]',11,1),(70,'2023-11-13 22:15:06.344892','48','2018, 202W0704, GESTIÓN DE PROYECTO DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(71,'2023-11-13 22:15:36.215129','49','2018, 202W0705, INTELIGENCIA ARTIFICIAL',1,'[{\"added\": {}}]',11,1),(72,'2023-11-13 22:16:08.007297','50','2018, 202W0706, MÉTODOS FORMALES PARA PRUEBAS',1,'[{\"added\": {}}]',11,1),(73,'2023-11-13 22:16:29.492610','51','2018, 202W0707, REDES Y TRANSMISIÓN DE DATOS',1,'[{\"added\": {}}]',11,1),(74,'2023-11-13 22:18:45.746702','52','2018, 202W0801, AUTOMATIZACIÓN Y CONTROL DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(75,'2023-11-13 22:19:09.864784','53','2018, 202W0802, INTELIGENCIA DE NEGOCIOS',1,'[{\"added\": {}}]',11,1),(76,'2023-11-13 22:19:44.039631','54','2018, 202W0803, METODOLOGÍA DE LA INVESTIGACIÓN',1,'[{\"added\": {}}]',11,1),(77,'2023-11-13 22:19:57.156679','53','2018, 202W0802, INTELIGENCIA DE NEGOCIOS',2,'[{\"changed\": {\"fields\": [\"Semestre\"]}}]',11,1),(78,'2023-11-13 22:20:07.294877','52','2018, 202W0801, AUTOMATIZACIÓN Y CONTROL DE SOFTWARE',2,'[{\"changed\": {\"fields\": [\"Semestre\"]}}]',11,1),(79,'2023-11-13 22:23:48.823075','55','2018, 202W0804, MINERÍA DE DATOS',1,'[{\"added\": {}}]',11,1),(80,'2023-11-13 22:24:19.948375','56','2018, 202W0805, PROGRAMACIÓN CONCURRENTE Y PARALELA',1,'[{\"added\": {}}]',11,1),(81,'2023-11-13 22:24:43.121915','57','2018, 202W0806, SEGURIDAD DEL SOFTWARE',1,'[{\"added\": {}}]',11,1),(82,'2023-11-13 22:25:52.961286','58','2018, 202W0807, TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB',1,'[{\"added\": {}}]',11,1),(83,'2023-11-13 22:26:42.427499','59','2018, 202W0808, VERIFICACIÓN Y VALIDACIÓN DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(84,'2023-11-13 22:29:55.123282','60','2018, 202W0901, DESARROLLO DE TESIS I',1,'[{\"added\": {}}]',11,1),(85,'2023-11-13 22:30:43.775772','61','2018, 202W0902, GARANTÍA DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(86,'2023-11-13 22:31:04.930760','62','2018, 202W0903, GERENCIA DE TECNOLOGÍA DE LA INFORMACIÓN',1,'[{\"added\": {}}]',11,1),(87,'2023-11-13 22:32:00.645855','63','2018, 202W0904, GESTIÓN DE MANTENIMIENTO DEL SOFTWARE',1,'[{\"added\": {}}]',11,1),(88,'2023-11-13 22:32:24.672787','64','2018, 202W0905, GESTIÓN DE RIESGO DEL SOFTWARE',1,'[{\"added\": {}}]',11,1),(89,'2023-11-13 22:32:57.166511','65','2018, 202W0906, INTERNET DE LAS COSAS',1,'[{\"added\": {}}]',11,1),(90,'2023-11-13 22:33:19.851331','66','2018, 202W0907, TALLER DE CONSTRUCCIÓN DE SOFTWARE MÓVIL',1,'[{\"added\": {}}]',11,1),(91,'2023-11-13 22:33:51.560944','67','2018, 202W0908, SOFTWARE INTELIGENTE',1,'[{\"added\": {}}]',11,1),(92,'2023-11-13 22:35:33.081613','68','2018, 202W1001, ANALÍTICA DE DATOS',1,'[{\"added\": {}}]',11,1),(93,'2023-11-13 22:35:53.078147','69','2018, 202W1001, ANALÍTICA DE DATOS',1,'[{\"added\": {}}]',11,1),(94,'2023-11-13 22:36:25.189220','68','2018, 202W1002, DESARROLLO DE TESIS II',2,'[{\"changed\": {\"fields\": [\"C\\u00f3digo\", \"Nombre\", \"Cr\\u00e9ditos\"]}}]',11,1),(95,'2023-11-13 22:36:45.937664','70','2018, 202W1003, PRÁCTICA PRE PROFESIONAL',1,'[{\"added\": {}}]',11,1),(96,'2023-11-13 22:37:09.660354','71','2018, 202W1004, TALLER DE APLICACIONES SOCIALES',1,'[{\"added\": {}}]',11,1),(97,'2023-11-13 22:37:44.094300','72','2018, 202W1005, TENDENCIAS DE ARQUITECTURA DE SOFTWARE',1,'[{\"added\": {}}]',11,1),(98,'2023-11-13 22:38:06.317602','73','2018, 202W1006, TENDENCIAS EN INGENIERÍA DE SOFTWARE Y GESTIÓN',1,'[{\"added\": {}}]',11,1),(99,'2023-11-13 22:42:34.127566','1','2018, INO201, REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA II, 2018, INO101, REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA I',1,'[{\"added\": {}}]',16,1),(100,'2023-11-13 22:44:13.495862','2','2018, INO204, CÁLCULO II, 2018, INO104, CÁLCULO I',1,'[{\"added\": {}}]',16,1),(101,'2023-11-13 22:44:39.440890','3','2018, 202W0401, ALGORÍTMICA II, 2018, 202W0301, ALGORÍTMICA I',1,'[{\"added\": {}}]',16,1),(102,'2023-11-13 22:45:04.299516','4','2018, 202W0402, CONTABILIDAD PARA LA GESTIÓN, 2018, 202W0307, ORGANIZACIÓN Y ADMINISTRACIÓN',1,'[{\"added\": {}}]',16,1),(103,'2023-11-13 22:45:27.669488','5','2018, 202W0403, INNOVACIÓN, TECNOLOGÍA Y EMPRENDIMIENTO, 2018, 202W0304, INGENIERÍA ECONÓMICA',1,'[{\"added\": {}}]',16,1),(104,'2023-11-13 22:45:44.030502','6','2018, 202W0404, MATEMÁTICA DISCRETA, 2018, 202W0306, MATEMÁTICA BÁSICA',1,'[{\"added\": {}}]',16,1),(105,'2023-11-13 22:50:04.200003','7','2018, 202W0405, PROBABILIDADES, 2018, 202W0302, ESTADÍSTICA',1,'[{\"added\": {}}]',16,1),(106,'2023-11-13 22:50:20.505713','8','2018, 202W0406, PROCESOS DE SOFTWARE, 2018, 202W0305, INTRODUCCIÓN AL DESARROLLO DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(107,'2023-11-13 22:50:44.728580','9','2018, 202W0406, PROCESOS DE SOFTWARE, 2018, 202W0304, INGENIERÍA ECONÓMICA',1,'[{\"added\": {}}]',16,1),(108,'2023-11-13 22:53:01.101644','10','2018, 202W0407, SISTEMAS DIGITALES, 2018, 202W0303, FISICA ELÉCTRONICA',1,'[{\"added\": {}}]',16,1),(109,'2023-11-13 22:53:35.472432','11','2018, 202W0501, ANÁLISIS Y DISEÑO DE ALGORITMOS, 2018, 202W0401, ALGORÍTMICA II',1,'[{\"added\": {}}]',16,1),(110,'2023-11-13 22:53:50.075329','12','2018, 202W0501, ANÁLISIS Y DISEÑO DE ALGORITMOS, 2018, 202W0405, PROBABILIDADES',1,'[{\"added\": {}}]',16,1),(111,'2023-11-13 22:57:20.734041','13','2018, 202W0502, ARQUITECTURA DE COMPUTADORAS, 2018, 202W0407, SISTEMAS DIGITALES',1,'[{\"added\": {}}]',16,1),(112,'2023-11-13 22:57:38.329725','14','2018, 202W0503, CALIDAD DE SOFTWARE, 2018, 202W0406, PROCESOS DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(113,'2023-11-13 22:57:54.270926','15','2018, 202W0504, COMPUTACIÓN VISUAL, 2018, 202W0404, MATEMÁTICA DISCRETA',1,'[{\"added\": {}}]',16,1),(114,'2023-11-13 22:58:11.317162','16','2018, 202W0505, ESTRUCTURA DE DATOS, 2018, 202W0401, ALGORÍTMICA II',1,'[{\"added\": {}}]',16,1),(115,'2023-11-13 22:58:27.466100','17','2018, 202W0506, ECONOMÍA PARA LA GESTIÓN, 2018, 202W0402, CONTABILIDAD PARA LA GESTIÓN',1,'[{\"added\": {}}]',16,1),(116,'2023-11-13 22:58:42.904330','18','2018, 202W0507, INGENIERÍA DE REQUISITOS, 2018, 202W0406, PROCESOS DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(117,'2023-11-13 23:02:15.641930','19','2018, 202W0601, ASEGURAMIENTO DE LA CALIDAD DEL SOFTWARE, 2018, 202W0503, CALIDAD DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(118,'2023-11-13 23:02:33.580230','20','2018, 202W0602, BASE DE DATOS I, 2018, 202W0505, ESTRUCTURA DE DATOS',1,'[{\"added\": {}}]',16,1),(119,'2023-11-13 23:03:17.729953','21','2018, 202W0603, DISEÑO DE SOFTWARE, 2018, 202W0507, INGENIERÍA DE REQUISITOS',1,'[{\"added\": {}}]',16,1),(120,'2023-11-13 23:03:31.990740','22','2018, 202W0603, DISEÑO DE SOFTWARE, 2018, 202W0505, ESTRUCTURA DE DATOS',1,'[{\"added\": {}}]',16,1),(121,'2023-11-13 23:03:49.017795','23','2018, 202W0604, FORMACIÓN DE EMPRESAS DE SOFTWARE, 2018, 202W0506, ECONOMÍA PARA LA GESTIÓN',1,'[{\"added\": {}}]',16,1),(122,'2023-11-13 23:04:05.579131','24','2018, 202W0604, FORMACIÓN DE EMPRESAS DE SOFTWARE, 2018, 202W0403, INNOVACIÓN, TECNOLOGÍA Y EMPRENDIMIENTO',1,'[{\"added\": {}}]',16,1),(123,'2023-11-13 23:04:21.229352','25','2018, 202W0605, GESTIÓN DE LA CONFIGURACIÓN DEL SOFTWARE, 2018, 202W0406, PROCESOS DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(124,'2023-11-13 23:04:38.670202','26','2018, 202W0606, INTERACCIÓN HOMBRE COMPUTADOR, 2018, 202W0504, COMPUTACIÓN VISUAL',1,'[{\"added\": {}}]',16,1),(125,'2023-11-13 23:04:53.806996','27','2018, 202W0607, SISTEMAS OPERATIVOS, 2018, 202W0502, ARQUITECTURA DE COMPUTADORAS',1,'[{\"added\": {}}]',16,1),(126,'2023-11-13 23:07:04.349130','28','2018, 202W0701, ARQUITECTURA DE SOFTWARE, 2018, 202W0602, BASE DE DATOS I',1,'[{\"added\": {}}]',16,1),(127,'2023-11-13 23:07:22.303600','29','2018, 202W0701, ARQUITECTURA DE SOFTWARE, 2018, 202W0603, DISEÑO DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(128,'2023-11-13 23:07:42.621873','30','2018, 202W0701, ARQUITECTURA DE SOFTWARE, 2018, 202W0601, ASEGURAMIENTO DE LA CALIDAD DEL SOFTWARE',1,'[{\"added\": {}}]',16,1),(129,'2023-11-13 23:09:45.419235','31','2018, 202W0702, BASE DE DATOS II, 2018, 202W0602, BASE DE DATOS I',1,'[{\"added\": {}}]',16,1),(130,'2023-11-13 23:10:03.509211','32','2018, 202W0703, EXPERIENCIA DE USUARIO Y USABILIDAD, 2018, 202W0603, DISEÑO DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(131,'2023-11-13 23:10:20.437701','33','2018, 202W0703, EXPERIENCIA DE USUARIO Y USABILIDAD, 2018, 202W0606, INTERACCIÓN HOMBRE COMPUTADOR',1,'[{\"added\": {}}]',16,1),(132,'2023-11-13 23:10:38.582633','34','2018, 202W0704, GESTIÓN DE PROYECTO DE SOFTWARE, 2018, 202W0604, FORMACIÓN DE EMPRESAS DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(133,'2023-11-13 23:11:00.216591','35','2018, 202W0705, INTELIGENCIA ARTIFICIAL, 2018, 202W0606, INTERACCIÓN HOMBRE COMPUTADOR',1,'[{\"added\": {}}]',16,1),(134,'2023-11-13 23:11:19.054298','36','2018, 202W0706, MÉTODOS FORMALES PARA PRUEBAS, 2018, 202W0503, CALIDAD DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(135,'2023-11-13 23:11:38.410730','37','2018, 202W0706, MÉTODOS FORMALES PARA PRUEBAS, 2018, 202W0605, GESTIÓN DE LA CONFIGURACIÓN DEL SOFTWARE',1,'[{\"added\": {}}]',16,1),(136,'2023-11-13 23:11:54.373778','38','2018, 202W0707, REDES Y TRANSMISIÓN DE DATOS, 2018, 202W0607, SISTEMAS OPERATIVOS',1,'[{\"added\": {}}]',16,1),(137,'2023-11-13 23:17:04.701050','39','2018, 202W0801, AUTOMATIZACIÓN Y CONTROL DE SOFTWARE, 2018, 202W0707, REDES Y TRANSMISIÓN DE DATOS',1,'[{\"added\": {}}]',16,1),(138,'2023-11-13 23:17:19.986619','40','2018, 202W0802, INTELIGENCIA DE NEGOCIOS, 2018, 202W0501, ANÁLISIS Y DISEÑO DE ALGORITMOS',1,'[{\"added\": {}}]',16,1),(139,'2023-11-13 23:17:37.738194','41','2018, 202W0802, INTELIGENCIA DE NEGOCIOS, 2018, 202W0702, BASE DE DATOS II',1,'[{\"added\": {}}]',16,1),(140,'2023-11-13 23:17:55.530797','42','2018, 202W0803, METODOLOGÍA DE LA INVESTIGACIÓN, 2018, 202W0701, ARQUITECTURA DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(141,'2023-11-13 23:18:10.612320','43','2018, 202W0803, METODOLOGÍA DE LA INVESTIGACIÓN, 2018, 202W0705, INTELIGENCIA ARTIFICIAL',1,'[{\"added\": {}}]',16,1),(142,'2023-11-13 23:18:28.501676','44','2018, 202W0804, MINERÍA DE DATOS, 2018, 202W0702, BASE DE DATOS II',1,'[{\"added\": {}}]',16,1),(143,'2023-11-13 23:18:44.404757','45','2018, 202W0805, PROGRAMACIÓN CONCURRENTE Y PARALELA, 2018, 202W0607, SISTEMAS OPERATIVOS',1,'[{\"added\": {}}]',16,1),(144,'2023-11-13 23:19:00.840944','46','2018, 202W0806, SEGURIDAD DEL SOFTWARE, 2018, 202W0601, ASEGURAMIENTO DE LA CALIDAD DEL SOFTWARE',1,'[{\"added\": {}}]',16,1),(145,'2023-11-13 23:19:18.329575','47','2018, 202W0806, SEGURIDAD DEL SOFTWARE, 2018, 202W0707, REDES Y TRANSMISIÓN DE DATOS',1,'[{\"added\": {}}]',16,1),(146,'2023-11-13 23:19:38.062921','48','2018, 202W0807, TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB, 2018, 202W0701, ARQUITECTURA DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(147,'2023-11-13 23:20:00.330312','49','2018, 202W0807, TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB, 2018, 202W0702, BASE DE DATOS II',1,'[{\"added\": {}}]',16,1),(148,'2023-11-13 23:20:16.600098','50','2018, 202W0807, TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB, 2018, 202W0703, EXPERIENCIA DE USUARIO Y USABILIDAD',1,'[{\"added\": {}}]',16,1),(149,'2023-11-13 23:20:38.171900','51','2018, 202W0807, TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB, 2018, 202W0707, REDES Y TRANSMISIÓN DE DATOS',1,'[{\"added\": {}}]',16,1),(150,'2023-11-13 23:24:27.953320','52','2018, 202W0808, VERIFICACIÓN Y VALIDACIÓN DE SOFTWARE, 2018, 202W0706, MÉTODOS FORMALES PARA PRUEBAS',1,'[{\"added\": {}}]',16,1),(151,'2023-11-13 23:26:52.832152','53','2018, 202W0901, DESARROLLO DE TESIS I, 2018, 202W0803, METODOLOGÍA DE LA INVESTIGACIÓN',1,'[{\"added\": {}}]',16,1),(152,'2023-11-13 23:27:10.321297','54','2018, 202W0902, GARANTÍA DE SOFTWARE, 2018, 202W0806, SEGURIDAD DEL SOFTWARE',1,'[{\"added\": {}}]',16,1),(153,'2023-11-13 23:27:26.620838','55','2018, 202W0903, GERENCIA DE TECNOLOGÍA DE LA INFORMACIÓN, 2018, 202W0704, GESTIÓN DE PROYECTO DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(154,'2023-11-13 23:27:42.048599','56','2018, 202W0904, GESTIÓN DE MANTENIMIENTO DEL SOFTWARE, 2018, 202W0807, TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB',1,'[{\"added\": {}}]',16,1),(155,'2023-11-13 23:27:58.021502','57','2018, 202W0905, GESTIÓN DE RIESGO DEL SOFTWARE, 2018, 202W0704, GESTIÓN DE PROYECTO DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(156,'2023-11-13 23:28:13.585234','58','2018, 202W0906, INTERNET DE LAS COSAS, 2018, 202W0801, AUTOMATIZACIÓN Y CONTROL DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(157,'2023-11-13 23:28:30.848304','59','2018, 202W0907, TALLER DE CONSTRUCCIÓN DE SOFTWARE MÓVIL, 2018, 202W0807, TALLER DE CONSTRUCCIÓN DE SOFTWARE WEB',1,'[{\"added\": {}}]',16,1),(158,'2023-11-13 23:29:25.138431','60','2018, 202W0907, TALLER DE CONSTRUCCIÓN DE SOFTWARE MÓVIL, 2018, 202W0808, VERIFICACIÓN Y VALIDACIÓN DE SOFTWARE',1,'[{\"added\": {}}]',16,1),(159,'2023-11-13 23:29:42.849696','61','2018, 202W0908, SOFTWARE INTELIGENTE, 2018, 202W0705, INTELIGENCIA ARTIFICIAL',1,'[{\"added\": {}}]',16,1),(160,'2023-11-13 23:29:58.889576','62','2018, 202W1001, ANALÍTICA DE DATOS, 2018, 202W0802, INTELIGENCIA DE NEGOCIOS',1,'[{\"added\": {}}]',16,1),(161,'2023-11-13 23:30:13.697782','63','2018, 202W1001, ANALÍTICA DE DATOS, 2018, 202W0908, SOFTWARE INTELIGENTE',1,'[{\"added\": {}}]',16,1),(162,'2023-11-13 23:30:31.960974','64','2018, 202W1002, DESARROLLO DE TESIS II, 2018, 202W0901, DESARROLLO DE TESIS I',1,'[{\"added\": {}}]',16,1),(163,'2023-11-13 23:30:47.041186','65','2018, 202W1003, PRÁCTICA PRE PROFESIONAL, 2018, 202W0907, TALLER DE CONSTRUCCIÓN DE SOFTWARE MÓVIL',1,'[{\"added\": {}}]',16,1),(164,'2023-11-13 23:31:02.602357','66','2018, 202W1004, TALLER DE APLICACIONES SOCIALES, 2018, 202W0907, TALLER DE CONSTRUCCIÓN DE SOFTWARE MÓVIL',1,'[{\"added\": {}}]',16,1),(165,'2023-11-13 23:31:18.646105','67','2018, 202W1005, TENDENCIAS DE ARQUITECTURA DE SOFTWARE, 2018, 202W0907, TALLER DE CONSTRUCCIÓN DE SOFTWARE MÓVIL',1,'[{\"added\": {}}]',16,1),(166,'2023-11-13 23:31:37.056243','68','2018, 202W1006, TENDENCIAS EN INGENIERÍA DE SOFTWARE Y GESTIÓN, 2018, 202W0903, GERENCIA DE TECNOLOGÍA DE LA INFORMACIÓN',1,'[{\"added\": {}}]',16,1),(167,'2023-11-13 23:40:35.264215','1','Semestre 2023-II, 2018, INE002, PROGRAMACIÓN Y COMPUTACIÓN1',1,'[{\"added\": {}}]',15,1),(168,'2023-11-14 00:18:10.461701','1','Semestre 2023-II, 2018, INE002, PROGRAMACIÓN Y COMPUTACIÓN1',3,'',15,1),(169,'2023-11-14 00:32:57.587731','2','Semestre 2023-II, 2018, INE002, PROGRAMACIÓN Y COMPUTACIÓN1',1,'[{\"added\": {}}]',15,1),(170,'2023-11-14 00:34:47.268665','3','Semestre 2023-II, 2018, INE013, EMPRENDIMIENTO E INNOVACIÓN1',1,'[{\"added\": {}}]',15,1),(171,'2023-11-14 00:35:00.267694','4','Semestre 2023-II, 2018, INE013, EMPRENDIMIENTO E INNOVACIÓN2',1,'[{\"added\": {}}]',15,1),(172,'2023-11-14 00:35:21.189046','5','Semestre 2023-II, 2018, INE013, EMPRENDIMIENTO E INNOVACIÓN3',1,'[{\"added\": {}}]',15,1),(173,'2023-11-14 00:35:33.954752','6','Semestre 2023-II, 2018, INE013, EMPRENDIMIENTO E INNOVACIÓN4',1,'[{\"added\": {}}]',15,1),(174,'2023-11-14 00:35:56.849883','7','Semestre 2023-II, 2018, INO101, REDACCIÓN Y TÉCNICAS DE COMUNICACIÓN EFECTIVA I1',1,'[{\"added\": {}}]',15,1),(175,'2023-11-14 00:36:23.648605','8','Semestre 2023-II, 2018, INO102, MÉTODOS DE ESTUDIO UNIVERSITARIO1',1,'[{\"added\": {}}]',15,1),(176,'2023-11-14 00:36:42.886750','9','Semestre 2023-II, 2018, INO103, DESARROLLO PERSONAL Y LIDERAZGO1',1,'[{\"added\": {}}]',15,1),(177,'2023-11-14 00:37:05.223107','10','Semestre 2023-II, 2018, INO104, CÁLCULO I1',1,'[{\"added\": {}}]',15,1),(178,'2023-11-14 00:37:17.320615','11','Semestre 2023-II, 2018, INO104, CÁLCULO I2',1,'[{\"added\": {}}]',15,1),(179,'2023-11-14 00:37:30.526336','12','Semestre 2023-II, 2018, INO104, CÁLCULO I3',1,'[{\"added\": {}}]',15,1),(180,'2023-11-14 00:37:50.011623','13','Semestre 2023-II, 2018, INO105, BIOLOGÍA PARA CIENCIAS E INGENIERÍA1',1,'[{\"added\": {}}]',15,1),(181,'2023-11-14 00:38:09.604682','14','Semestre 2023-II, 2018, INO106, ÁLGEBRA Y GEOMETRÍA ANALÍTICA1',1,'[{\"added\": {}}]',15,1),(182,'2023-11-14 00:38:26.960896','15','Semestre 2023-II, 2018, INO107, MEDIO AMBIENTE Y DESARROLLO SOSTENIBLE1',1,'[{\"added\": {}}]',15,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(19,'administrativo','aula'),(21,'administrativo','grupohorario'),(20,'administrativo','local'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(11,'escuela','curso'),(18,'escuela','cursoequivalente'),(17,'escuela','cursohorasdictado'),(16,'escuela','cursoprerequisito'),(12,'escuela','cursotipo'),(13,'escuela','cursotipodictado'),(15,'escuela','grupo'),(14,'escuela','planestudio'),(7,'general','areaacademica'),(8,'general','dia'),(10,'general','escuela'),(9,'general','facultad'),(6,'sessions','session'),(22,'vicerrectorado','semestre');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-11-13 18:17:32.423359'),(2,'auth','0001_initial','2023-11-13 18:17:36.790895'),(3,'admin','0001_initial','2023-11-13 18:17:37.741398'),(4,'admin','0002_logentry_remove_auto_add','2023-11-13 18:17:37.799711'),(5,'admin','0003_logentry_add_action_flag_choices','2023-11-13 18:17:37.900236'),(6,'general','0001_initial','2023-11-13 18:17:39.888502'),(7,'vicerrectorado','0001_initial','2023-11-13 18:17:40.120914'),(8,'escuela','0001_initial','2023-11-13 18:17:45.924940'),(9,'administrativo','0001_initial','2023-11-13 18:17:48.927912'),(10,'administrativo','0002_aula_aul_imgimage_aula_aul_vclatitud_and_more','2023-11-13 18:17:49.195318'),(11,'administrativo','0003_alter_aula_aul_imgimage_alter_local_loc_icodigo','2023-11-13 18:17:49.262909'),(12,'contenttypes','0002_remove_content_type_name','2023-11-13 18:17:49.907352'),(13,'auth','0002_alter_permission_name_max_length','2023-11-13 18:17:50.169613'),(14,'auth','0003_alter_user_email_max_length','2023-11-13 18:17:50.293700'),(15,'auth','0004_alter_user_username_opts','2023-11-13 18:17:50.342547'),(16,'auth','0005_alter_user_last_login_null','2023-11-13 18:17:51.161070'),(17,'auth','0006_require_contenttypes_0002','2023-11-13 18:17:51.224281'),(18,'auth','0007_alter_validators_add_error_messages','2023-11-13 18:17:51.281208'),(19,'auth','0008_alter_user_username_max_length','2023-11-13 18:17:52.099386'),(20,'auth','0009_alter_user_last_name_max_length','2023-11-13 18:17:52.398442'),(21,'auth','0010_alter_group_name_max_length','2023-11-13 18:17:52.877216'),(22,'auth','0011_update_proxy_permissions','2023-11-13 18:17:52.968714'),(23,'auth','0012_alter_user_first_name_max_length','2023-11-13 18:17:53.210919'),(24,'general','0002_alter_escuela_areaca_icodigo','2023-11-13 18:17:53.260888'),(25,'escuela','0002_alter_curso_curare_icodigo_and_more','2023-11-13 18:17:55.022525'),(26,'escuela','0003_alter_cursotipo_curtip_icodigo_and_more','2023-11-13 18:17:55.220974'),(27,'general','0003_alter_facultad_fac_icodigo','2023-11-13 18:17:55.265844'),(28,'sessions','0001_initial','2023-11-13 18:17:56.029629'),(29,'vicerrectorado','0002_alter_semestre_sem_icodigo','2023-11-13 18:17:56.214778'),(30,'escuela','0004_grupo_gru_itope_alter_cursotipo_curtip_icodigo_and_more','2023-11-14 00:25:48.522059');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('7u3669or72c15qwknf71t9fyt17c6hjv','.eJxVjDsOwyAQBe9CHSG-xqRM7zOgBXaDkwgkY1dR7h5bcpG0b2bemwXY1hK2jkuYM7syyS6_W4T0xHqA_IB6bzy1ui5z5IfCT9r51DK-bqf7d1Cgl70GqaIiawczamWzdskJnyhbhVIYAu89ZmusA-0GJ8wojI67owxCJCL2-QLF8zd3:1r2bWm:JWk66DG-qE-H83CeCvjJZm-nnVx7ZIqGOODLYxz2SUg','2023-11-27 18:19:16.015452');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escuela`
--

DROP TABLE IF EXISTS `escuela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `escuela` (
  `esc_iCodigo` int NOT NULL AUTO_INCREMENT,
  `esc_vcCodigo` varchar(16) NOT NULL,
  `esc_vcNombre` varchar(96) NOT NULL,
  `esc_bActivo` int NOT NULL,
  `areaca_iCodigo_id` int NOT NULL,
  `fac_iCodigo_id` int NOT NULL,
  PRIMARY KEY (`esc_iCodigo`),
  UNIQUE KEY `esc_vcCodigo` (`esc_vcCodigo`),
  UNIQUE KEY `esc_vcNombre` (`esc_vcNombre`),
  KEY `escuela_areaca_iCodigo_id_050a0b33_fk_area_acad` (`areaca_iCodigo_id`),
  KEY `escuela_fac_iCodigo_id_2c314744_fk_facultad_fac_iCodigo` (`fac_iCodigo_id`),
  CONSTRAINT `escuela_areaca_iCodigo_id_050a0b33_fk_area_acad` FOREIGN KEY (`areaca_iCodigo_id`) REFERENCES `area_academica` (`areaca_iCodigo`),
  CONSTRAINT `escuela_fac_iCodigo_id_2c314744_fk_facultad_fac_iCodigo` FOREIGN KEY (`fac_iCodigo_id`) REFERENCES `facultad` (`fac_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escuela`
--

LOCK TABLES `escuela` WRITE;
/*!40000 ALTER TABLE `escuela` DISABLE KEYS */;
INSERT INTO `escuela` VALUES (1,'20.1','Ingeniería de Sistemas',1,3,20),(2,'20.2','Ingeniería de Software',1,3,20);
/*!40000 ALTER TABLE `escuela` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facultad`
--

DROP TABLE IF EXISTS `facultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultad` (
  `fac_iCodigo` int NOT NULL AUTO_INCREMENT,
  `fac_vcCodigo` varchar(64) NOT NULL,
  `fac_vcNombre` varchar(64) NOT NULL,
  PRIMARY KEY (`fac_iCodigo`),
  UNIQUE KEY `fac_vcCodigo` (`fac_vcCodigo`),
  UNIQUE KEY `fac_vcNombre` (`fac_vcNombre`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultad`
--

LOCK TABLES `facultad` WRITE;
/*!40000 ALTER TABLE `facultad` DISABLE KEYS */;
INSERT INTO `facultad` VALUES (1,'1','Facultad de Medicina Humana'),(2,'2','Facultad de Derecho y Ciencia Política'),(3,'3','Facultad de Letras y Ciencias Humanas'),(4,'4','Facultad de Farmacia y Bioquímica'),(5,'5','Facultad de Odontología'),(6,'6','Facultad de Educación'),(7,'7','Facultad de Química e Ingeniería Química'),(8,'8','Facultad de Medicina Veterinaria'),(9,'9','Facultad de Ciencias Administrativas'),(10,'10','Facultad de Ciencias Biológicas'),(11,'11','Facultad de Ciencias Contables'),(12,'12','Facultad de Ciencias Económicas'),(13,'13','Facultad de Ciencias Físicas'),(14,'14','Facultad de Ciencias Matemáticas'),(15,'15','Facultad de Ciencias Sociales'),(17,'17','Facultad de Ingeniería Industrial'),(18,'18','Facultad de Psicología'),(19,'19','Facultad de Ingeniería Electrónica y Eléctrica'),(20,'20','Facultad de Ingeniería de Sistemas e Informática');
/*!40000 ALTER TABLE `facultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` (
  `gru_iCodigo` int NOT NULL AUTO_INCREMENT,
  `gru_iNumero` int NOT NULL,
  `cur_iCodigo_id` int NOT NULL,
  `sem_iCodigo_id` int NOT NULL,
  `gru_iTope` int NOT NULL,
  PRIMARY KEY (`gru_iCodigo`),
  KEY `grupo_cur_iCodigo_id_9c1c6b94_fk_curso_cur_iCodigo` (`cur_iCodigo_id`),
  KEY `grupo_sem_iCodigo_id_182d3c65_fk_semestre_sem_iCodigo` (`sem_iCodigo_id`),
  CONSTRAINT `grupo_cur_iCodigo_id_9c1c6b94_fk_curso_cur_iCodigo` FOREIGN KEY (`cur_iCodigo_id`) REFERENCES `curso` (`cur_iCodigo`),
  CONSTRAINT `grupo_sem_iCodigo_id_182d3c65_fk_semestre_sem_iCodigo` FOREIGN KEY (`sem_iCodigo_id`) REFERENCES `semestre` (`sem_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
INSERT INTO `grupo` VALUES (2,1,1,2,30),(3,1,9,2,40),(4,2,9,2,40),(5,3,9,2,40),(6,4,9,2,40),(7,1,2,2,30),(8,1,3,2,30),(9,1,4,2,30),(10,1,5,2,40),(11,2,5,2,42),(12,3,5,2,45),(13,1,6,2,30),(14,1,7,2,42),(15,1,8,2,30);
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_horario`
--

DROP TABLE IF EXISTS `grupo_horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_horario` (
  `gruhor_iCodigo` int NOT NULL AUTO_INCREMENT,
  `gruhor_tHoraInicio` time(6) NOT NULL,
  `gruhor_tHoraFinal` time(6) NOT NULL,
  `aul_iCodigo_id` int NOT NULL,
  `curtip_iCodigo_id` int NOT NULL,
  `dia_iCodigo_id` int NOT NULL,
  `gru_iCodigo_id` int NOT NULL,
  PRIMARY KEY (`gruhor_iCodigo`),
  KEY `grupo_horario_aul_iCodigo_id_e07f4bcd_fk_aula_aul_iCodigo` (`aul_iCodigo_id`),
  KEY `grupo_horario_curtip_iCodigo_id_24928941_fk_curso_tip` (`curtip_iCodigo_id`),
  KEY `grupo_horario_dia_iCodigo_id_40203af8_fk_dia_dia_iCodigo` (`dia_iCodigo_id`),
  KEY `grupo_horario_gru_iCodigo_id_f7c79985_fk_grupo_gru_iCodigo` (`gru_iCodigo_id`),
  CONSTRAINT `grupo_horario_aul_iCodigo_id_e07f4bcd_fk_aula_aul_iCodigo` FOREIGN KEY (`aul_iCodigo_id`) REFERENCES `aula` (`aul_iCodigo`),
  CONSTRAINT `grupo_horario_curtip_iCodigo_id_24928941_fk_curso_tip` FOREIGN KEY (`curtip_iCodigo_id`) REFERENCES `curso_tipodictado` (`curtip_iCodigo`),
  CONSTRAINT `grupo_horario_dia_iCodigo_id_40203af8_fk_dia_dia_iCodigo` FOREIGN KEY (`dia_iCodigo_id`) REFERENCES `dia` (`dia_iCodigo`),
  CONSTRAINT `grupo_horario_gru_iCodigo_id_f7c79985_fk_grupo_gru_iCodigo` FOREIGN KEY (`gru_iCodigo_id`) REFERENCES `grupo` (`gru_iCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_horario`
--

LOCK TABLES `grupo_horario` WRITE;
/*!40000 ALTER TABLE `grupo_horario` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo_horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local`
--

DROP TABLE IF EXISTS `local`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local` (
  `loc_iCodigo` int NOT NULL AUTO_INCREMENT,
  `loc_vcCodigo` varchar(32) NOT NULL,
  `loc_vcNombre` varchar(64) NOT NULL,
  PRIMARY KEY (`loc_iCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local`
--

LOCK TABLES `local` WRITE;
/*!40000 ALTER TABLE `local` DISABLE KEYS */;
/*!40000 ALTER TABLE `local` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_estudio`
--

DROP TABLE IF EXISTS `plan_estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan_estudio` (
  `plaest_iCodigo` int NOT NULL AUTO_INCREMENT,
  `plaest_vcCodigo` varchar(8) NOT NULL,
  `plaest_vcRR` varchar(16) NOT NULL,
  `plaest_dVigencia` datetime(6) NOT NULL,
  `plaest_iCreditos` int NOT NULL,
  `plaest_bActivo` int NOT NULL,
  `esc_iCodigo_id` int NOT NULL,
  PRIMARY KEY (`plaest_iCodigo`),
  UNIQUE KEY `plaest_vcCodigo` (`plaest_vcCodigo`),
  KEY `plan_estudio_esc_iCodigo_id_d42301b8_fk_escuela_esc_iCodigo` (`esc_iCodigo_id`),
  CONSTRAINT `plan_estudio_esc_iCodigo_id_d42301b8_fk_escuela_esc_iCodigo` FOREIGN KEY (`esc_iCodigo_id`) REFERENCES `escuela` (`esc_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_estudio`
--

LOCK TABLES `plan_estudio` WRITE;
/*!40000 ALTER TABLE `plan_estudio` DISABLE KEYS */;
INSERT INTO `plan_estudio` VALUES (1,'2009','RR-2009','2009-01-01 05:00:00.000000',226,1,2),(2,'2015','RR-2015','2015-01-01 05:00:00.000000',226,1,2),(3,'2018','RR-2018','2019-01-01 05:00:00.000000',226,1,2),(4,'2023','RR-2023','2023-01-01 05:00:00.000000',226,0,2);
/*!40000 ALTER TABLE `plan_estudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semestre`
--

DROP TABLE IF EXISTS `semestre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semestre` (
  `sem_iCodigo` int NOT NULL AUTO_INCREMENT,
  `sem_vcCodigo` varchar(8) NOT NULL,
  `sem_cActivo` varchar(1) NOT NULL,
  PRIMARY KEY (`sem_iCodigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semestre`
--

LOCK TABLES `semestre` WRITE;
/*!40000 ALTER TABLE `semestre` DISABLE KEYS */;
INSERT INTO `semestre` VALUES (1,'2023-I','N'),(2,'2023-II','S');
/*!40000 ALTER TABLE `semestre` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-14 15:04:14
