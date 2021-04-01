-- MySQL dump 10.17  Distrib 10.3.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: aulos
-- ------------------------------------------------------
-- Server version	10.3.25-MariaDB-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Attrezzatura`
--

DROP TABLE IF EXISTS `Attrezzatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Attrezzatura` (
  `attrezzatura_id` int(11) NOT NULL AUTO_INCREMENT,
  `attrezzatura_nome` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`attrezzatura_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attrezzatura`
--

LOCK TABLES `Attrezzatura` WRITE;
/*!40000 ALTER TABLE `Attrezzatura` DISABLE KEYS */;
INSERT INTO `Attrezzatura` VALUES (1,'Lavagna'),(2,'Lavagna Digitale'),(3,'Stampante Multifunzione'),(4,'Proiettore'),(5,'Stampante 3D'),(6,'Connessione ADSL'),(7,'Microfono'),(8,'Computer'),(9,'Impianto Videoregistrazione'),(10,'Impianto Videoconferenza');
/*!40000 ALTER TABLE `Attrezzatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Aula`
--

DROP TABLE IF EXISTS `Aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Aula` (
  `aula_id` int(11) NOT NULL AUTO_INCREMENT,
  `aula_capienza_max` int(11) DEFAULT NULL,
  `aula_capienza_min` int(11) DEFAULT NULL,
  `aula_nome` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`aula_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aula`
--

LOCK TABLES `Aula` WRITE;
/*!40000 ALTER TABLE `Aula` DISABLE KEYS */;
INSERT INTO `Aula` VALUES (1,330,0,'Aula Magna'),(2,199,80,'Aula 101'),(3,79,30,'Aula 102'),(4,199,80,'Aula 103'),(5,79,30,'Aula 104'),(6,199,80,'Aula 105'),(7,29,1,'Aula 201'),(8,79,30,'Aula 202'),(9,29,1,'Aula 203'),(10,29,1,'Aula 204'),(11,29,1,'Aula 205'),(12,16,0,'Laboratorio Matematica'),(13,24,0,'Laboratorio Informatica'),(14,27,0,'Laboratorio Microscopia'),(15,20,0,'Laboratorio Chimica Biologia');
/*!40000 ALTER TABLE `Aula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dispositivo`
--

DROP TABLE IF EXISTS `Dispositivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dispositivo` (
  `dipositivo_id` int(11) NOT NULL AUTO_INCREMENT,
  `dispositivo_data_installazione` date DEFAULT NULL,
  `dispositivo_marca` varchar(255) DEFAULT NULL,
  `dispositivo_nome` varchar(255) DEFAULT NULL,
  `aula_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dipositivo_id`),
  KEY `FK1m1xtr6vxst73cndx8lkkp5lb` (`aula_id`),
  CONSTRAINT `FK1m1xtr6vxst73cndx8lkkp5lb` FOREIGN KEY (`aula_id`) REFERENCES `Aula` (`aula_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dispositivo`
--

LOCK TABLES `Dispositivo` WRITE;
/*!40000 ALTER TABLE `Dispositivo` DISABLE KEYS */;
INSERT INTO `Dispositivo` VALUES (1,'2021-03-23','aulos-iot-v1','aulos-iot-v1',NULL);
/*!40000 ALTER TABLE `Dispositivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Evento`
--

DROP TABLE IF EXISTS `Evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Evento` (
  `evento_id` int(11) NOT NULL AUTO_INCREMENT,
  `evento_data_ora_fine` datetime(6) DEFAULT NULL,
  `evento_data_ora_inizio` datetime(6) DEFAULT NULL,
  `finalizzato` bit(1) DEFAULT NULL,
  `evento_grado_riemp_aula` double DEFAULT NULL,
  `evento_max_presenti` int(11) DEFAULT NULL,
  `evento_n_presenti` int(11) DEFAULT NULL,
  `evento_nome` varchar(255) DEFAULT NULL,
  `evento_tipo` varchar(255) DEFAULT NULL,
  `aula_id` int(11) DEFAULT NULL,
  `responsabile_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`evento_id`),
  KEY `FK9ilyvdkibcmv0dvyscl3uaiq0` (`aula_id`),
  KEY `FK4ucu0r9jidoru9l1g07sbvpci` (`responsabile_id`),
  CONSTRAINT `FK4ucu0r9jidoru9l1g07sbvpci` FOREIGN KEY (`responsabile_id`) REFERENCES `Responsabile` (`responsabile_id`),
  CONSTRAINT `FK9ilyvdkibcmv0dvyscl3uaiq0` FOREIGN KEY (`aula_id`) REFERENCES `Aula` (`aula_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Evento`
--

LOCK TABLES `Evento` WRITE;
/*!40000 ALTER TABLE `Evento` DISABLE KEYS */;
INSERT INTO `Evento` VALUES (1,'2021-03-24 12:00:00.000000','2021-03-24 10:00:00.000000','\0',1,0,0,'Fisica','Lezione',1,9),(2,'2021-03-25 12:00:00.000000','2021-03-25 08:00:00.000000','\0',1,0,0,'Genetica 1','Lezione',2,12),(3,'2021-03-26 10:00:00.000000','2021-03-26 08:00:00.000000','\0',1,0,0,'Anatomia Umana','Lezione',3,12),(4,'2021-03-26 13:00:00.000000','2021-03-26 10:00:00.000000','\0',1,0,0,'Chimica Organica','Lezione',3,13),(5,'2021-03-25 17:00:00.000000','2021-03-25 15:00:00.000000','\0',1,0,0,'Fisica Didattica Integrativa','Lezione',4,11),(6,'2021-03-26 10:00:00.000000','2021-03-26 07:00:00.000000','\0',1,0,0,'Statistica','Lezione',5,9),(7,'2021-03-29 11:00:00.000000','2021-03-29 09:00:00.000000','\0',1,0,0,'Economia Aziendale','Lezione',6,11),(8,'2021-03-30 11:00:00.000000','2021-03-30 09:00:00.000000','\0',1,0,0,'Diritto Privato','Lezioni',7,11),(9,'2021-03-30 14:00:00.000000','2021-03-30 12:00:00.000000','\0',1,0,0,'Economia Politica','Lezione',8,13),(10,'2021-04-01 09:00:00.000000','2021-04-01 07:00:00.000000','\0',1,0,0,'Inglese','Lezione',11,11),(11,'2021-03-31 11:00:00.000000','2021-04-01 09:00:00.000000','\0',1,0,0,'Filosofia del Diritto','Lezione',11,14),(12,'2021-03-31 15:00:00.000000','2021-03-31 12:00:00.000000','\0',1,0,0,'Storia Diritto Moderno','Lezione',11,14),(13,'2021-04-02 16:00:00.000000','2021-04-02 12:00:00.000000','\0',1,0,0,'Informatica','Lezione',13,13);
/*!40000 ALTER TABLE `Evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Responsabile`
--

DROP TABLE IF EXISTS `Responsabile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Responsabile` (
  `responsabile_id` int(11) NOT NULL AUTO_INCREMENT,
  `responsabile_cognome` varchar(255) DEFAULT NULL,
  `responsabile_nome` varchar(255) DEFAULT NULL,
  `responsabile_username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`responsabile_id`),
  UNIQUE KEY `UK_dvcemmsgidxfgk6rviq6en4bd` (`responsabile_username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Responsabile`
--

LOCK TABLES `Responsabile` WRITE;
/*!40000 ALTER TABLE `Responsabile` DISABLE KEYS */;
INSERT INTO `Responsabile` VALUES (9,'Fano','Aurora','es_resposabile_1'),(10,'Taranto','Mattia','es_responsabile_2'),(11,'Capirossi','Monica','es_supervisore_1'),(12,'Barge','Antonio','es_supervisore_2'),(13,'Achillea','Davide','es_amministratore_1'),(14,'Bettini','Alessia','es_amministratore_2');
/*!40000 ALTER TABLE `Responsabile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aula_attrezzatura`
--

DROP TABLE IF EXISTS `aula_attrezzatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aula_attrezzatura` (
  `aula_id` int(11) NOT NULL,
  `attrezzatura_id` int(11) NOT NULL,
  KEY `FKsgru81wbypkpas5s3w8np3ugs` (`attrezzatura_id`),
  KEY `FKrbx5u7ykh5qve3b99086x56vr` (`aula_id`),
  CONSTRAINT `FKrbx5u7ykh5qve3b99086x56vr` FOREIGN KEY (`aula_id`) REFERENCES `Aula` (`aula_id`),
  CONSTRAINT `FKsgru81wbypkpas5s3w8np3ugs` FOREIGN KEY (`attrezzatura_id`) REFERENCES `Attrezzatura` (`attrezzatura_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aula_attrezzatura`
--

LOCK TABLES `aula_attrezzatura` WRITE;
/*!40000 ALTER TABLE `aula_attrezzatura` DISABLE KEYS */;
/*!40000 ALTER TABLE `aula_attrezzatura` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-25 15:07:37
