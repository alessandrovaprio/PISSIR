-- MySQL dump 10.17  Distrib 10.3.25-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: keycloak
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
-- Table structure for table `ADMIN_EVENT_ENTITY`
--

DROP TABLE IF EXISTS `ADMIN_EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ADMIN_EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `ADMIN_EVENT_TIME` bigint(20) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `OPERATION_TYPE` varchar(255) DEFAULT NULL,
  `AUTH_REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_CLIENT_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `RESOURCE_PATH` text DEFAULT NULL,
  `REPRESENTATION` text DEFAULT NULL,
  `ERROR` varchar(255) DEFAULT NULL,
  `RESOURCE_TYPE` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADMIN_EVENT_ENTITY`
--

LOCK TABLES `ADMIN_EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSOCIATED_POLICY`
--

DROP TABLE IF EXISTS `ASSOCIATED_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ASSOCIATED_POLICY` (
  `POLICY_ID` varchar(36) NOT NULL,
  `ASSOCIATED_POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`POLICY_ID`,`ASSOCIATED_POLICY_ID`),
  KEY `IDX_ASSOC_POL_ASSOC_POL_ID` (`ASSOCIATED_POLICY_ID`),
  CONSTRAINT `FK_FRSR5S213XCX4WNKOG82SSRFY` FOREIGN KEY (`ASSOCIATED_POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPAS14XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSOCIATED_POLICY`
--

LOCK TABLES `ASSOCIATED_POLICY` WRITE;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_EXECUTION`
--

DROP TABLE IF EXISTS `AUTHENTICATION_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATION_EXECUTION` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `AUTHENTICATOR` varchar(36) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `REQUIREMENT` int(11) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `AUTHENTICATOR_FLOW` bit(1) NOT NULL DEFAULT b'0',
  `AUTH_FLOW_ID` varchar(36) DEFAULT NULL,
  `AUTH_CONFIG` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_EXEC_REALM_FLOW` (`REALM_ID`,`FLOW_ID`),
  KEY `IDX_AUTH_EXEC_FLOW` (`FLOW_ID`),
  CONSTRAINT `FK_AUTH_EXEC_FLOW` FOREIGN KEY (`FLOW_ID`) REFERENCES `AUTHENTICATION_FLOW` (`ID`),
  CONSTRAINT `FK_AUTH_EXEC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_EXECUTION`
--

LOCK TABLES `AUTHENTICATION_EXECUTION` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_EXECUTION` VALUES ('000b3911-d19b-41d4-aa5b-cb858946d9f4',NULL,'reset-credentials-choose-user','Aulos','1416d4ab-56fa-4bfa-8be2-f684fc9430eb',0,10,'\0',NULL,NULL),('0a9f3cb5-7f13-4f0b-abbd-a772a89fa666',NULL,'reset-otp','master','8666df2f-418a-46a7-85ee-1c0c308d150c',0,20,'\0',NULL,NULL),('0edf47e3-a641-4253-b786-9f75d2346001',NULL,'reset-credentials-choose-user','master','89dbfd7a-e12f-4096-8f67-9305270f6154',0,10,'\0',NULL,NULL),('1092eace-55b9-42d0-bbe3-9443f4ea2ca2',NULL,'idp-create-user-if-unique','master','f2dccb51-2af1-4d38-a126-ae434d360ab8',2,10,'\0',NULL,'7ff33131-21ea-4e9d-98f3-4d4e3412f44c'),('10a40441-f4c1-4990-baa7-bc140c063d6e',NULL,NULL,'Aulos','4e3345de-4d06-4f68-a4e5-c5cb3d9f0585',2,30,'','71e6888f-c4da-408f-882e-7770bdb14dad',NULL),('1647e0fd-abbc-4b2d-bc83-5390838a3759',NULL,'idp-confirm-link','master','6375869b-46a9-4e85-8afc-4157f1bcdb2b',0,10,'\0',NULL,NULL),('218af30d-1a62-4b27-97b1-f2b95b434195',NULL,'idp-review-profile','master','97fc9401-dbfa-404a-9d3d-57478c633670',0,10,'\0',NULL,'04d1da98-db60-4793-9272-34b1f11e53cb'),('235ec444-7d6b-4c70-94e6-5fae91b34452',NULL,'registration-recaptcha-action','Aulos','ea02f0ad-0f68-4323-aa23-d14f9c65839b',3,60,'\0',NULL,NULL),('2714cc3d-41ac-42e6-b374-634a5c07ff57',NULL,NULL,'Aulos','1416d4ab-56fa-4bfa-8be2-f684fc9430eb',1,40,'','5fa5baf9-708a-43aa-b062-8f3c1416394c',NULL),('29175e98-c1c2-4328-8579-bd08444979f2',NULL,'registration-user-creation','master','3f77d15d-2786-4f14-aba2-46597c9bbb73',0,20,'\0',NULL,NULL),('291a0fd8-57b4-4c25-abda-533028622f6b',NULL,'client-secret-jwt','Aulos','43dc8a85-8a7a-4a04-aa98-a45ea85ca7fc',2,30,'\0',NULL,NULL),('29324f44-b981-48f9-a126-499d185eedb6',NULL,'registration-profile-action','master','3f77d15d-2786-4f14-aba2-46597c9bbb73',0,40,'\0',NULL,NULL),('2e630652-c1dc-48f9-9242-76ab7fb74a9d',NULL,'auth-username-password-form','master','b8679085-08b5-49b2-a1d8-8a0904b99265',0,10,'\0',NULL,NULL),('312ecff1-7c06-4870-8d01-076aea63a859',NULL,'reset-password','master','89dbfd7a-e12f-4096-8f67-9305270f6154',0,30,'\0',NULL,NULL),('33a2746c-1512-4082-9591-09b2208e346b',NULL,NULL,'Aulos','2a74d531-3657-4f81-bf1e-935605a6b082',2,20,'','45e96174-d304-4a3e-bab7-192a8bd05bad',NULL),('35883358-2427-4052-b60b-c17ef0dbc8d4',NULL,NULL,'Aulos','71e6888f-c4da-408f-882e-7770bdb14dad',1,20,'','f4f64536-32b3-4d11-90ab-06686ba4bd24',NULL),('3685e4df-aaae-4a35-8ea4-0ffb418e0993',NULL,NULL,'Aulos','0d04ea72-6326-4925-a6ff-58a0ed6189de',0,20,'','2a74d531-3657-4f81-bf1e-935605a6b082',NULL),('377134ee-1723-43a3-927c-c63d57ea0c4b',NULL,NULL,'master','7d75e543-cdff-48f7-8768-8327282d298f',0,20,'','c8e1a14d-73a1-484b-99f0-af956ee18fee',NULL),('38146869-1abf-4bc4-8605-9d636a0d44d3',NULL,'basic-auth','master','c8e1a14d-73a1-484b-99f0-af956ee18fee',0,10,'\0',NULL,NULL),('38c00caa-2b85-4e00-b10a-db7688d0ce55',NULL,'auth-otp-form','Aulos','f4f64536-32b3-4d11-90ab-06686ba4bd24',0,20,'\0',NULL,NULL),('39e69cdd-3ebc-421f-89d5-7ad955be24a2',NULL,NULL,'master','ad63985e-0949-4fd7-9ea7-7e01343e821a',2,30,'','b8679085-08b5-49b2-a1d8-8a0904b99265',NULL),('3e90013a-f98d-434f-97b2-4adb9a7e8897',NULL,'client-x509','master','a782060c-af25-43d0-b88f-96883acbd7ae',2,40,'\0',NULL,NULL),('3f5bdcc1-4a3e-4d28-8a52-b54d82298210',NULL,'idp-create-user-if-unique','Aulos','6028ac8f-1499-4a68-ae3a-93c797321e41',2,10,'\0',NULL,'e6151e0d-6696-4cd1-b720-6704e5212e2d'),('3fd4e5d2-9f47-47c3-9804-25a588cab826',NULL,'conditional-user-configured','master','562af5a2-5301-4d9a-bc45-16d62ca10c5c',0,10,'\0',NULL,NULL),('40d49870-f2c4-4587-8566-61762963b033',NULL,'direct-grant-validate-password','master','df487cbf-fde4-4b9f-99c0-e49cb96bcf02',0,20,'\0',NULL,NULL),('423b9367-5ff4-4a05-92fa-de9eee922cc0',NULL,'direct-grant-validate-password','Aulos','cf91d979-e006-4689-8a8a-c58dd35e9c8c',0,20,'\0',NULL,NULL),('4c53e48b-4b98-405b-b7b0-afbf3ca6878b',NULL,'idp-review-profile','Aulos','03f677f7-4b56-4381-b1d5-504703f3ad89',0,10,'\0',NULL,'353c0541-cc97-4706-9be4-6316b6fbc8e9'),('50afba95-e65e-4ae6-b9c7-8c73e898fe6c',NULL,'direct-grant-validate-username','Aulos','cf91d979-e006-4689-8a8a-c58dd35e9c8c',0,10,'\0',NULL,NULL),('56b3dcb2-8131-4a79-b690-7d02f8ed02a1',NULL,'conditional-user-configured','Aulos','de7ab6a0-ed15-43dd-bddf-869a6788cf0b',0,10,'\0',NULL,NULL),('57bf7a9d-1255-493d-bd52-f23b8905c6bc',NULL,'no-cookie-redirect','master','7d75e543-cdff-48f7-8768-8327282d298f',0,10,'\0',NULL,NULL),('57e111a0-6f8a-42e1-a96a-424cf32da3d3',NULL,'idp-username-password-form','Aulos','45e96174-d304-4a3e-bab7-192a8bd05bad',0,10,'\0',NULL,NULL),('69f0d75d-59cb-4808-857d-cf72258dc881',NULL,'no-cookie-redirect','Aulos','1a909b4e-f059-4a1b-a8ce-8542fe14ce97',0,10,'\0',NULL,NULL),('6dcb6692-205e-43bf-9787-ee3bceedcd65',NULL,'reset-credential-email','master','89dbfd7a-e12f-4096-8f67-9305270f6154',0,20,'\0',NULL,NULL),('6ea85469-abc4-4729-8cd1-74b6d73c13e5',NULL,'auth-cookie','master','ad63985e-0949-4fd7-9ea7-7e01343e821a',2,10,'\0',NULL,NULL),('70a50c11-e42a-47fe-ae69-1537cbe60fbb',NULL,NULL,'Aulos','03f677f7-4b56-4381-b1d5-504703f3ad89',0,20,'','6028ac8f-1499-4a68-ae3a-93c797321e41',NULL),('721519cd-93de-4f45-8eb4-42adcc79b1e5',NULL,'basic-auth','Aulos','1ae930e4-c4af-4d4e-b885-bdbb6f77a6ff',0,10,'\0',NULL,NULL),('74b81a5e-3213-4ffa-a5e9-5d9e73a71505',NULL,'http-basic-authenticator','master','cf57a4e0-dd34-470d-a1fd-4d01cf38f513',0,10,'\0',NULL,NULL),('77328699-a344-4565-8837-2f2ae064364d',NULL,NULL,'master','b8679085-08b5-49b2-a1d8-8a0904b99265',1,20,'','aa93b8e8-bb5e-4983-b4f1-92c361f6aeb2',NULL),('7bdf4f01-acb5-4901-aba5-577fd6c6201f',NULL,'idp-email-verification','master','0e64e68b-6d79-447f-9d33-2172b0c12d74',2,10,'\0',NULL,NULL),('8215bddb-b1d3-44b4-b7c0-03052dad3776',NULL,'auth-spnego','master','c8e1a14d-73a1-484b-99f0-af956ee18fee',3,30,'\0',NULL,NULL),('822b8092-dd74-4442-94ff-3b73106de77b',NULL,'client-jwt','Aulos','43dc8a85-8a7a-4a04-aa98-a45ea85ca7fc',2,20,'\0',NULL,NULL),('844ad65b-4823-4558-a419-62162097dd85',NULL,'identity-provider-redirector','master','ad63985e-0949-4fd7-9ea7-7e01343e821a',2,25,'\0',NULL,NULL),('8739287a-a388-49d2-98a0-03e166256db3',NULL,'registration-password-action','master','3f77d15d-2786-4f14-aba2-46597c9bbb73',0,50,'\0',NULL,NULL),('87a871a3-fb83-4012-b43f-b913b5c9601d',NULL,NULL,'master','0e64e68b-6d79-447f-9d33-2172b0c12d74',2,20,'','2f5cc34c-1908-4aee-8d13-def4ed4ca916',NULL),('87d00961-7f85-411a-8672-968b88af7006',NULL,'auth-username-password-form','Aulos','71e6888f-c4da-408f-882e-7770bdb14dad',0,10,'\0',NULL,NULL),('882f71f4-1984-45c3-af4b-dd9b5a321d2c',NULL,'registration-page-form','master','d82df27e-a873-426d-a12f-251a7e88e885',0,10,'','3f77d15d-2786-4f14-aba2-46597c9bbb73',NULL),('8a958e5f-7297-4caf-8884-db54323ed4da',NULL,'idp-confirm-link','Aulos','0d04ea72-6326-4925-a6ff-58a0ed6189de',0,10,'\0',NULL,NULL),('90b7e63e-ddec-4e44-93c5-b3e8501558db',NULL,'conditional-user-configured','Aulos','f4f64536-32b3-4d11-90ab-06686ba4bd24',0,10,'\0',NULL,NULL),('91929d3e-f7da-4c79-a393-e5ead7ea0910',NULL,NULL,'Aulos','1a909b4e-f059-4a1b-a8ce-8542fe14ce97',0,20,'','1ae930e4-c4af-4d4e-b885-bdbb6f77a6ff',NULL),('982e47a6-e46b-45da-a2c3-86bf849e2594',NULL,'registration-password-action','Aulos','ea02f0ad-0f68-4323-aa23-d14f9c65839b',0,50,'\0',NULL,NULL),('99074a1c-3c6a-4723-af79-a82c51ece668',NULL,NULL,'Aulos','45e96174-d304-4a3e-bab7-192a8bd05bad',1,20,'','7d8b5663-a49c-45d8-bcdb-142b7ba8fd2e',NULL),('9ed58317-446c-413b-abbb-5efcb0f1bfa3',NULL,NULL,'master','df487cbf-fde4-4b9f-99c0-e49cb96bcf02',1,30,'','81648fd1-35b6-44c0-82bc-47f68e21bb67',NULL),('a03c8585-92a5-4df1-a594-8af9c8823ac7',NULL,'registration-page-form','Aulos','13c56672-2592-4517-8d13-4baafcfff16a',0,10,'','ea02f0ad-0f68-4323-aa23-d14f9c65839b',NULL),('a3240d68-faf0-44ac-952e-9a3216bad417',NULL,'idp-email-verification','Aulos','2a74d531-3657-4f81-bf1e-935605a6b082',2,10,'\0',NULL,NULL),('aafed29b-9f91-46a4-8c0f-f7ba5c17fd3f',NULL,'registration-profile-action','Aulos','ea02f0ad-0f68-4323-aa23-d14f9c65839b',0,40,'\0',NULL,NULL),('ac434dd5-538a-4e97-9a39-4d15e5c79264',NULL,'auth-spnego','master','ad63985e-0949-4fd7-9ea7-7e01343e821a',3,20,'\0',NULL,NULL),('ae522d6e-037a-483a-8f06-221a9ddb0566',NULL,'reset-credential-email','Aulos','1416d4ab-56fa-4bfa-8be2-f684fc9430eb',0,20,'\0',NULL,NULL),('b6abad90-fedc-4b1a-80d2-605365f2a42c',NULL,'auth-otp-form','Aulos','7d8b5663-a49c-45d8-bcdb-142b7ba8fd2e',0,20,'\0',NULL,NULL),('b721aea7-ec4d-46c4-829b-8523b9dd5a45',NULL,'registration-user-creation','Aulos','ea02f0ad-0f68-4323-aa23-d14f9c65839b',0,20,'\0',NULL,NULL),('babeeff8-36f8-4283-859a-fcd618dab7db',NULL,'client-secret','master','a782060c-af25-43d0-b88f-96883acbd7ae',2,10,'\0',NULL,NULL),('bbc098fb-ab97-449c-905e-02313eca39ec',NULL,NULL,'Aulos','cf91d979-e006-4689-8a8a-c58dd35e9c8c',1,30,'','de7ab6a0-ed15-43dd-bddf-869a6788cf0b',NULL),('bc468da7-6ccd-46cb-a397-47102f3acb5c',NULL,'auth-spnego','Aulos','1ae930e4-c4af-4d4e-b885-bdbb6f77a6ff',3,30,'\0',NULL,NULL),('bdab4418-8234-4a00-adb2-866db34ae126',NULL,'docker-http-basic-authenticator','Aulos','131bf459-d343-4679-b42b-7ebe4279b6e3',0,10,'\0',NULL,NULL),('c133bf43-da70-4c28-b048-6f08f301d516',NULL,'conditional-user-configured','master','aa93b8e8-bb5e-4983-b4f1-92c361f6aeb2',0,10,'\0',NULL,NULL),('c661d6ca-9ace-495b-998f-6c316cf24275',NULL,'direct-grant-validate-otp','Aulos','de7ab6a0-ed15-43dd-bddf-869a6788cf0b',0,20,'\0',NULL,NULL),('c901a5d0-8068-4c8c-a12a-bcef01e06b0d',NULL,NULL,'Aulos','6028ac8f-1499-4a68-ae3a-93c797321e41',2,20,'','0d04ea72-6326-4925-a6ff-58a0ed6189de',NULL),('caee6e2c-49a7-4783-ac4a-7e43a8a4c6e0',NULL,'direct-grant-validate-username','master','df487cbf-fde4-4b9f-99c0-e49cb96bcf02',0,10,'\0',NULL,NULL),('d0bb4a16-fdb9-4d3a-8c8e-1499071b7513',NULL,'basic-auth-otp','Aulos','1ae930e4-c4af-4d4e-b885-bdbb6f77a6ff',3,20,'\0',NULL,NULL),('d0dd6c30-c33b-4741-b485-ebcbc955f0df',NULL,'http-basic-authenticator','Aulos','c4cad82f-b4bd-47b6-8b49-bf824b6d43d1',0,10,'\0',NULL,NULL),('d1fb71da-9752-494c-bc75-081d0d726d2f',NULL,'conditional-user-configured','Aulos','7d8b5663-a49c-45d8-bcdb-142b7ba8fd2e',0,10,'\0',NULL,NULL),('d36dca15-00c8-4188-b242-b6ab41086940',NULL,'identity-provider-redirector','Aulos','4e3345de-4d06-4f68-a4e5-c5cb3d9f0585',2,25,'\0',NULL,NULL),('d44aa044-14de-43f8-b7f7-5f9286ee8e83',NULL,NULL,'master','97fc9401-dbfa-404a-9d3d-57478c633670',0,20,'','f2dccb51-2af1-4d38-a126-ae434d360ab8',NULL),('d5fa573e-ac5d-49ae-a04b-b4510f1833dd',NULL,'client-secret-jwt','master','a782060c-af25-43d0-b88f-96883acbd7ae',2,30,'\0',NULL,NULL),('d92dd563-5ec2-4357-9a53-472d5be060e9',NULL,'auth-otp-form','master','aa93b8e8-bb5e-4983-b4f1-92c361f6aeb2',0,20,'\0',NULL,NULL),('daf9ec57-c59c-4755-9800-780b9eec7f03',NULL,'client-jwt','master','a782060c-af25-43d0-b88f-96883acbd7ae',2,20,'\0',NULL,NULL),('dba296c7-e8f7-4c8f-a611-f54af6069dd9',NULL,'direct-grant-validate-otp','master','81648fd1-35b6-44c0-82bc-47f68e21bb67',0,20,'\0',NULL,NULL),('dbe73d0b-fb3d-4316-92b7-a40d1d6cfb64',NULL,'registration-recaptcha-action','master','3f77d15d-2786-4f14-aba2-46597c9bbb73',3,60,'\0',NULL,NULL),('dc10e0c8-7643-4162-be03-2d4e18f06326',NULL,'idp-username-password-form','master','2f5cc34c-1908-4aee-8d13-def4ed4ca916',0,10,'\0',NULL,NULL),('dd456137-d70d-4d17-8bd8-963a4a4b8e81',NULL,'conditional-user-configured','Aulos','5fa5baf9-708a-43aa-b062-8f3c1416394c',0,10,'\0',NULL,NULL),('deaa07f7-c6e0-4652-8102-a92f24015ed0',NULL,'docker-http-basic-authenticator','master','11ed5b43-a0ff-48a3-a82a-6618a9890f62',0,10,'\0',NULL,NULL),('dfc8c682-67ae-43dc-9fd8-aebb313e858c',NULL,NULL,'master','f2dccb51-2af1-4d38-a126-ae434d360ab8',2,20,'','6375869b-46a9-4e85-8afc-4157f1bcdb2b',NULL),('dfdd345d-3e75-4657-87fe-efefb533d00d',NULL,'conditional-user-configured','master','81648fd1-35b6-44c0-82bc-47f68e21bb67',0,10,'\0',NULL,NULL),('e0f73596-7463-4049-a525-c849be47de4c',NULL,'client-x509','Aulos','43dc8a85-8a7a-4a04-aa98-a45ea85ca7fc',2,40,'\0',NULL,NULL),('ea7aff8c-24cf-4333-b77a-d93a9f12b0a6',NULL,'conditional-user-configured','master','8666df2f-418a-46a7-85ee-1c0c308d150c',0,10,'\0',NULL,NULL),('ec0dafe2-57bb-449a-9276-72b3e232ecee',NULL,'reset-password','Aulos','1416d4ab-56fa-4bfa-8be2-f684fc9430eb',0,30,'\0',NULL,NULL),('eccdb554-fd32-4195-b2fb-c17b59242bbb',NULL,NULL,'master','6375869b-46a9-4e85-8afc-4157f1bcdb2b',0,20,'','0e64e68b-6d79-447f-9d33-2172b0c12d74',NULL),('ef82a87c-098c-481f-8ae3-4878c584c90c',NULL,NULL,'master','89dbfd7a-e12f-4096-8f67-9305270f6154',1,40,'','8666df2f-418a-46a7-85ee-1c0c308d150c',NULL),('efc20b00-9840-4013-b40d-62ffc4c0e91d',NULL,NULL,'master','2f5cc34c-1908-4aee-8d13-def4ed4ca916',1,20,'','562af5a2-5301-4d9a-bc45-16d62ca10c5c',NULL),('f4fb0e6f-2cca-4495-9077-1ca16979bd62',NULL,'auth-spnego','Aulos','4e3345de-4d06-4f68-a4e5-c5cb3d9f0585',3,20,'\0',NULL,NULL),('fa416743-e96b-4b1a-aa61-5276d64fbf0e',NULL,'auth-otp-form','master','562af5a2-5301-4d9a-bc45-16d62ca10c5c',0,20,'\0',NULL,NULL),('fa7a17b9-58ae-45b4-9214-30f6e9a4ca05',NULL,'auth-cookie','Aulos','4e3345de-4d06-4f68-a4e5-c5cb3d9f0585',2,10,'\0',NULL,NULL),('fbf22841-ee74-4fef-80f3-2c693d291657',NULL,'basic-auth-otp','master','c8e1a14d-73a1-484b-99f0-af956ee18fee',3,20,'\0',NULL,NULL),('fc187280-da91-4615-85f4-980218666055',NULL,'reset-otp','Aulos','5fa5baf9-708a-43aa-b062-8f3c1416394c',0,20,'\0',NULL,NULL),('fc99fd2b-8cba-46c8-ae71-b250a44b339c',NULL,'client-secret','Aulos','43dc8a85-8a7a-4a04-aa98-a45ea85ca7fc',2,10,'\0',NULL,NULL);
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_FLOW`
--

DROP TABLE IF EXISTS `AUTHENTICATION_FLOW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATION_FLOW` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) NOT NULL DEFAULT 'basic-flow',
  `TOP_LEVEL` bit(1) NOT NULL DEFAULT b'0',
  `BUILT_IN` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_FLOW_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_FLOW_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_FLOW`
--

LOCK TABLES `AUTHENTICATION_FLOW` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_FLOW` VALUES ('03f677f7-4b56-4381-b1d5-504703f3ad89','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','Aulos','basic-flow','',''),('0d04ea72-6326-4925-a6ff-58a0ed6189de','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','Aulos','basic-flow','\0',''),('0e64e68b-6d79-447f-9d33-2172b0c12d74','Account verification options','Method with which to verity the existing account','master','basic-flow','\0',''),('11ed5b43-a0ff-48a3-a82a-6618a9890f62','docker auth','Used by Docker clients to authenticate against the IDP','master','basic-flow','',''),('131bf459-d343-4679-b42b-7ebe4279b6e3','docker auth','Used by Docker clients to authenticate against the IDP','Aulos','basic-flow','',''),('13c56672-2592-4517-8d13-4baafcfff16a','registration','registration flow','Aulos','basic-flow','',''),('1416d4ab-56fa-4bfa-8be2-f684fc9430eb','reset credentials','Reset credentials for a user if they forgot their password or something','Aulos','basic-flow','',''),('1a909b4e-f059-4a1b-a8ce-8542fe14ce97','http challenge','An authentication flow based on challenge-response HTTP Authentication Schemes','Aulos','basic-flow','',''),('1ae930e4-c4af-4d4e-b885-bdbb6f77a6ff','Authentication Options','Authentication options.','Aulos','basic-flow','\0',''),('2a74d531-3657-4f81-bf1e-935605a6b082','Account verification options','Method with which to verity the existing account','Aulos','basic-flow','\0',''),('2f5cc34c-1908-4aee-8d13-def4ed4ca916','Verify Existing Account by Re-authentication','Reauthentication of existing account','master','basic-flow','\0',''),('3f77d15d-2786-4f14-aba2-46597c9bbb73','registration form','registration form','master','form-flow','\0',''),('43dc8a85-8a7a-4a04-aa98-a45ea85ca7fc','clients','Base authentication for clients','Aulos','client-flow','',''),('45e96174-d304-4a3e-bab7-192a8bd05bad','Verify Existing Account by Re-authentication','Reauthentication of existing account','Aulos','basic-flow','\0',''),('4e3345de-4d06-4f68-a4e5-c5cb3d9f0585','browser','browser based authentication','Aulos','basic-flow','',''),('562af5a2-5301-4d9a-bc45-16d62ca10c5c','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','master','basic-flow','\0',''),('5fa5baf9-708a-43aa-b062-8f3c1416394c','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','Aulos','basic-flow','\0',''),('6028ac8f-1499-4a68-ae3a-93c797321e41','User creation or linking','Flow for the existing/non-existing user alternatives','Aulos','basic-flow','\0',''),('6375869b-46a9-4e85-8afc-4157f1bcdb2b','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','master','basic-flow','\0',''),('71e6888f-c4da-408f-882e-7770bdb14dad','forms','Username, password, otp and other auth forms.','Aulos','basic-flow','\0',''),('7d75e543-cdff-48f7-8768-8327282d298f','http challenge','An authentication flow based on challenge-response HTTP Authentication Schemes','master','basic-flow','',''),('7d8b5663-a49c-45d8-bcdb-142b7ba8fd2e','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','Aulos','basic-flow','\0',''),('81648fd1-35b6-44c0-82bc-47f68e21bb67','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','master','basic-flow','\0',''),('8666df2f-418a-46a7-85ee-1c0c308d150c','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','master','basic-flow','\0',''),('89dbfd7a-e12f-4096-8f67-9305270f6154','reset credentials','Reset credentials for a user if they forgot their password or something','master','basic-flow','',''),('97fc9401-dbfa-404a-9d3d-57478c633670','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','master','basic-flow','',''),('a782060c-af25-43d0-b88f-96883acbd7ae','clients','Base authentication for clients','master','client-flow','',''),('aa93b8e8-bb5e-4983-b4f1-92c361f6aeb2','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','master','basic-flow','\0',''),('ad63985e-0949-4fd7-9ea7-7e01343e821a','browser','browser based authentication','master','basic-flow','',''),('b8679085-08b5-49b2-a1d8-8a0904b99265','forms','Username, password, otp and other auth forms.','master','basic-flow','\0',''),('c4cad82f-b4bd-47b6-8b49-bf824b6d43d1','saml ecp','SAML ECP Profile Authentication Flow','Aulos','basic-flow','',''),('c8e1a14d-73a1-484b-99f0-af956ee18fee','Authentication Options','Authentication options.','master','basic-flow','\0',''),('cf57a4e0-dd34-470d-a1fd-4d01cf38f513','saml ecp','SAML ECP Profile Authentication Flow','master','basic-flow','',''),('cf91d979-e006-4689-8a8a-c58dd35e9c8c','direct grant','OpenID Connect Resource Owner Grant','Aulos','basic-flow','',''),('d82df27e-a873-426d-a12f-251a7e88e885','registration','registration flow','master','basic-flow','',''),('de7ab6a0-ed15-43dd-bddf-869a6788cf0b','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','Aulos','basic-flow','\0',''),('df487cbf-fde4-4b9f-99c0-e49cb96bcf02','direct grant','OpenID Connect Resource Owner Grant','master','basic-flow','',''),('ea02f0ad-0f68-4323-aa23-d14f9c65839b','registration form','registration form','Aulos','form-flow','\0',''),('f2dccb51-2af1-4d38-a126-ae434d360ab8','User creation or linking','Flow for the existing/non-existing user alternatives','master','basic-flow','\0',''),('f4f64536-32b3-4d11-90ab-06686ba4bd24','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','Aulos','basic-flow','\0','');
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATOR_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_CONFIG_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG`
--

LOCK TABLES `AUTHENTICATOR_CONFIG` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG` VALUES ('04d1da98-db60-4793-9272-34b1f11e53cb','review profile config','master'),('353c0541-cc97-4706-9be4-6316b6fbc8e9','review profile config','Aulos'),('7ff33131-21ea-4e9d-98f3-4d4e3412f44c','create unique user config','master'),('e6151e0d-6696-4cd1-b720-6704e5212e2d','create unique user config','Aulos');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG_ENTRY`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG_ENTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AUTHENTICATOR_CONFIG_ENTRY` (
  `AUTHENTICATOR_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`AUTHENTICATOR_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG_ENTRY`
--

LOCK TABLES `AUTHENTICATOR_CONFIG_ENTRY` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG_ENTRY` VALUES ('04d1da98-db60-4793-9272-34b1f11e53cb','missing','update.profile.on.first.login'),('353c0541-cc97-4706-9be4-6316b6fbc8e9','missing','update.profile.on.first.login'),('7ff33131-21ea-4e9d-98f3-4d4e3412f44c','false','require.password.update.after.registration'),('e6151e0d-6696-4cd1-b720-6704e5212e2d','false','require.password.update.after.registration');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BROKER_LINK`
--

DROP TABLE IF EXISTS `BROKER_LINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BROKER_LINK` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  `BROKER_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BROKER_LINK`
--

LOCK TABLES `BROKER_LINK` WRITE;
/*!40000 ALTER TABLE `BROKER_LINK` DISABLE KEYS */;
/*!40000 ALTER TABLE `BROKER_LINK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT`
--

DROP TABLE IF EXISTS `CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT` (
  `ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FULL_SCOPE_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) DEFAULT NULL,
  `PUBLIC_CLIENT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` varchar(255) DEFAULT NULL,
  `BASE_URL` varchar(255) DEFAULT NULL,
  `BEARER_ONLY` bit(1) NOT NULL DEFAULT b'0',
  `MANAGEMENT_URL` varchar(255) DEFAULT NULL,
  `SURROGATE_AUTH_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  `NODE_REREG_TIMEOUT` int(11) DEFAULT 0,
  `FRONTCHANNEL_LOGOUT` bit(1) NOT NULL DEFAULT b'0',
  `CONSENT_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `SERVICE_ACCOUNTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_AUTHENTICATOR_TYPE` varchar(255) DEFAULT NULL,
  `ROOT_URL` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REGISTRATION_TOKEN` varchar(255) DEFAULT NULL,
  `STANDARD_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'1',
  `IMPLICIT_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DIRECT_ACCESS_GRANTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ALWAYS_DISPLAY_IN_CONSOLE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_B71CJLBENV945RB6GCON438AT` (`REALM_ID`,`CLIENT_ID`),
  KEY `IDX_CLIENT_ID` (`CLIENT_ID`),
  CONSTRAINT `FK_P56CTINXXB9GSK57FO49F9TAC` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT`
--

LOCK TABLES `CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT` VALUES ('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','','\0','admin-cli',0,'','**********',NULL,'\0',NULL,'\0','Aulos','openid-connect',0,'\0','\0','${client_admin-cli}','\0','client-secret',NULL,NULL,NULL,'\0','\0','','\0'),('2162596c-1963-4d57-bd5c-ffaef0269e14','','\0','account',0,'\0','**********','/realms/Aulos/account/','\0',NULL,'\0','Aulos','openid-connect',0,'\0','\0','${client_account}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','\0','account',0,'\0','fe4e6b0d-881c-4106-b875-304def92dba9','/realms/master/account/','\0',NULL,'\0','master','openid-connect',0,'\0','\0','${client_account}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0'),('50f4c638-c959-40eb-a0be-254da5609b9a','','\0','account-console',0,'','**********','/realms/Aulos/account/','\0',NULL,'\0','Aulos','openid-connect',0,'\0','\0','${client_account-console}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0'),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','','Aulos-realm',0,'\0','dd338bb6-910a-4712-8903-337aaac42419',NULL,'',NULL,'\0','master',NULL,0,'\0','\0','Aulos Realm','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','','','master-realm',0,'\0','99880517-252b-47c8-9ac5-9b47972377fc',NULL,'',NULL,'\0','master',NULL,0,'\0','\0','master Realm','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','\0','realm-management',0,'\0','**********',NULL,'',NULL,'\0','Aulos','openid-connect',0,'\0','\0','${client_realm-management}','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('90474cdc-c159-4fb9-b58b-206dca980997','','\0','admin-cli',0,'','9f6f15ce-a1b4-49c6-91a8-c62ff48d625e',NULL,'\0',NULL,'\0','master','openid-connect',0,'\0','\0','${client_admin-cli}','\0','client-secret',NULL,NULL,NULL,'\0','\0','','\0'),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','','\0','security-admin-console',0,'','**********','/admin/Aulos/console/','\0',NULL,'\0','Aulos','openid-connect',0,'\0','\0','${client_security-admin-console}','\0','client-secret','${authAdminUrl}',NULL,NULL,'','\0','\0','\0'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','','\0','security-admin-console',0,'','5b4a035a-269e-40cd-881b-84cc19185fd2','/admin/master/console/','\0',NULL,'\0','master','openid-connect',0,'\0','\0','${client_security-admin-console}','\0','client-secret','${authAdminUrl}',NULL,NULL,'','\0','\0','\0'),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','','\0','broker',0,'\0','**********',NULL,'\0',NULL,'\0','Aulos','openid-connect',0,'\0','\0','${client_broker}','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','','','angular',0,'','**********',NULL,'\0','http://localhost:4200','\0','Aulos','openid-connect',-1,'\0','\0',NULL,'\0','client-secret','http://localhost:4200',NULL,NULL,'','\0','','\0'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','','','aulos',0,'','**********',NULL,'\0','http://localhost/','\0','Aulos','openid-connect',-1,'\0','\0','Aulos','\0','client-secret','http://localhost/',NULL,NULL,'','\0','\0','\0'),('f2fc58d6-5a17-48f6-805d-d75889994e1f','','\0','broker',0,'\0','41988358-dc08-45e9-8e3c-3d7eb478b5e3',NULL,'\0',NULL,'\0','master','openid-connect',0,'\0','\0','${client_broker}','\0','client-secret',NULL,NULL,NULL,'','\0','\0','\0'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','','\0','account-console',0,'','b288965a-0448-4a0c-aa82-29cf26473280','/realms/master/account/','\0',NULL,'\0','master','openid-connect',0,'\0','\0','${client_account-console}','\0','client-secret','${authBaseUrl}',NULL,NULL,'','\0','\0','\0');
/*!40000 ALTER TABLE `CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_ATTRIBUTES` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` text DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  CONSTRAINT `FK3C47C64BEACCA966` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_ATTRIBUTES`
--

LOCK TABLES `CLIENT_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_ATTRIBUTES` VALUES ('50f4c638-c959-40eb-a0be-254da5609b9a','S256','pkce.code.challenge.method'),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','S256','pkce.code.challenge.method'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','S256','pkce.code.challenge.method'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','backchannel.logout.revoke.offline.tokens'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','true','backchannel.logout.session.required'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','client_credentials.use_refresh_token'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','display.on.consent.screen'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','exclude.session.state.from.auth.response'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.assertion.signature'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.authnstatement'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.client.signature'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.encrypt'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.force.post.binding'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.multivalued.roles'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.onetimeuse.condition'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.server.signature'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml.server.signature.keyinfo.ext'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','saml_force_name_id_format'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','false','tls.client.certificate.bound.access.tokens'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','backchannel.logout.revoke.offline.tokens'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','true','backchannel.logout.session.required'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','client_credentials.use_refresh_token'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','display.on.consent.screen'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','exclude.session.state.from.auth.response'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.assertion.signature'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.authnstatement'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.client.signature'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.encrypt'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.force.post.binding'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.multivalued.roles'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.onetimeuse.condition'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.server.signature'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml.server.signature.keyinfo.ext'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','saml_force_name_id_format'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','false','tls.client.certificate.bound.access.tokens'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','S256','pkce.code.challenge.method');
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_AUTH_FLOW_BINDINGS`
--

DROP TABLE IF EXISTS `CLIENT_AUTH_FLOW_BINDINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_AUTH_FLOW_BINDINGS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `BINDING_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`BINDING_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_AUTH_FLOW_BINDINGS`
--

LOCK TABLES `CLIENT_AUTH_FLOW_BINDINGS` WRITE;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_DEFAULT_ROLES`
--

DROP TABLE IF EXISTS `CLIENT_DEFAULT_ROLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_DEFAULT_ROLES` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`ROLE_ID`),
  UNIQUE KEY `UK_8AELWNIBJI49AVXSRTUF6XJOW` (`ROLE_ID`),
  KEY `IDX_CLIENT_DEF_ROLES_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_NUILTS7KLWQW2H8M2B5JOYTKY` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_DEFAULT_ROLES`
--

LOCK TABLES `CLIENT_DEFAULT_ROLES` WRITE;
/*!40000 ALTER TABLE `CLIENT_DEFAULT_ROLES` DISABLE KEYS */;
INSERT INTO `CLIENT_DEFAULT_ROLES` VALUES ('2162596c-1963-4d57-bd5c-ffaef0269e14','27fb2112-9acf-44e1-8ef4-1894e8314750'),('2162596c-1963-4d57-bd5c-ffaef0269e14','5302e4c3-fd65-4ef4-9973-fb4ceae5ff00'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','334adf7d-7e99-4d8e-973c-e986820146cc'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','6db32d76-4143-4d4c-824e-ceac9dd96e0a');
/*!40000 ALTER TABLE `CLIENT_DEFAULT_ROLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_INITIAL_ACCESS`
--

DROP TABLE IF EXISTS `CLIENT_INITIAL_ACCESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_INITIAL_ACCESS` (
  `ID` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `EXPIRATION` int(11) DEFAULT NULL,
  `COUNT` int(11) DEFAULT NULL,
  `REMAINING_COUNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_INIT_ACC_REALM` (`REALM_ID`),
  CONSTRAINT `FK_CLIENT_INIT_ACC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_INITIAL_ACCESS`
--

LOCK TABLES `CLIENT_INITIAL_ACCESS` WRITE;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_NODE_REGISTRATIONS`
--

DROP TABLE IF EXISTS `CLIENT_NODE_REGISTRATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_NODE_REGISTRATIONS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` int(11) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  CONSTRAINT `FK4129723BA992F594` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_NODE_REGISTRATIONS`
--

LOCK TABLES `CLIENT_NODE_REGISTRATIONS` WRITE;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_CLI_SCOPE` (`REALM_ID`,`NAME`),
  KEY `IDX_REALM_CLSCOPE` (`REALM_ID`),
  CONSTRAINT `FK_REALM_CLI_SCOPE` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE`
--

LOCK TABLES `CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE` VALUES ('1588db9a-7850-4847-9b0a-8c22a31c6050','profile','Aulos','OpenID Connect built-in scope: profile','openid-connect'),('40c92e7c-bdd9-4f83-94ff-82ea052b3185','microprofile-jwt','master','Microprofile - JWT built-in scope','openid-connect'),('45f3af70-ca60-4c19-afc3-4481d00c15b3','email','Aulos','OpenID Connect built-in scope: email','openid-connect'),('4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','address','Aulos','OpenID Connect built-in scope: address','openid-connect'),('5d591862-db65-4dae-950c-d066e986b10e','web-origins','Aulos','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('7cd91cbe-e19e-45c3-87c1-a775ff5323c5','phone','master','OpenID Connect built-in scope: phone','openid-connect'),('9165e994-2250-4241-92d4-17d441d3bad5','profile','master','OpenID Connect built-in scope: profile','openid-connect'),('9231a691-225c-4c48-819b-46427dcc234f','email','master','OpenID Connect built-in scope: email','openid-connect'),('9b6b0cb1-7524-4adf-b984-fd838c0f6894','roles','Aulos','OpenID Connect scope for add user roles to the access token','openid-connect'),('a8ed3f14-4b56-4af5-91d5-266882a2e843','phone','Aulos','OpenID Connect built-in scope: phone','openid-connect'),('ade321a3-a4c0-45de-9890-e3016868b7c5','role_list','master','SAML role list','saml'),('d161f53e-80f9-4f20-ad02-eca6de8b2ac0','role_list','Aulos','SAML role list','saml'),('d4645f66-e63e-4dba-a5a0-ef9cde0edec1','microprofile-jwt','Aulos','Microprofile - JWT built-in scope','openid-connect'),('e08ff630-3d3e-4c7b-862f-c25d401dfdb2','offline_access','Aulos','OpenID Connect built-in scope: offline_access','openid-connect'),('e20613ca-b1dd-4202-bd24-01abd3bab492','offline_access','master','OpenID Connect built-in scope: offline_access','openid-connect'),('efda4309-9a26-4f8f-8151-e0ef533273d2','address','master','OpenID Connect built-in scope: address','openid-connect'),('f31bb44c-102c-4f24-9c71-db0ef56ff5bc','web-origins','master','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('fbca0742-60dc-45be-8183-9bc6cffc254f','roles','master','OpenID Connect scope for add user roles to the access token','openid-connect');
/*!40000 ALTER TABLE `CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE_ATTRIBUTES` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `VALUE` text DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`NAME`),
  KEY `IDX_CLSCOPE_ATTRS` (`SCOPE_ID`),
  CONSTRAINT `FK_CL_SCOPE_ATTR_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ATTRIBUTES`
--

LOCK TABLES `CLIENT_SCOPE_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ATTRIBUTES` VALUES ('1588db9a-7850-4847-9b0a-8c22a31c6050','${profileScopeConsentText}','consent.screen.text'),('1588db9a-7850-4847-9b0a-8c22a31c6050','true','display.on.consent.screen'),('1588db9a-7850-4847-9b0a-8c22a31c6050','true','include.in.token.scope'),('40c92e7c-bdd9-4f83-94ff-82ea052b3185','false','display.on.consent.screen'),('40c92e7c-bdd9-4f83-94ff-82ea052b3185','true','include.in.token.scope'),('45f3af70-ca60-4c19-afc3-4481d00c15b3','${emailScopeConsentText}','consent.screen.text'),('45f3af70-ca60-4c19-afc3-4481d00c15b3','true','display.on.consent.screen'),('45f3af70-ca60-4c19-afc3-4481d00c15b3','true','include.in.token.scope'),('4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','${addressScopeConsentText}','consent.screen.text'),('4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','true','display.on.consent.screen'),('4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','true','include.in.token.scope'),('5d591862-db65-4dae-950c-d066e986b10e','','consent.screen.text'),('5d591862-db65-4dae-950c-d066e986b10e','false','display.on.consent.screen'),('5d591862-db65-4dae-950c-d066e986b10e','false','include.in.token.scope'),('7cd91cbe-e19e-45c3-87c1-a775ff5323c5','${phoneScopeConsentText}','consent.screen.text'),('7cd91cbe-e19e-45c3-87c1-a775ff5323c5','true','display.on.consent.screen'),('7cd91cbe-e19e-45c3-87c1-a775ff5323c5','true','include.in.token.scope'),('9165e994-2250-4241-92d4-17d441d3bad5','${profileScopeConsentText}','consent.screen.text'),('9165e994-2250-4241-92d4-17d441d3bad5','true','display.on.consent.screen'),('9165e994-2250-4241-92d4-17d441d3bad5','true','include.in.token.scope'),('9231a691-225c-4c48-819b-46427dcc234f','${emailScopeConsentText}','consent.screen.text'),('9231a691-225c-4c48-819b-46427dcc234f','true','display.on.consent.screen'),('9231a691-225c-4c48-819b-46427dcc234f','true','include.in.token.scope'),('9b6b0cb1-7524-4adf-b984-fd838c0f6894','${rolesScopeConsentText}','consent.screen.text'),('9b6b0cb1-7524-4adf-b984-fd838c0f6894','true','display.on.consent.screen'),('9b6b0cb1-7524-4adf-b984-fd838c0f6894','false','include.in.token.scope'),('a8ed3f14-4b56-4af5-91d5-266882a2e843','${phoneScopeConsentText}','consent.screen.text'),('a8ed3f14-4b56-4af5-91d5-266882a2e843','true','display.on.consent.screen'),('a8ed3f14-4b56-4af5-91d5-266882a2e843','true','include.in.token.scope'),('ade321a3-a4c0-45de-9890-e3016868b7c5','${samlRoleListScopeConsentText}','consent.screen.text'),('ade321a3-a4c0-45de-9890-e3016868b7c5','true','display.on.consent.screen'),('d161f53e-80f9-4f20-ad02-eca6de8b2ac0','${samlRoleListScopeConsentText}','consent.screen.text'),('d161f53e-80f9-4f20-ad02-eca6de8b2ac0','true','display.on.consent.screen'),('d4645f66-e63e-4dba-a5a0-ef9cde0edec1','false','display.on.consent.screen'),('d4645f66-e63e-4dba-a5a0-ef9cde0edec1','true','include.in.token.scope'),('e08ff630-3d3e-4c7b-862f-c25d401dfdb2','${offlineAccessScopeConsentText}','consent.screen.text'),('e08ff630-3d3e-4c7b-862f-c25d401dfdb2','true','display.on.consent.screen'),('e20613ca-b1dd-4202-bd24-01abd3bab492','${offlineAccessScopeConsentText}','consent.screen.text'),('e20613ca-b1dd-4202-bd24-01abd3bab492','true','display.on.consent.screen'),('efda4309-9a26-4f8f-8151-e0ef533273d2','${addressScopeConsentText}','consent.screen.text'),('efda4309-9a26-4f8f-8151-e0ef533273d2','true','display.on.consent.screen'),('efda4309-9a26-4f8f-8151-e0ef533273d2','true','include.in.token.scope'),('f31bb44c-102c-4f24-9c71-db0ef56ff5bc','','consent.screen.text'),('f31bb44c-102c-4f24-9c71-db0ef56ff5bc','false','display.on.consent.screen'),('f31bb44c-102c-4f24-9c71-db0ef56ff5bc','false','include.in.token.scope'),('fbca0742-60dc-45be-8183-9bc6cffc254f','${rolesScopeConsentText}','consent.screen.text'),('fbca0742-60dc-45be-8183-9bc6cffc254f','true','display.on.consent.screen'),('fbca0742-60dc-45be-8183-9bc6cffc254f','false','include.in.token.scope');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_CLIENT`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE_CLIENT` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`CLIENT_ID`,`SCOPE_ID`),
  KEY `IDX_CLSCOPE_CL` (`CLIENT_ID`),
  KEY `IDX_CL_CLSCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_C_CLI_SCOPE_CLIENT` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`),
  CONSTRAINT `FK_C_CLI_SCOPE_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_CLIENT`
--

LOCK TABLES `CLIENT_SCOPE_CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_CLIENT` VALUES ('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','5d591862-db65-4dae-950c-d066e986b10e',''),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('00e2e90b-9be4-4c22-8644-ec0ce166a2a2','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('2162596c-1963-4d57-bd5c-ffaef0269e14','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('2162596c-1963-4d57-bd5c-ffaef0269e14','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('2162596c-1963-4d57-bd5c-ffaef0269e14','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('2162596c-1963-4d57-bd5c-ffaef0269e14','5d591862-db65-4dae-950c-d066e986b10e',''),('2162596c-1963-4d57-bd5c-ffaef0269e14','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('2162596c-1963-4d57-bd5c-ffaef0269e14','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('2162596c-1963-4d57-bd5c-ffaef0269e14','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('2162596c-1963-4d57-bd5c-ffaef0269e14','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('2162596c-1963-4d57-bd5c-ffaef0269e14','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','9165e994-2250-4241-92d4-17d441d3bad5',''),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','9231a691-225c-4c48-819b-46427dcc234f',''),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','fbca0742-60dc-45be-8183-9bc6cffc254f',''),('50f4c638-c959-40eb-a0be-254da5609b9a','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('50f4c638-c959-40eb-a0be-254da5609b9a','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('50f4c638-c959-40eb-a0be-254da5609b9a','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('50f4c638-c959-40eb-a0be-254da5609b9a','5d591862-db65-4dae-950c-d066e986b10e',''),('50f4c638-c959-40eb-a0be-254da5609b9a','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('50f4c638-c959-40eb-a0be-254da5609b9a','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('50f4c638-c959-40eb-a0be-254da5609b9a','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('50f4c638-c959-40eb-a0be-254da5609b9a','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('50f4c638-c959-40eb-a0be-254da5609b9a','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','9165e994-2250-4241-92d4-17d441d3bad5',''),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','9231a691-225c-4c48-819b-46427dcc234f',''),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('53a0df34-e058-4d8e-9f3f-ea948ba64bdc','fbca0742-60dc-45be-8183-9bc6cffc254f',''),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','9165e994-2250-4241-92d4-17d441d3bad5',''),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','9231a691-225c-4c48-819b-46427dcc234f',''),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('760ab7aa-727c-4faa-81d6-e250c7c6ace6','fbca0742-60dc-45be-8183-9bc6cffc254f',''),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','5d591862-db65-4dae-950c-d066e986b10e',''),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('90474cdc-c159-4fb9-b58b-206dca980997','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('90474cdc-c159-4fb9-b58b-206dca980997','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('90474cdc-c159-4fb9-b58b-206dca980997','9165e994-2250-4241-92d4-17d441d3bad5',''),('90474cdc-c159-4fb9-b58b-206dca980997','9231a691-225c-4c48-819b-46427dcc234f',''),('90474cdc-c159-4fb9-b58b-206dca980997','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('90474cdc-c159-4fb9-b58b-206dca980997','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('90474cdc-c159-4fb9-b58b-206dca980997','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('90474cdc-c159-4fb9-b58b-206dca980997','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('90474cdc-c159-4fb9-b58b-206dca980997','fbca0742-60dc-45be-8183-9bc6cffc254f',''),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','5d591862-db65-4dae-950c-d066e986b10e',''),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','9165e994-2250-4241-92d4-17d441d3bad5',''),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','9231a691-225c-4c48-819b-46427dcc234f',''),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','fbca0742-60dc-45be-8183-9bc6cffc254f',''),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','5d591862-db65-4dae-950c-d066e986b10e',''),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','5d591862-db65-4dae-950c-d066e986b10e',''),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','5d591862-db65-4dae-950c-d066e986b10e',''),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('f2fc58d6-5a17-48f6-805d-d75889994e1f','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('f2fc58d6-5a17-48f6-805d-d75889994e1f','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('f2fc58d6-5a17-48f6-805d-d75889994e1f','9165e994-2250-4241-92d4-17d441d3bad5',''),('f2fc58d6-5a17-48f6-805d-d75889994e1f','9231a691-225c-4c48-819b-46427dcc234f',''),('f2fc58d6-5a17-48f6-805d-d75889994e1f','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('f2fc58d6-5a17-48f6-805d-d75889994e1f','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('f2fc58d6-5a17-48f6-805d-d75889994e1f','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('f2fc58d6-5a17-48f6-805d-d75889994e1f','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('f2fc58d6-5a17-48f6-805d-d75889994e1f','fbca0742-60dc-45be-8183-9bc6cffc254f',''),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','9165e994-2250-4241-92d4-17d441d3bad5',''),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','9231a691-225c-4c48-819b-46427dcc234f',''),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','fbca0742-60dc-45be-8183-9bc6cffc254f','');
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SCOPE_ROLE_MAPPING` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`ROLE_ID`),
  KEY `IDX_CLSCOPE_ROLE` (`SCOPE_ID`),
  KEY `IDX_ROLE_CLSCOPE` (`ROLE_ID`),
  CONSTRAINT `FK_CL_SCOPE_RM_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ROLE_MAPPING`
--

LOCK TABLES `CLIENT_SCOPE_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ROLE_MAPPING` VALUES ('e08ff630-3d3e-4c7b-862f-c25d401dfdb2','8f20e717-6f37-4154-bac7-ad146cb77ad5'),('e20613ca-b1dd-4202-bd24-01abd3bab492','e939dcc6-31af-4d71-bcb7-aa609ddf123c');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION`
--

DROP TABLE IF EXISTS `CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `REDIRECT_URI` varchar(255) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(36) DEFAULT NULL,
  `CURRENT_ACTION` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_SESSION_SESSION` (`SESSION_ID`),
  CONSTRAINT `FK_B4AO2VCVAT6UKAU74WBWTFQO1` FOREIGN KEY (`SESSION_ID`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION`
--

LOCK TABLES `CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_AUTH_STATUS`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_AUTH_STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_AUTH_STATUS` (
  `AUTHENTICATOR` varchar(36) NOT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`AUTHENTICATOR`),
  CONSTRAINT `AUTH_STATUS_CONSTRAINT` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_AUTH_STATUS`
--

LOCK TABLES `CLIENT_SESSION_AUTH_STATUS` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51C2736` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_NOTE`
--

LOCK TABLES `CLIENT_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_PROT_MAPPER`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_PROT_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_PROT_MAPPER` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`PROTOCOL_MAPPER_ID`),
  CONSTRAINT `FK_33A8SGQW18I532811V7O2DK89` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_PROT_MAPPER`
--

LOCK TABLES `CLIENT_SESSION_PROT_MAPPER` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_ROLE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_SESSION_ROLE` (
  `ROLE_ID` varchar(255) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`ROLE_ID`),
  CONSTRAINT `FK_11B7SGQW18I532811V7O2DV76` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_ROLE`
--

LOCK TABLES `CLIENT_SESSION_ROLE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT_USER_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` text DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK_CL_USR_SES_NOTE` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_USER_SESSION_NOTE`
--

LOCK TABLES `CLIENT_USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT`
--

DROP TABLE IF EXISTS `COMPONENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPONENT` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_TYPE` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `SUB_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPONENT_REALM` (`REALM_ID`),
  KEY `IDX_COMPONENT_PROVIDER_TYPE` (`PROVIDER_TYPE`),
  CONSTRAINT `FK_COMPONENT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT`
--

LOCK TABLES `COMPONENT` WRITE;
/*!40000 ALTER TABLE `COMPONENT` DISABLE KEYS */;
INSERT INTO `COMPONENT` VALUES ('03991cfc-6f76-4c76-969d-8817306a6bb7','Allowed Protocol Mapper Types','master','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','authenticated'),('154cf873-9127-49bd-ae89-085751911380','Allowed Protocol Mapper Types','master','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','anonymous'),('23f3e90c-1275-4d91-9782-28d16b5f8f62','Max Clients Limit','Aulos','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','anonymous'),('2b057005-dcf9-403d-8e86-044372ab736a','Full Scope Disabled','master','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','anonymous'),('300ed563-010d-4ae6-a5fe-dd4c7239ee57','Allowed Client Scopes','Aulos','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','authenticated'),('351b8c7f-b69b-4dfd-9cf8-28ea0de37ff8','Max Clients Limit','master','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','anonymous'),('36328d64-9268-4ad9-be45-27820c65bf69','Full Scope Disabled','Aulos','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','anonymous'),('3a4fa77f-d8a8-449a-9ea1-687625da469e','aes-generated','Aulos','aes-generated','org.keycloak.keys.KeyProvider','Aulos',NULL),('53909914-5cf6-4f49-9b72-4417f8b517d7','Consent Required','Aulos','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','anonymous'),('74529c0b-cb4a-4c92-bcba-185ecc98654f','rsa-generated','Aulos','rsa-generated','org.keycloak.keys.KeyProvider','Aulos',NULL),('783826bc-fa4e-470d-afca-809b46203c5e','Trusted Hosts','Aulos','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','anonymous'),('8ef31058-5034-4f11-9e45-fff728fa7992','Consent Required','master','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','anonymous'),('94b12b08-6fb1-45d4-bfcb-3bebb9b35f7f','hmac-generated','Aulos','hmac-generated','org.keycloak.keys.KeyProvider','Aulos',NULL),('b6c72c5e-db90-4f2f-9484-51515f64a328','Allowed Protocol Mapper Types','Aulos','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','anonymous'),('bfabf1f3-ee13-4d7b-9323-4223c5089c26','Allowed Client Scopes','master','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','anonymous'),('cb831ae9-d5fd-42cb-9cfe-71db33f0a610','fallback-HS256','master','hmac-generated','org.keycloak.keys.KeyProvider','master',NULL),('d1d758b7-ef93-4667-be13-3fe637c624b0','Allowed Client Scopes','Aulos','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','anonymous'),('d685d6bd-36aa-4d77-bdd1-ab1f9293156a','Trusted Hosts','master','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','anonymous'),('d755a0a2-965d-476b-a6fa-20cc7184ded0','Allowed Protocol Mapper Types','Aulos','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','Aulos','authenticated'),('db0d5ae0-a90a-4168-a743-38f0c58009c6','Allowed Client Scopes','master','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','master','authenticated'),('f697b9ae-5449-4879-a9fc-0fcccfa5d9ef','fallback-RS256','master','rsa-generated','org.keycloak.keys.KeyProvider','master',NULL);
/*!40000 ALTER TABLE `COMPONENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT_CONFIG`
--

DROP TABLE IF EXISTS `COMPONENT_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPONENT_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `COMPONENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(4000) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPO_CONFIG_COMPO` (`COMPONENT_ID`),
  CONSTRAINT `FK_COMPONENT_CONFIG` FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT_CONFIG`
--

LOCK TABLES `COMPONENT_CONFIG` WRITE;
/*!40000 ALTER TABLE `COMPONENT_CONFIG` DISABLE KEYS */;
INSERT INTO `COMPONENT_CONFIG` VALUES ('015c7018-6742-4a6a-8dc0-1de26b59d0a9','74529c0b-cb4a-4c92-bcba-185ecc98654f','certificate','MIICmTCCAYECBgF4X1ZboDANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVBdWxvczAeFw0yMTAzMjMxMzQ0NThaFw0zMTAzMjMxMzQ2MzhaMBAxDjAMBgNVBAMMBUF1bG9zMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqtOB+EB1r+zBtRpckWD1uqepo3SCQPqrMP0thJicLhI7OcTbEw0jMM5UD3yJYIOrRX2CZSBE9zSEiUJ903dHP6iARqpzUHaRfFH6Hz5t6b+aWfBQSlUJ5Xm1K4m5ia5VKkAvOivaE+n1QLc8yGqhRd4iPYJwAxX+KIpJviKrgsD6qF9X+7397Apv3/e0bB78wpIfjvCKI4vGM4DVzlMBKzeTjX9E175j30ZBktInjw4YvCuRDF3l+WxKyS+TtSeVFXFbNI0kgE/YPZ08MIsDMHR4aXE7Xr1GCljzaaqP4Zr4MMxtE0HHgn5rjZlq+vKmDLAhNCENBg6tez5T2eP2FwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQA1+d7SmMDfu1WyrFv7NfDY8o//qi2eQidtiZ/gCrPVrlHeV17O/9159dpduSpMDNWLpNFJZIfnznsCr9L/0RcbgBGwo7Xjxh5dLH74ELWlCOrFGdlSGgEkkrcIK2TbiYzJ3mOltCmTBFsa6H15h7YTLdwc5R3/iXTQkOBFP8P6MP+SnONZ48L/Sa11cc5WaDsD9yer2d2JjFMm0Qr+lpaSrsVxRn5RSaT+dFlE/dLjprY775G99WBQ+QppmolZmjNbLsgrRk+OEsNyrVumGNvGg1I/7ERqPjr3jQLy64YJqSPFYvP2XI8NxXYzPGnWDGzFreOINf600HVgs+YCWz2B'),('035fbe37-d1bc-4966-9651-2cadfad2d662','cb831ae9-d5fd-42cb-9cfe-71db33f0a610','secret','TjyhcyygKEEr11qduz6Jku56JZ8Ma1G_NGbzrBUWBW-H1-QMnJ-dGYl9YW2Ydcuf_XGsJaFvzV4GwCycG542Gg'),('04bffadc-82b2-45cc-9b72-66e8042f96df','94b12b08-6fb1-45d4-bfcb-3bebb9b35f7f','secret','BPmIU9itmadLwzEBVXEvglNsqVoEzjJi-7QWvck6zxXUi2majpD_d4UJ05XV70bvHM96-N5q_yZASK5pNHU-Ag'),('05de4571-710b-4bfe-a209-d02422c93c55','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','saml-user-property-mapper'),('09d00770-8047-4b66-bfe9-8619983b9303','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('0b632aee-5f74-4861-8864-728b5b54a691','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('0bb99e1e-a81b-42a6-b929-c9341782a353','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('103f2066-3b80-446c-96cf-e191a44eda49','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','saml-role-list-mapper'),('143c67d6-3b35-4401-90b2-d9092392d2da','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('149866b1-f3a5-469a-9e60-66d1f5594a19','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('17e539ec-1cc3-4bd5-8f9a-2f7cf5997c83','74529c0b-cb4a-4c92-bcba-185ecc98654f','priority','100'),('226f006b-640c-4565-a78d-9870a10214b4','783826bc-fa4e-470d-afca-809b46203c5e','client-uris-must-match','true'),('23af86ca-d223-4184-864b-1c4bdb66f309','94b12b08-6fb1-45d4-bfcb-3bebb9b35f7f','kid','7d8bfea6-13de-427b-818a-ed19ac7e303d'),('248e34b0-00cf-4bff-b501-53e829352a0e','bfabf1f3-ee13-4d7b-9323-4223c5089c26','allow-default-scopes','true'),('347e9eb2-26c1-4470-8ee2-bd94383029e4','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('35a12d83-eef2-4a78-a4cf-68323e6839d2','3a4fa77f-d8a8-449a-9ea1-687625da469e','priority','100'),('387dec18-74de-4b83-a023-4ad529d205d6','cb831ae9-d5fd-42cb-9cfe-71db33f0a610','priority','-100'),('38d586de-e610-423f-9ade-a2116dc97a66','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','saml-role-list-mapper'),('42ad5f23-685d-4f8a-bb77-21139b164ef6','f697b9ae-5449-4879-a9fc-0fcccfa5d9ef','privateKey','MIIEpAIBAAKCAQEAgTH3LjgJtVQYzgvy1C4klVOj/64vr0hnjS7tj82ZTokSPGDZi9wIj11rg1H97Ns//TAg9i9j6ZaR+qnaQoSLH2hwolkedFx65HZDe/PMHGn/RcD4pQPbPQcO6iPgXBxNkSRIPJTlH3P+VVTMCM1fmcXKGmEYwvj5yvkbW0/UKLrGo1wIX3D4WDjAOw9b0WlToRxKKeKvwOWho5cc6gCjVoV+xQlLc3YQRjcKE5/tvOCiVDGCYcsFgpRFX1NFyRtqUWdJ65zyQp0hlexfSP3xFGoiiFsog35C1oUkhMW4veqM5bq3yiweMmQDVVxahm9Lgak7mQNfXnG0gb6M/z3zbwIDAQABAoIBACt8UPG6pPHmw46fEPYALgohJANMcvpxyYEI+ac8kcyQcJXoF3Fu92aiEC0cbPbLeYdUKtQScXPPXYVcpH1dNaK1uau7iXerJSY+9EoFbn9l4iltYYPRf3rUJF4FA2CdmjIvXy0dBN4IYeQA7chMsFAG9hbY9ceynAmIvX+HqCao8nEKVTBXVZN+vjOm7SN5JY3YCDzupPOrlD+OlcWs+KvefwF4jQrewMy1kgiVI2mOAAXTbe/M/ETEsYsZpN2MjtcxjCS81nC+PIHCjCDDFBA93fvMK4q5OxhxQg84KE6BP6kWDumhqwgAlLIf/7M+SXQ3shUceutlEvl65kuTLvkCgYEA3ytxn95pKcFAPTnRjzTMEVofR8NMLECEYXZ4ZaFpNO1Q2TuBBQLaFm971eKRs5CLKrjEpu7cQlL/SbmO/XxFhEk/8vOaAiL++8yMcGid45TphTbpU9mBInwnSpD2rC2jtKddEzBlQ12iCW4yDA+kTPe5TsmZQ8cPmeachwWVZnMCgYEAlDNyhf8paq6kSM/ES3nCrIMD8sfOcNA6uORzLNGDXJ854c262EcuUmSc1gBwcURONQ2Xowt5DLgzBQD1YnTDpo3XbwjltsN/xhcAZmsgBFxrqhlylMRM7RW3roUgiPPU5wxK3Z7vMtNqf9etAbo1O2/wkkqk3WCJc/i1GWKiRBUCgYEA0mSprVdH+5Z2EoKk3waecKlvHf+vm3SDmULQRLgEcGJfOz1O6EOFCWu26rC8PfZCTVd+BgbgXiLTDFVEyhNTkmBgSpKAGg2WKBryN7NZTsn/0ZgwJt3CUZmMjU7XTwGD+XdjVwjkHrtyXMOnqRlCA1H0QKPsuyo6uhPgc6a+76MCgYEAgDAr/ClkOqnK4kwMPziXob5FeQdI0p3aXTkFQpwKot/7IgxgdFjFgXETk6uXlvF9MDiMk/QFhXICd26H0dyrqvH/iURJ5hcd+0rEBtLcQ8lpOx191Z4h5+SkF6mBJdS6sAsa6q1huzXRZbk5JUhaaQn/LZqxFec9nXlftBBzyK0CgYBbGK+RQmRw2iOq5rVPQn091LDgqCoK9OpcGe/INvy6BlshibXPOffxFZgFJ8CBUFYOH08V1mYQcu6SwCj9NkNHsdGJtxf99sMcoP0Mg74D+Ei/TVtyoP/FUxnKTSVoih/UyqxMc63uedcQv6ihS6KMaiD2HbmupJnXtlbM8Mp1EQ=='),('4553d15e-948b-4f65-851f-150d4c57fea8','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('47a5d1a0-0ce6-441e-9103-0fdb3f10a3c7','783826bc-fa4e-470d-afca-809b46203c5e','host-sending-registration-request-must-match','true'),('4dd1c316-8c3a-4a68-b59b-7dbe7d8e1e8f','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('5086e54f-2ad8-4d82-a9e1-9aea6e801f50','d685d6bd-36aa-4d77-bdd1-ab1f9293156a','client-uris-must-match','true'),('51ac568e-bc17-487d-9e08-0aca1cf2eba7','3a4fa77f-d8a8-449a-9ea1-687625da469e','secret','WrINvxqxUFc8VRxcHVvMUw'),('520ebb8a-c3f8-44d5-80c5-49ef1b6c9678','d1d758b7-ef93-4667-be13-3fe637c624b0','allow-default-scopes','true'),('52f7c039-1b16-4ed1-98c6-e151096f5846','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('57b01c05-861e-4aaf-9a0b-a472a7078e3d','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','saml-user-property-mapper'),('5d2eb341-982f-4fd1-b5cc-778d64e92a2c','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('6b5b190a-771c-460e-bd4e-246368be8022','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','oidc-full-name-mapper'),('7104ca07-e3a9-40ed-80df-2789dc70852c','f697b9ae-5449-4879-a9fc-0fcccfa5d9ef','priority','-100'),('719d8866-6eda-4fdc-9dc3-104126e07109','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','saml-role-list-mapper'),('71aac75d-adbe-4cf2-8fa5-0477fb26f674','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','oidc-address-mapper'),('762c339a-fac7-42bc-ba40-b7cab6490cf0','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','oidc-address-mapper'),('76f9c87d-1230-4f31-8f29-9b20403a7978','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('7cc642f0-b757-4849-a3d6-cac969d3dc1f','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','saml-role-list-mapper'),('82196a31-6911-4f20-bd6e-9da21706ae71','300ed563-010d-4ae6-a5fe-dd4c7239ee57','allow-default-scopes','true'),('87bc0ab1-f4c4-4dad-9408-f5ad49242b1a','351b8c7f-b69b-4dfd-9cf8-28ea0de37ff8','max-clients','200'),('8aba3b88-ee7a-4386-9f97-2ac76df09661','74529c0b-cb4a-4c92-bcba-185ecc98654f','privateKey','MIIEpAIBAAKCAQEAqtOB+EB1r+zBtRpckWD1uqepo3SCQPqrMP0thJicLhI7OcTbEw0jMM5UD3yJYIOrRX2CZSBE9zSEiUJ903dHP6iARqpzUHaRfFH6Hz5t6b+aWfBQSlUJ5Xm1K4m5ia5VKkAvOivaE+n1QLc8yGqhRd4iPYJwAxX+KIpJviKrgsD6qF9X+7397Apv3/e0bB78wpIfjvCKI4vGM4DVzlMBKzeTjX9E175j30ZBktInjw4YvCuRDF3l+WxKyS+TtSeVFXFbNI0kgE/YPZ08MIsDMHR4aXE7Xr1GCljzaaqP4Zr4MMxtE0HHgn5rjZlq+vKmDLAhNCENBg6tez5T2eP2FwIDAQABAoIBADf91abyMeD1AFUFC/xWxJRmqjK6WItF3mDTS10fzGlJboIz5P6smrE/n8vnrPumjLfdOKU+23wPibWXxrhOa1sRNuJyshNYmb0e/ZXKF6q7M7NxElAa6YB+0QQxQ1A+hQmxOgmeH//Q+qM4rEKguLW25pA0tdQ9HC5bjWo14POdFP089TXGVrrWPa/2OGzxsGHBkkcrX/n7Ad5VOE4TMtJ9/Otdrs5q/EGESBK2wRWfcNvPmBEgGHQ7QwBxEjI3NDpFUzY8DpPG1If6Mk8E17n2ppYHogbc+r+T7OI4n0uWC9HyhQN176jXVfpeyOW7r2+43FaGTidH37D9mO0rboECgYEA7ukwDvYHK15Z3XPxYi58tBOneU2gtSj1e970R7hm/Q/vxBybo6wAP+hckWd8gwFPQWM1ubSIGminEXa4RFIBG1PVBFORy6iCF3L8X7reKZwkdkiTAL9sV9pqWxlAn8+Y3FJfkQwyni62Svr0potVjP1Do7KElASwKNgdGWJ2e9cCgYEAtwuWpwHJaGPlN568Gzc1gkmF4vExz1yJiljZp1jkcA8dcEyd9TAnmjdI6fggh2MWIZcwKru2vj/v9RL3/N33pXzmUUhpIiTDG2ofpewuXEr6x5fo0q8PIGamMMwBF+JesO7hF2adScgDZSld/3snn/9R14zmvxXRv7O3LOtJD8ECgYEAqx7Q8lZcKj8JROoPwdAkN+M/+E2Wx0tQEWpPM7Or6KRqiuAmxmOjRiMLcoZaE4dzmhUSXTImriu5RnPvZdgKvOUd1Vx6OBI5I8yTYYn6KHmTUDmJOWbilkZ2GUwMEqtiBKTnmH/RHaW9ohT/+O4h17troCt0dISrHIY2yYDR9r8CgYBd5ejzZRw/m7cTEC+oumqNmk+/OkF2AR9hQ/DrQtN0lJxiZjtFct1t49xYgXuWWAMbWiZQVZkKAVyD2KY0Jl2KnAa+PaoI5NjdcFQp1n11xNTenJPHuBvHYEDymUQaT3qJwxDe4znehmcPdugMTc3m6p++Nj6MWZIOiA94UH5bQQKBgQCfmLFyIvZgEjzXBf57Pry/d/b9Yvczc0R9wGNbmoRyJ3LIynK7UhDPutR8n9IwWoNogkMQu47oCekP8g5gAncmMU5qY5yliY8IpJ19baPl1nx7yV5PkoKvmhoml3g6z+oUvJV1FCtlpIEab4/E2AuYJPqpg0ndq4Gp1FDCq1w69g=='),('93f090c4-4be1-4a78-bb40-32988f127a19','cb831ae9-d5fd-42cb-9cfe-71db33f0a610','kid','a10aca4b-2f04-4909-8f70-93fb188cd49d'),('943837cf-bc56-4162-9a9b-b2bce8c9f7cc','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('97a3f262-9123-4b66-9fdf-0d73380e8f05','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('99802936-3bfe-4884-8e20-84250c786838','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','oidc-full-name-mapper'),('a5aba676-9ffa-4c98-878a-420308ab7f54','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','oidc-address-mapper'),('a7ba7780-862c-41ae-9df2-bfb1c911aeab','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','oidc-address-mapper'),('ab153cc8-f648-427c-9fcf-ceb6a8d8802f','d685d6bd-36aa-4d77-bdd1-ab1f9293156a','host-sending-registration-request-must-match','true'),('b1ee3b60-dfe3-49d2-bad3-3299d593ad6b','f697b9ae-5449-4879-a9fc-0fcccfa5d9ef','algorithm','RS256'),('b56ab32d-70dc-4201-8963-08e212770874','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','oidc-full-name-mapper'),('b7418572-e8df-4acf-a988-c7ba151c6cc1','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('bd190754-66a6-4fc2-8f49-134ec3f4d6b5','db0d5ae0-a90a-4168-a743-38f0c58009c6','allow-default-scopes','true'),('bee1a6c4-d458-405b-a41d-bdcece877b62','94b12b08-6fb1-45d4-bfcb-3bebb9b35f7f','algorithm','HS256'),('c4b59e87-4745-47a5-b76f-3a6647825b49','94b12b08-6fb1-45d4-bfcb-3bebb9b35f7f','priority','100'),('c707ce0c-80de-4873-b09d-d91c7d86217c','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('cd090938-75e6-487d-bc8a-5dcd670de5c7','b6c72c5e-db90-4f2f-9484-51515f64a328','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('d42ebb91-58d8-4b99-a9e4-cfaadc45bbf4','154cf873-9127-49bd-ae89-085751911380','allowed-protocol-mapper-types','oidc-full-name-mapper'),('de52e258-b89c-4b78-be0e-d91d21463596','03991cfc-6f76-4c76-969d-8817306a6bb7','allowed-protocol-mapper-types','saml-user-property-mapper'),('de745c2c-4ff4-4c28-8bd5-4296ae48358b','d755a0a2-965d-476b-a6fa-20cc7184ded0','allowed-protocol-mapper-types','saml-user-property-mapper'),('e9d56590-783f-4a11-a576-8b8896aa935a','f697b9ae-5449-4879-a9fc-0fcccfa5d9ef','certificate','MIICmzCCAYMCBgF4OqFU9DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwMzE2MTA0MDU0WhcNMzEwMzE2MTA0MjM0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCBMfcuOAm1VBjOC/LULiSVU6P/ri+vSGeNLu2PzZlOiRI8YNmL3AiPXWuDUf3s2z/9MCD2L2PplpH6qdpChIsfaHCiWR50XHrkdkN788wcaf9FwPilA9s9Bw7qI+BcHE2RJEg8lOUfc/5VVMwIzV+ZxcoaYRjC+PnK+RtbT9QousajXAhfcPhYOMA7D1vRaVOhHEop4q/A5aGjlxzqAKNWhX7FCUtzdhBGNwoTn+284KJUMYJhywWClEVfU0XJG2pRZ0nrnPJCnSGV7F9I/fEUaiKIWyiDfkLWhSSExbi96ozlurfKLB4yZANVXFqGb0uBqTuZA19ecbSBvoz/PfNvAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHngEztEaDFWsj9PoJfh5/2KfKEvitCDvds8mUpTGaxyRjeM4EBljt1twDic9KyAtSgx1rEEoCpMSMpESJI6mBaLe26OQuFFTHYiueoxTEtToWZqg7hLsedJKoryLPzd79GFMnympVFXITglLRcFrOO0o35YTPeXI4PPZcvvXEpM3zq8L6smVILJL828tDuRAI2CmG24DYALNTjsawEHHoZWWRlujx1OJB1qeay7Ji/20NYHP+qzXOtwRMtb8R7+wTB0tL0yDIjbShKIZwhT5ghK3HxJsTtUBMy6d2YZ3JBEm4/o7CHdoiKEuL5gwOjGAJqGEpiM73UgAx2oT7suUPs='),('e9e27be3-4304-4ae0-9c86-1c82ea631234','3a4fa77f-d8a8-449a-9ea1-687625da469e','kid','ba5b5cde-329c-4214-a425-2d370b3b1a0f'),('f0461b5f-6d37-4ce9-8380-1ac8415e6d63','23f3e90c-1275-4d91-9782-28d16b5f8f62','max-clients','200'),('f1cd69a4-5952-4fcb-88ab-1b7abcc2a4a8','cb831ae9-d5fd-42cb-9cfe-71db33f0a610','algorithm','HS256');
/*!40000 ALTER TABLE `COMPONENT_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPOSITE_ROLE`
--

DROP TABLE IF EXISTS `COMPOSITE_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPOSITE_ROLE` (
  `COMPOSITE` varchar(36) NOT NULL,
  `CHILD_ROLE` varchar(36) NOT NULL,
  PRIMARY KEY (`COMPOSITE`,`CHILD_ROLE`),
  KEY `IDX_COMPOSITE` (`COMPOSITE`),
  KEY `IDX_COMPOSITE_CHILD` (`CHILD_ROLE`),
  CONSTRAINT `FK_A63WVEKFTU8JO1PNJ81E7MCE2` FOREIGN KEY (`COMPOSITE`) REFERENCES `KEYCLOAK_ROLE` (`ID`),
  CONSTRAINT `FK_GR7THLLB9LU8Q4VQA4524JJY8` FOREIGN KEY (`CHILD_ROLE`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPOSITE_ROLE`
--

LOCK TABLES `COMPOSITE_ROLE` WRITE;
/*!40000 ALTER TABLE `COMPOSITE_ROLE` DISABLE KEYS */;
INSERT INTO `COMPOSITE_ROLE` VALUES ('10a18df0-0e9c-4e3f-8859-4305a1ad021d','416c701e-dd36-43a4-8d6a-2b8c4b3e5084'),('10a18df0-0e9c-4e3f-8859-4305a1ad021d','eb33cb0d-9646-43d5-b428-c14325a27dee'),('10a18df0-0e9c-4e3f-8859-4305a1ad021d','edd515cd-4c7c-40bc-bb24-e05f38e45714'),('1fbf28fd-85dc-4a12-b943-809c82c26aab','04684676-7ac6-4728-9e8c-a7fd1d46d840'),('416c701e-dd36-43a4-8d6a-2b8c4b3e5084','912ded8f-8cab-4585-8928-f5817f918d2d'),('416c701e-dd36-43a4-8d6a-2b8c4b3e5084','edd515cd-4c7c-40bc-bb24-e05f38e45714'),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','af67fea2-5f8f-4ea7-a134-46a03bf63e7a'),('6db32d76-4143-4d4c-824e-ceac9dd96e0a','67823e04-a547-4445-9788-cc89faba71fd'),('8159103f-7527-432e-9475-faa72d1f2a0b','a879a39e-cd9b-4389-b3fb-c88947afa1e7'),('832e079e-c5d6-4a04-9931-3a48ef94f292','0046dbd1-0832-4ba8-a4d8-d398e2ef4cb9'),('832e079e-c5d6-4a04-9931-3a48ef94f292','03351bf8-e596-4b5c-a4ca-c7919762dff3'),('832e079e-c5d6-4a04-9931-3a48ef94f292','052477c6-85a3-4de8-9f95-8a3728bcbf84'),('832e079e-c5d6-4a04-9931-3a48ef94f292','0a4d7ad2-db75-4995-9b97-a2d55fedc0ed'),('832e079e-c5d6-4a04-9931-3a48ef94f292','10875daf-c9f6-4217-a209-e48217eadb63'),('832e079e-c5d6-4a04-9931-3a48ef94f292','1101af9e-9149-4f81-ae19-ccb2e5e72da5'),('832e079e-c5d6-4a04-9931-3a48ef94f292','26d70553-aa78-4653-b13a-05b0c7b1c928'),('832e079e-c5d6-4a04-9931-3a48ef94f292','27b2857f-fb9d-43b4-b69d-ee4c0b343e82'),('832e079e-c5d6-4a04-9931-3a48ef94f292','31d091ab-89a0-478e-9b3c-a06599f43001'),('832e079e-c5d6-4a04-9931-3a48ef94f292','3db296c8-12d4-4c47-989e-4c3d8463d4ce'),('832e079e-c5d6-4a04-9931-3a48ef94f292','4f5bb111-893e-4440-ac70-4925b08ba020'),('832e079e-c5d6-4a04-9931-3a48ef94f292','58b7ae0b-9542-4556-9e07-47a6ad3d791e'),('832e079e-c5d6-4a04-9931-3a48ef94f292','5b66adde-8a7c-421e-999c-11219e2890c1'),('832e079e-c5d6-4a04-9931-3a48ef94f292','6314fd91-4ff7-40ff-9ee2-5d3450408dd9'),('832e079e-c5d6-4a04-9931-3a48ef94f292','68015baa-7977-4635-b22e-4520597b26f4'),('832e079e-c5d6-4a04-9931-3a48ef94f292','6bcf5bfe-d61a-42bb-8468-20e8750ce888'),('832e079e-c5d6-4a04-9931-3a48ef94f292','7b8d8ed1-be6f-4ea0-91d0-3b27acd35612'),('832e079e-c5d6-4a04-9931-3a48ef94f292','7ec837d8-1a60-4f3b-8879-ed58605d0ca1'),('832e079e-c5d6-4a04-9931-3a48ef94f292','7fe21b9f-b3f2-4044-8a97-b37ee5523e09'),('832e079e-c5d6-4a04-9931-3a48ef94f292','8159103f-7527-432e-9475-faa72d1f2a0b'),('832e079e-c5d6-4a04-9931-3a48ef94f292','83122dc6-9eb0-4f6e-8700-99f68df85d06'),('832e079e-c5d6-4a04-9931-3a48ef94f292','84a8b835-8735-468d-bb10-7f3c9ce31c02'),('832e079e-c5d6-4a04-9931-3a48ef94f292','8a26cd82-4159-44c8-9ee7-620e9d7b64cc'),('832e079e-c5d6-4a04-9931-3a48ef94f292','8c461bf3-8afa-4307-84d7-4478eeb4c4c3'),('832e079e-c5d6-4a04-9931-3a48ef94f292','96afd5de-32ad-46db-b4ce-9d5bd7d71702'),('832e079e-c5d6-4a04-9931-3a48ef94f292','a3b9d471-ca68-4a27-b52d-bba700ce2ceb'),('832e079e-c5d6-4a04-9931-3a48ef94f292','a656289f-7a2c-4a9e-998d-f9919bb29640'),('832e079e-c5d6-4a04-9931-3a48ef94f292','a7308212-6117-4e97-abeb-c2c38c18f601'),('832e079e-c5d6-4a04-9931-3a48ef94f292','a879a39e-cd9b-4389-b3fb-c88947afa1e7'),('832e079e-c5d6-4a04-9931-3a48ef94f292','bea557f7-55bf-4af8-9dc4-7f4449f8a45e'),('832e079e-c5d6-4a04-9931-3a48ef94f292','c9f261e5-ab81-4bca-abd0-e224dbca71ca'),('832e079e-c5d6-4a04-9931-3a48ef94f292','dd878016-04c2-4914-93fd-02c313f0ba58'),('832e079e-c5d6-4a04-9931-3a48ef94f292','e0c67745-2377-4d0d-8bb2-88c679a54cb5'),('832e079e-c5d6-4a04-9931-3a48ef94f292','e4afe5b1-d3d0-47aa-8731-2978148e975e'),('832e079e-c5d6-4a04-9931-3a48ef94f292','e974c422-5de5-496b-ac65-64e8996f8439'),('832e079e-c5d6-4a04-9931-3a48ef94f292','ed246df5-c274-4a7e-9ebf-1e0a713cf89a'),('832e079e-c5d6-4a04-9931-3a48ef94f292','edb27837-fd79-4c28-852c-9240e82e3614'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','03d01875-13d7-4e53-82a0-49e1a43ca233'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','076d8e1a-e012-4663-bffa-ea87d7122744'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','09d11584-feb1-446c-9ef2-dd9501996d62'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','21564716-12c6-44cd-9a50-0eb3eda42b21'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','3102d752-c7f7-4573-81fa-45ad2afde60a'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','416c701e-dd36-43a4-8d6a-2b8c4b3e5084'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','62900bb3-be03-4263-9539-dc3e86dff2d0'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','6d2aab64-9685-48e4-94b4-b19dd09f14c5'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','74e739d7-816a-4e57-a288-5c6f4ea2ddc5'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','912ded8f-8cab-4585-8928-f5817f918d2d'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','bfa81ecf-18ce-4764-aff9-555f8d94d395'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','c57adbc6-e4ac-4554-8a5e-815faa4cd6b0'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','d4dc3fa3-ec47-4dc4-849d-c3c25e81d0d5'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','d6933e68-95aa-4183-9323-4a416b702da5'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','e5c08b69-94ac-431c-a205-7c65398babc9'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','eb33cb0d-9646-43d5-b428-c14325a27dee'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','edd515cd-4c7c-40bc-bb24-e05f38e45714'),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','fdef4f98-0507-4a64-a545-17a1e7637fb3'),('bea557f7-55bf-4af8-9dc4-7f4449f8a45e','1101af9e-9149-4f81-ae19-ccb2e5e72da5'),('bfa81ecf-18ce-4764-aff9-555f8d94d395','d4dc3fa3-ec47-4dc4-849d-c3c25e81d0d5'),('dd878016-04c2-4914-93fd-02c313f0ba58','5b66adde-8a7c-421e-999c-11219e2890c1'),('dd878016-04c2-4914-93fd-02c313f0ba58','a7308212-6117-4e97-abeb-c2c38c18f601'),('de8c0214-4a68-4cb9-860f-efffa777c43f','a5d09554-f710-438d-8cb1-772529e3135f'),('ed246df5-c274-4a7e-9ebf-1e0a713cf89a','10875daf-c9f6-4217-a209-e48217eadb63'),('ed246df5-c274-4a7e-9ebf-1e0a713cf89a','edb27837-fd79-4c28-852c-9240e82e3614');
/*!40000 ALTER TABLE `COMPOSITE_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CREDENTIAL`
--

DROP TABLE IF EXISTS `CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext DEFAULT NULL,
  `CREDENTIAL_DATA` longtext DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_CREDENTIAL` (`USER_ID`),
  CONSTRAINT `FK_PFYR0GLASQYL0DEI3KL69R6V0` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CREDENTIAL`
--

LOCK TABLES `CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `CREDENTIAL` DISABLE KEYS */;
INSERT INTO `CREDENTIAL` VALUES ('3bd6e4ad-325f-4da5-b58c-e13a0e980e56',NULL,'password','9c5e25be-93cf-4459-8bae-bc18fdb0f7d5',1616507255555,NULL,'{\"value\":\"CcUPIHRG9VUXFVY2LSdjOf/pkzZtWsptv5+LTHv5fqWpzVcTpzb5dNbDnvskj2ADUlvcjk5DcYSaIpjXVcHGWQ==\",\"salt\":\"cetThH5e6LZmwEoEnJsryw==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('42a4d620-54b6-47e4-818e-d279e91d4e6d',NULL,'password','f08891c8-3541-45d3-bc57-37cde9096b3d',1615891100882,NULL,'{\"value\":\"+N9CBh75Swf3tS8HqncJYrcN+iylflCkzZQl6dBPzTXshXUvNJOsAPTpIhSjYxzjBNgUQ+HCLpueS8tmcbFXMQ==\",\"salt\":\"gYCGz5mdbOoPUpu3PLHwaQ==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('48a68eb8-5b8c-490f-8208-95a6b25abe94',NULL,'password','c74ef0bb-d1ed-4697-b018-98c3ede35288',1616507306691,NULL,'{\"value\":\"na5zwmM2SqPtpCjvzzN6fp5yptOMMxux4l/gBD7vMxIG4LSs4CLLm2GtmNxcp2uk61uYrrriODmfugB3nTwgpQ==\",\"salt\":\"7r4+D7GVsH/QMnOxGJOFAw==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('49103b19-098b-4a28-9298-126bc78ebc2a',NULL,'password','266cdefd-6754-4a6c-945f-558cae27e4eb',1616507276419,NULL,'{\"value\":\"JZxhIpDZFp1MbHHkZ7USqF0OkepINKQ1zdiyfTRmO2/XbbOK1n77cicG/6z5+XcuzdrGj37B2CbX52j5SDUJig==\",\"salt\":\"5YuvNsPq95bGjA6jN6YxYA==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('63651b03-2cdb-44a6-aef3-a9a1e24676be',NULL,'password','2eab712e-f2e3-4980-8e59-0c04e6034c88',1616507380776,NULL,'{\"value\":\"gsMMA6pRQUw/WJFEYc3KjTBKMIIk8Y86gETmgcD9CEEjeMbP/ZSBQfHbjYApiqzFIQT+FzrgyCvE4Tp/jQRwoA==\",\"salt\":\"IV0CmPqGykvYLfyPj5OGXA==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('66080aee-76af-44db-bd17-1c920bd94de6',NULL,'password','0ea8c33e-b299-4af3-9f59-6068bd16e7eb',1616507409614,NULL,'{\"value\":\"GUqVAp/k1sj8tlrzYqbhSO1hq8G9JRWCQ1FFPA/yGTvR+Zvr5iuHGZCZaIhebYWgOJO/Q7Xfk55cLKRLIJ04CQ==\",\"salt\":\"yPttMfZHsZLR8QZ/YHFOUQ==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('e6118669-385e-477c-95a1-29d261683435',NULL,'password','e7ed1987-67cb-4ab9-957c-96a9d0558ba1',1616507337571,NULL,'{\"value\":\"EmbuOnEVO3/fSP6xoL88dOfAIqSBtXhqik6SzYa2ejfnzrf1SzY2VZT+vsPDEVbBlrDhz2d5/6pIVbHr+vRZbQ==\",\"salt\":\"PNd+s+t/XkGZQGqZB0S+GQ==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10);
/*!40000 ALTER TABLE `CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOG`
--

LOCK TABLES `DATABASECHANGELOG` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOG` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOG` VALUES ('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/jpa-changelog-1.0.0.Final.xml','2021-03-15 20:48:58',1,'EXECUTED','7:4e70412f24a3f382c82183742ec79317','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/db2-jpa-changelog-1.0.0.Final.xml','2021-03-15 20:48:58',2,'MARK_RAN','7:cb16724583e9675711801c6875114f28','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.1.0.Beta1','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Beta1.xml','2021-03-15 20:48:58',3,'EXECUTED','7:0310eb8ba07cec616460794d42ade0fa','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.1.0.Final','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Final.xml','2021-03-15 20:48:58',4,'EXECUTED','7:5d25857e708c3233ef4439df1f93f012','renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.2.0.Beta1','psilva@redhat.com','META-INF/jpa-changelog-1.2.0.Beta1.xml','2021-03-15 20:48:58',5,'EXECUTED','7:c7a54a1041d58eb3817a4a883b4d4e84','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.2.0.Beta1','psilva@redhat.com','META-INF/db2-jpa-changelog-1.2.0.Beta1.xml','2021-03-15 20:48:58',6,'MARK_RAN','7:2e01012df20974c1c2a605ef8afe25b7','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.2.0.RC1','bburke@redhat.com','META-INF/jpa-changelog-1.2.0.CR1.xml','2021-03-15 20:48:59',7,'EXECUTED','7:0f08df48468428e0f30ee59a8ec01a41','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.2.0.RC1','bburke@redhat.com','META-INF/db2-jpa-changelog-1.2.0.CR1.xml','2021-03-15 20:48:59',8,'MARK_RAN','7:a77ea2ad226b345e7d689d366f185c8c','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.2.0.Final','keycloak','META-INF/jpa-changelog-1.2.0.Final.xml','2021-03-15 20:48:59',9,'EXECUTED','7:a3377a2059aefbf3b90ebb4c4cc8e2ab','update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.3.0','bburke@redhat.com','META-INF/jpa-changelog-1.3.0.xml','2021-03-15 20:48:59',10,'EXECUTED','7:04c1dbedc2aa3e9756d1a1668e003451','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.4.0','bburke@redhat.com','META-INF/jpa-changelog-1.4.0.xml','2021-03-15 20:48:59',11,'EXECUTED','7:36ef39ed560ad07062d956db861042ba','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.4.0','bburke@redhat.com','META-INF/db2-jpa-changelog-1.4.0.xml','2021-03-15 20:48:59',12,'MARK_RAN','7:d909180b2530479a716d3f9c9eaea3d7','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.5.0','bburke@redhat.com','META-INF/jpa-changelog-1.5.0.xml','2021-03-15 20:48:59',13,'EXECUTED','7:cf12b04b79bea5152f165eb41f3955f6','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.6.1_from15','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2021-03-15 20:48:59',14,'EXECUTED','7:7e32c8f05c755e8675764e7d5f514509','addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.6.1_from16-pre','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2021-03-15 20:48:59',15,'MARK_RAN','7:980ba23cc0ec39cab731ce903dd01291','delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.6.1_from16','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2021-03-15 20:48:59',16,'MARK_RAN','7:2fa220758991285312eb84f3b4ff5336','dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.6.1','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2021-03-15 20:48:59',17,'EXECUTED','7:d41d8cd98f00b204e9800998ecf8427e','empty','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.7.0','bburke@redhat.com','META-INF/jpa-changelog-1.7.0.xml','2021-03-15 20:48:59',18,'EXECUTED','7:91ace540896df890cc00a0490ee52bbc','createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.8.0','mposolda@redhat.com','META-INF/jpa-changelog-1.8.0.xml','2021-03-15 20:48:59',19,'EXECUTED','7:c31d1646dfa2618a9335c00e07f89f24','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.8.0-2','keycloak','META-INF/jpa-changelog-1.8.0.xml','2021-03-15 20:48:59',20,'EXECUTED','7:df8bc21027a4f7cbbb01f6344e89ce07','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.8.0','mposolda@redhat.com','META-INF/db2-jpa-changelog-1.8.0.xml','2021-03-15 20:48:59',21,'MARK_RAN','7:f987971fe6b37d963bc95fee2b27f8df','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.8.0-2','keycloak','META-INF/db2-jpa-changelog-1.8.0.xml','2021-03-15 20:48:59',22,'MARK_RAN','7:df8bc21027a4f7cbbb01f6344e89ce07','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.9.0','mposolda@redhat.com','META-INF/jpa-changelog-1.9.0.xml','2021-03-15 20:48:59',23,'EXECUTED','7:ed2dc7f799d19ac452cbcda56c929e47','update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.9.1','keycloak','META-INF/jpa-changelog-1.9.1.xml','2021-03-15 20:48:59',24,'EXECUTED','7:80b5db88a5dda36ece5f235be8757615','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.9.1','keycloak','META-INF/db2-jpa-changelog-1.9.1.xml','2021-03-15 20:48:59',25,'MARK_RAN','7:1437310ed1305a9b93f8848f301726ce','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'3.5.4',NULL,NULL,'5841338193'),('1.9.2','keycloak','META-INF/jpa-changelog-1.9.2.xml','2021-03-15 20:48:59',26,'EXECUTED','7:b82ffb34850fa0836be16deefc6a87c4','createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-2.0.0','psilva@redhat.com','META-INF/jpa-changelog-authz-2.0.0.xml','2021-03-15 20:49:00',27,'EXECUTED','7:9cc98082921330d8d9266decdd4bd658','createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-2.5.1','psilva@redhat.com','META-INF/jpa-changelog-authz-2.5.1.xml','2021-03-15 20:49:00',28,'EXECUTED','7:03d64aeed9cb52b969bd30a7ac0db57e','update tableName=RESOURCE_SERVER_POLICY','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.1.0-KEYCLOAK-5461','bburke@redhat.com','META-INF/jpa-changelog-2.1.0.xml','2021-03-15 20:49:00',29,'EXECUTED','7:f1f9fd8710399d725b780f463c6b21cd','createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.2.0','bburke@redhat.com','META-INF/jpa-changelog-2.2.0.xml','2021-03-15 20:49:00',30,'EXECUTED','7:53188c3eb1107546e6f765835705b6c1','addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.3.0','bburke@redhat.com','META-INF/jpa-changelog-2.3.0.xml','2021-03-15 20:49:00',31,'EXECUTED','7:d6e6f3bc57a0c5586737d1351725d4d4','createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.4.0','bburke@redhat.com','META-INF/jpa-changelog-2.4.0.xml','2021-03-15 20:49:00',32,'EXECUTED','7:454d604fbd755d9df3fd9c6329043aa5','customChange','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.5.0','bburke@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2021-03-15 20:49:00',33,'EXECUTED','7:57e98a3077e29caf562f7dbf80c72600','customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.5.0-unicode-oracle','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2021-03-15 20:49:00',34,'MARK_RAN','7:e4c7e8f2256210aee71ddc42f538b57a','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.5.0-unicode-other-dbs','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2021-03-15 20:49:00',35,'EXECUTED','7:09a43c97e49bc626460480aa1379b522','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.5.0-duplicate-email-support','slawomir@dabek.name','META-INF/jpa-changelog-2.5.0.xml','2021-03-15 20:49:00',36,'EXECUTED','7:26bfc7c74fefa9126f2ce702fb775553','addColumn tableName=REALM','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.5.0-unique-group-names','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2021-03-15 20:49:00',37,'EXECUTED','7:a161e2ae671a9020fff61e996a207377','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'3.5.4',NULL,NULL,'5841338193'),('2.5.1','bburke@redhat.com','META-INF/jpa-changelog-2.5.1.xml','2021-03-15 20:49:00',38,'EXECUTED','7:37fc1781855ac5388c494f1442b3f717','addColumn tableName=FED_USER_CONSENT','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.0.0','bburke@redhat.com','META-INF/jpa-changelog-3.0.0.xml','2021-03-15 20:49:00',39,'EXECUTED','7:13a27db0dae6049541136adad7261d27','addColumn tableName=IDENTITY_PROVIDER','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.2.0-fix','keycloak','META-INF/jpa-changelog-3.2.0.xml','2021-03-15 20:49:00',40,'MARK_RAN','7:550300617e3b59e8af3a6294df8248a3','addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.2.0-fix-with-keycloak-5416','keycloak','META-INF/jpa-changelog-3.2.0.xml','2021-03-15 20:49:00',41,'MARK_RAN','7:e3a9482b8931481dc2772a5c07c44f17','dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.2.0-fix-offline-sessions','hmlnarik','META-INF/jpa-changelog-3.2.0.xml','2021-03-15 20:49:00',42,'EXECUTED','7:72b07d85a2677cb257edb02b408f332d','customChange','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.2.0-fixed','keycloak','META-INF/jpa-changelog-3.2.0.xml','2021-03-15 20:49:00',43,'EXECUTED','7:a72a7858967bd414835d19e04d880312','addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.3.0','keycloak','META-INF/jpa-changelog-3.3.0.xml','2021-03-15 20:49:00',44,'EXECUTED','7:94edff7cf9ce179e7e85f0cd78a3cf2c','addColumn tableName=USER_ENTITY','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-3.4.0.CR1-resource-server-pk-change-part1','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2021-03-15 20:49:00',45,'EXECUTED','7:6a48ce645a3525488a90fbf76adf3bb3','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2021-03-15 20:49:00',46,'EXECUTED','7:e64b5dcea7db06077c6e57d3b9e5ca14','customChange','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2021-03-15 20:49:00',47,'MARK_RAN','7:fd8cf02498f8b1e72496a20afc75178c','dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2021-03-15 20:49:01',48,'EXECUTED','7:542794f25aa2b1fbabb7e577d6646319','addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authn-3.4.0.CR1-refresh-token-max-reuse','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2021-03-15 20:49:01',49,'EXECUTED','7:edad604c882df12f74941dac3cc6d650','addColumn tableName=REALM','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.4.0','keycloak','META-INF/jpa-changelog-3.4.0.xml','2021-03-15 20:49:01',50,'EXECUTED','7:0f88b78b7b46480eb92690cbf5e44900','addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.4.0-KEYCLOAK-5230','hmlnarik@redhat.com','META-INF/jpa-changelog-3.4.0.xml','2021-03-15 20:49:01',51,'EXECUTED','7:d560e43982611d936457c327f872dd59','createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.4.1','psilva@redhat.com','META-INF/jpa-changelog-3.4.1.xml','2021-03-15 20:49:01',52,'EXECUTED','7:c155566c42b4d14ef07059ec3b3bbd8e','modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.4.2','keycloak','META-INF/jpa-changelog-3.4.2.xml','2021-03-15 20:49:01',53,'EXECUTED','7:b40376581f12d70f3c89ba8ddf5b7dea','update tableName=REALM','',NULL,'3.5.4',NULL,NULL,'5841338193'),('3.4.2-KEYCLOAK-5172','mkanis@redhat.com','META-INF/jpa-changelog-3.4.2.xml','2021-03-15 20:49:01',54,'EXECUTED','7:a1132cc395f7b95b3646146c2e38f168','update tableName=CLIENT','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.0.0-KEYCLOAK-6335','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2021-03-15 20:49:01',55,'EXECUTED','7:d8dc5d89c789105cfa7ca0e82cba60af','createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.0.0-CLEANUP-UNUSED-TABLE','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2021-03-15 20:49:01',56,'EXECUTED','7:7822e0165097182e8f653c35517656a3','dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.0.0-KEYCLOAK-6228','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2021-03-15 20:49:01',57,'EXECUTED','7:c6538c29b9c9a08f9e9ea2de5c2b6375','dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.0.0-KEYCLOAK-5579-fixed','mposolda@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2021-03-15 20:49:01',58,'EXECUTED','7:6d4893e36de22369cf73bcb051ded875','dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-4.0.0.CR1','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.CR1.xml','2021-03-15 20:49:01',59,'EXECUTED','7:57960fc0b0f0dd0563ea6f8b2e4a1707','createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-4.0.0.Beta3','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.Beta3.xml','2021-03-15 20:49:01',60,'EXECUTED','7:2b4b8bff39944c7097977cc18dbceb3b','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-4.2.0.Final','mhajas@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2021-03-15 20:49:01',61,'EXECUTED','7:2aa42a964c59cd5b8ca9822340ba33a8','createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-4.2.0.Final-KEYCLOAK-9944','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2021-03-15 20:49:01',62,'EXECUTED','7:9ac9e58545479929ba23f4a3087a0346','addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.2.0-KEYCLOAK-6313','wadahiro@gmail.com','META-INF/jpa-changelog-4.2.0.xml','2021-03-15 20:49:01',63,'EXECUTED','7:14d407c35bc4fe1976867756bcea0c36','addColumn tableName=REQUIRED_ACTION_PROVIDER','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.3.0-KEYCLOAK-7984','wadahiro@gmail.com','META-INF/jpa-changelog-4.3.0.xml','2021-03-15 20:49:01',64,'EXECUTED','7:241a8030c748c8548e346adee548fa93','update tableName=REQUIRED_ACTION_PROVIDER','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.6.0-KEYCLOAK-7950','psilva@redhat.com','META-INF/jpa-changelog-4.6.0.xml','2021-03-15 20:49:01',65,'EXECUTED','7:7d3182f65a34fcc61e8d23def037dc3f','update tableName=RESOURCE_SERVER_RESOURCE','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.6.0-KEYCLOAK-8377','keycloak','META-INF/jpa-changelog-4.6.0.xml','2021-03-15 20:49:01',66,'EXECUTED','7:b30039e00a0b9715d430d1b0636728fa','createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.6.0-KEYCLOAK-8555','gideonray@gmail.com','META-INF/jpa-changelog-4.6.0.xml','2021-03-15 20:49:01',67,'EXECUTED','7:3797315ca61d531780f8e6f82f258159','createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.7.0-KEYCLOAK-1267','sguilhen@redhat.com','META-INF/jpa-changelog-4.7.0.xml','2021-03-15 20:49:01',68,'EXECUTED','7:c7aa4c8d9573500c2d347c1941ff0301','addColumn tableName=REALM','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.7.0-KEYCLOAK-7275','keycloak','META-INF/jpa-changelog-4.7.0.xml','2021-03-15 20:49:01',69,'EXECUTED','7:b207faee394fc074a442ecd42185a5dd','renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('4.8.0-KEYCLOAK-8835','sguilhen@redhat.com','META-INF/jpa-changelog-4.8.0.xml','2021-03-15 20:49:01',70,'EXECUTED','7:ab9a9762faaba4ddfa35514b212c4922','addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM','',NULL,'3.5.4',NULL,NULL,'5841338193'),('authz-7.0.0-KEYCLOAK-10443','psilva@redhat.com','META-INF/jpa-changelog-authz-7.0.0.xml','2021-03-15 20:49:01',71,'EXECUTED','7:b9710f74515a6ccb51b72dc0d19df8c4','addColumn tableName=RESOURCE_SERVER','',NULL,'3.5.4',NULL,NULL,'5841338193'),('8.0.0-adding-credential-columns','keycloak','META-INF/jpa-changelog-8.0.0.xml','2021-03-15 20:49:01',72,'EXECUTED','7:ec9707ae4d4f0b7452fee20128083879','addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL','',NULL,'3.5.4',NULL,NULL,'5841338193'),('8.0.0-updating-credential-data-not-oracle','keycloak','META-INF/jpa-changelog-8.0.0.xml','2021-03-15 20:49:01',73,'EXECUTED','7:03b3f4b264c3c68ba082250a80b74216','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'3.5.4',NULL,NULL,'5841338193'),('8.0.0-updating-credential-data-oracle','keycloak','META-INF/jpa-changelog-8.0.0.xml','2021-03-15 20:49:01',74,'MARK_RAN','7:64c5728f5ca1f5aa4392217701c4fe23','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'3.5.4',NULL,NULL,'5841338193'),('8.0.0-credential-cleanup-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2021-03-15 20:49:01',75,'EXECUTED','7:b48da8c11a3d83ddd6b7d0c8c2219345','dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('8.0.0-resource-tag-support','keycloak','META-INF/jpa-changelog-8.0.0.xml','2021-03-15 20:49:01',76,'EXECUTED','7:a73379915c23bfad3e8f5c6d5c0aa4bd','addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.0-always-display-client','keycloak','META-INF/jpa-changelog-9.0.0.xml','2021-03-15 20:49:01',77,'EXECUTED','7:39e0073779aba192646291aa2332493d','addColumn tableName=CLIENT','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.0-drop-constraints-for-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2021-03-15 20:49:01',78,'MARK_RAN','7:81f87368f00450799b4bf42ea0b3ec34','dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.0-increase-column-size-federated-fk','keycloak','META-INF/jpa-changelog-9.0.0.xml','2021-03-15 20:49:01',79,'EXECUTED','7:20b37422abb9fb6571c618148f013a15','modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.0-recreate-constraints-after-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2021-03-15 20:49:01',80,'MARK_RAN','7:1970bb6cfb5ee800736b95ad3fb3c78a','addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.1-add-index-to-client.client_id','keycloak','META-INF/jpa-changelog-9.0.1.xml','2021-03-15 20:49:01',81,'EXECUTED','7:45d9b25fc3b455d522d8dcc10a0f4c80','createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.1-KEYCLOAK-12579-drop-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2021-03-15 20:49:01',82,'MARK_RAN','7:890ae73712bc187a66c2813a724d037f','dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.1-KEYCLOAK-12579-add-not-null-constraint','keycloak','META-INF/jpa-changelog-9.0.1.xml','2021-03-15 20:49:01',83,'EXECUTED','7:0a211980d27fafe3ff50d19a3a29b538','addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.1-KEYCLOAK-12579-recreate-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2021-03-15 20:49:01',84,'MARK_RAN','7:a161e2ae671a9020fff61e996a207377','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'3.5.4',NULL,NULL,'5841338193'),('9.0.1-add-index-to-events','keycloak','META-INF/jpa-changelog-9.0.1.xml','2021-03-15 20:49:01',85,'EXECUTED','7:01c49302201bdf815b0a18d1f98a55dc','createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY','',NULL,'3.5.4',NULL,NULL,'5841338193'),('map-remove-ri','keycloak','META-INF/jpa-changelog-11.0.0.xml','2021-03-15 20:49:01',86,'EXECUTED','7:3dace6b144c11f53f1ad2c0361279b86','dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9','',NULL,'3.5.4',NULL,NULL,'5841338193'),('map-remove-ri','keycloak','META-INF/jpa-changelog-12.0.0.xml','2021-03-15 20:49:01',87,'EXECUTED','7:578d0b92077eaf2ab95ad0ec087aa903','dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...','',NULL,'3.5.4',NULL,NULL,'5841338193'),('12.1.0-add-realm-localization-table','keycloak','META-INF/jpa-changelog-12.0.0.xml','2021-03-15 20:49:01',88,'EXECUTED','7:c95abe90d962c57a09ecaee57972835d','createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS','',NULL,'3.5.4',NULL,NULL,'5841338193');
/*!40000 ALTER TABLE `DATABASECHANGELOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOGLOCK`
--

LOCK TABLES `DATABASECHANGELOGLOCK` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOGLOCK` VALUES (1,'\0',NULL,NULL),(1000,'\0',NULL,NULL),(1001,'\0',NULL,NULL);
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEFAULT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `DEFAULT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEFAULT_CLIENT_SCOPE` (
  `REALM_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`REALM_ID`,`SCOPE_ID`),
  KEY `IDX_DEFCLS_REALM` (`REALM_ID`),
  KEY `IDX_DEFCLS_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_R_DEF_CLI_SCOPE_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`),
  CONSTRAINT `FK_R_DEF_CLI_SCOPE_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEFAULT_CLIENT_SCOPE`
--

LOCK TABLES `DEFAULT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `DEFAULT_CLIENT_SCOPE` VALUES ('Aulos','1588db9a-7850-4847-9b0a-8c22a31c6050',''),('Aulos','45f3af70-ca60-4c19-afc3-4481d00c15b3',''),('Aulos','4799d80e-e81c-4acf-b5eb-fc4bd7e23df5','\0'),('Aulos','5d591862-db65-4dae-950c-d066e986b10e',''),('Aulos','9b6b0cb1-7524-4adf-b984-fd838c0f6894',''),('Aulos','a8ed3f14-4b56-4af5-91d5-266882a2e843','\0'),('Aulos','d161f53e-80f9-4f20-ad02-eca6de8b2ac0',''),('Aulos','d4645f66-e63e-4dba-a5a0-ef9cde0edec1','\0'),('Aulos','e08ff630-3d3e-4c7b-862f-c25d401dfdb2','\0'),('master','40c92e7c-bdd9-4f83-94ff-82ea052b3185','\0'),('master','7cd91cbe-e19e-45c3-87c1-a775ff5323c5','\0'),('master','9165e994-2250-4241-92d4-17d441d3bad5',''),('master','9231a691-225c-4c48-819b-46427dcc234f',''),('master','ade321a3-a4c0-45de-9890-e3016868b7c5',''),('master','e20613ca-b1dd-4202-bd24-01abd3bab492','\0'),('master','efda4309-9a26-4f8f-8151-e0ef533273d2','\0'),('master','f31bb44c-102c-4f24-9c71-db0ef56ff5bc',''),('master','fbca0742-60dc-45be-8183-9bc6cffc254f','');
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EVENT_ENTITY`
--

DROP TABLE IF EXISTS `EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON` text DEFAULT NULL,
  `ERROR` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `SESSION_ID` varchar(255) DEFAULT NULL,
  `EVENT_TIME` bigint(20) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_EVENT_TIME` (`REALM_ID`,`EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EVENT_ENTITY`
--

LOCK TABLES `EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_IDENTITY`
--

DROP TABLE IF EXISTS `FEDERATED_IDENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FEDERATED_IDENTITY` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FEDERATED_USER_ID` varchar(255) DEFAULT NULL,
  `FEDERATED_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`),
  KEY `IDX_FEDIDENTITY_USER` (`USER_ID`),
  KEY `IDX_FEDIDENTITY_FEDUSER` (`FEDERATED_USER_ID`),
  CONSTRAINT `FK404288B92EF007A6` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_IDENTITY`
--

LOCK TABLES `FEDERATED_IDENTITY` WRITE;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_USER`
--

DROP TABLE IF EXISTS `FEDERATED_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FEDERATED_USER` (
  `ID` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_USER`
--

LOCK TABLES `FEDERATED_USER` WRITE;
/*!40000 ALTER TABLE `FEDERATED_USER` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `FED_USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `VALUE` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_ATTRIBUTE` (`USER_ID`,`REALM_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ATTRIBUTE`
--

LOCK TABLES `FED_USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint(20) DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CONSENT` (`USER_ID`,`CLIENT_ID`),
  KEY `IDX_FU_CONSENT_RU` (`REALM_ID`,`USER_ID`),
  KEY `IDX_FU_CNSNT_EXT` (`USER_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT`
--

LOCK TABLES `FED_USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT_CL_SCOPE`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT_CL_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_CONSENT_CL_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT_CL_SCOPE`
--

LOCK TABLES `FED_USER_CONSENT_CL_SCOPE` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CREDENTIAL`
--

DROP TABLE IF EXISTS `FED_USER_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext DEFAULT NULL,
  `CREDENTIAL_DATA` longtext DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CREDENTIAL` (`USER_ID`,`TYPE`),
  KEY `IDX_FU_CREDENTIAL_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CREDENTIAL`
--

LOCK TABLES `FED_USER_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `FED_USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP` (`USER_ID`,`GROUP_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `FED_USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `FED_USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_REQUIRED_ACTION` (
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_FU_REQUIRED_ACTION` (`USER_ID`,`REQUIRED_ACTION`),
  KEY `IDX_FU_REQUIRED_ACTION_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_REQUIRED_ACTION`
--

LOCK TABLES `FED_USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `FED_USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FED_USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_FU_ROLE_MAPPING` (`USER_ID`,`ROLE_ID`),
  KEY `IDX_FU_ROLE_MAPPING_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ROLE_MAPPING`
--

LOCK TABLES `FED_USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ATTRIBUTE`
--

DROP TABLE IF EXISTS `GROUP_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GROUP_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_GROUP_ATTR_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_GROUP_ATTRIBUTE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ATTRIBUTE`
--

LOCK TABLES `GROUP_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `GROUP_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GROUP_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`GROUP_ID`),
  KEY `IDX_GROUP_ROLE_MAPP_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_GROUP_ROLE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ROLE_MAPPING`
--

LOCK TABLES `GROUP_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDENTITY_PROVIDER` (
  `INTERNAL_ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ALIAS` varchar(255) DEFAULT NULL,
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `STORE_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `AUTHENTICATE_BY_DEFAULT` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ADD_TOKEN_ROLE` bit(1) NOT NULL DEFAULT b'1',
  `TRUST_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `FIRST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `POST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `LINK_ONLY` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`INTERNAL_ID`),
  UNIQUE KEY `UK_2DAELWNIBJI49AVXSRTUF6XJ33` (`PROVIDER_ALIAS`,`REALM_ID`),
  KEY `IDX_IDENT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK2B4EBC52AE5C3B34` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER`
--

LOCK TABLES `IDENTITY_PROVIDER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_CONFIG`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDENTITY_PROVIDER_CONFIG` (
  `IDENTITY_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FKDC4897CF864C4E43` FOREIGN KEY (`IDENTITY_PROVIDER_ID`) REFERENCES `IDENTITY_PROVIDER` (`INTERNAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_CONFIG`
--

LOCK TABLES `IDENTITY_PROVIDER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_MAPPER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDENTITY_PROVIDER_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `IDP_ALIAS` varchar(255) NOT NULL,
  `IDP_MAPPER_NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ID_PROV_MAPP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_IDPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_MAPPER`
--

LOCK TABLES `IDENTITY_PROVIDER_MAPPER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDP_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `IDP_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IDP_MAPPER_CONFIG` (
  `IDP_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDP_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_IDPMCONFIG` FOREIGN KEY (`IDP_MAPPER_ID`) REFERENCES `IDENTITY_PROVIDER_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDP_MAPPER_CONFIG`
--

LOCK TABLES `IDP_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_GROUP`
--

DROP TABLE IF EXISTS `KEYCLOAK_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KEYCLOAK_GROUP` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `PARENT_GROUP` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SIBLING_NAMES` (`REALM_ID`,`PARENT_GROUP`,`NAME`),
  CONSTRAINT `FK_GROUP_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_GROUP`
--

LOCK TABLES `KEYCLOAK_GROUP` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` DISABLE KEYS */;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_ROLE`
--

DROP TABLE IF EXISTS `KEYCLOAK_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `KEYCLOAK_ROLE` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_REALM_CONSTRAINT` varchar(255) DEFAULT NULL,
  `CLIENT_ROLE` bit(1) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `CLIENT` varchar(36) DEFAULT NULL,
  `REALM` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_J3RWUVD56ONTGSUHOGM184WW2-2` (`NAME`,`CLIENT_REALM_CONSTRAINT`),
  KEY `IDX_KEYCLOAK_ROLE_CLIENT` (`CLIENT`),
  KEY `IDX_KEYCLOAK_ROLE_REALM` (`REALM`),
  CONSTRAINT `FK_6VYQFE4CN4WLQ8R6KT5VDSJ5C` FOREIGN KEY (`REALM`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_ROLE`
--

LOCK TABLES `KEYCLOAK_ROLE` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` DISABLE KEYS */;
INSERT INTO `KEYCLOAK_ROLE` VALUES ('0046dbd1-0832-4ba8-a4d8-d398e2ef4cb9','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_view-realm}','view-realm','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('03351bf8-e596-4b5c-a4ca-c7919762dff3','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_manage-users}','manage-users','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('03d01875-13d7-4e53-82a0-49e1a43ca233','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_view-realm}','view-realm','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('04684676-7ac6-4728-9e8c-a7fd1d46d840','2162596c-1963-4d57-bd5c-ffaef0269e14','','${role_view-consent}','view-consent','Aulos','2162596c-1963-4d57-bd5c-ffaef0269e14',NULL),('052477c6-85a3-4de8-9f95-8a3728bcbf84','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_view-events}','view-events','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('076d8e1a-e012-4663-bffa-ea87d7122744','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_manage-clients}','manage-clients','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('09d11584-feb1-446c-9ef2-dd9501996d62','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_manage-authorization}','manage-authorization','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('0a4d7ad2-db75-4995-9b97-a2d55fedc0ed','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_manage-users}','manage-users','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('10875daf-c9f6-4217-a209-e48217eadb63','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_query-groups}','query-groups','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('10a18df0-0e9c-4e3f-8859-4305a1ad021d','Aulos','\0','Utente che può gestire tutti gli aspetti del sistema, compresi gli utenti Keycloak','amministratore','Aulos',NULL,'Aulos'),('1101af9e-9149-4f81-ae19-ccb2e5e72da5','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_query-clients}','query-clients','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('1fbf28fd-85dc-4a12-b943-809c82c26aab','2162596c-1963-4d57-bd5c-ffaef0269e14','','${role_manage-consent}','manage-consent','Aulos','2162596c-1963-4d57-bd5c-ffaef0269e14',NULL),('21564716-12c6-44cd-9a50-0eb3eda42b21','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_manage-identity-providers}','manage-identity-providers','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('26d70553-aa78-4653-b13a-05b0c7b1c928','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_manage-clients}','manage-clients','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('27b2857f-fb9d-43b4-b69d-ee4c0b343e82','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_view-events}','view-events','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('27fb2112-9acf-44e1-8ef4-1894e8314750','2162596c-1963-4d57-bd5c-ffaef0269e14','','${role_view-profile}','view-profile','Aulos','2162596c-1963-4d57-bd5c-ffaef0269e14',NULL),('3102d752-c7f7-4573-81fa-45ad2afde60a','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_impersonation}','impersonation','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('31d091ab-89a0-478e-9b3c-a06599f43001','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_view-realm}','view-realm','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('334adf7d-7e99-4d8e-973c-e986820146cc','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','${role_view-profile}','view-profile','master','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c',NULL),('3db296c8-12d4-4c47-989e-4c3d8463d4ce','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_query-realms}','query-realms','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('3ddd2326-65a2-4cbe-a45a-fe8b703a001a','Aulos','\0','Membro della sicurezza di ateneo che può gestire tutti gli eventi','supervisore','Aulos',NULL,'Aulos'),('416c701e-dd36-43a4-8d6a-2b8c4b3e5084','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_view-users}','view-users','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('4f5bb111-893e-4440-ac70-4925b08ba020','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_impersonation}','impersonation','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','2162596c-1963-4d57-bd5c-ffaef0269e14','','${role_manage-account}','manage-account','Aulos','2162596c-1963-4d57-bd5c-ffaef0269e14',NULL),('58b7ae0b-9542-4556-9e07-47a6ad3d791e','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_create-client}','create-client','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('5b66adde-8a7c-421e-999c-11219e2890c1','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_query-users}','query-users','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('5f39c465-5032-4471-a0a1-0529dbfdb37f','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','${role_delete-account}','delete-account','master','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c',NULL),('62900bb3-be03-4263-9539-dc3e86dff2d0','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_manage-events}','manage-events','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('6314fd91-4ff7-40ff-9ee2-5d3450408dd9','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_view-identity-providers}','view-identity-providers','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('67823e04-a547-4445-9788-cc89faba71fd','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','${role_manage-account-links}','manage-account-links','master','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c',NULL),('68015baa-7977-4635-b22e-4520597b26f4','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_manage-realm}','manage-realm','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('6bcf5bfe-d61a-42bb-8468-20e8750ce888','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_create-client}','create-client','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('6d2aab64-9685-48e4-94b4-b19dd09f14c5','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_create-client}','create-client','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('6db32d76-4143-4d4c-824e-ceac9dd96e0a','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','${role_manage-account}','manage-account','master','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c',NULL),('74e739d7-816a-4e57-a288-5c6f4ea2ddc5','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_query-realms}','query-realms','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('7b8d8ed1-be6f-4ea0-91d0-3b27acd35612','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_query-realms}','query-realms','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('7ec837d8-1a60-4f3b-8879-ed58605d0ca1','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_manage-identity-providers}','manage-identity-providers','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('7fe21b9f-b3f2-4044-8a97-b37ee5523e09','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_manage-realm}','manage-realm','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('8159103f-7527-432e-9475-faa72d1f2a0b','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_view-clients}','view-clients','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('83122dc6-9eb0-4f6e-8700-99f68df85d06','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_impersonation}','impersonation','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('832e079e-c5d6-4a04-9931-3a48ef94f292','master','\0','${role_admin}','admin','master',NULL,'master'),('84a8b835-8735-468d-bb10-7f3c9ce31c02','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_manage-identity-providers}','manage-identity-providers','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('89b09cba-22d1-47e6-af80-369fac2d354d','Aulos','\0','${role_uma_authorization}','uma_authorization','Aulos',NULL,'Aulos'),('8a26cd82-4159-44c8-9ee7-620e9d7b64cc','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_manage-authorization}','manage-authorization','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('8c461bf3-8afa-4307-84d7-4478eeb4c4c3','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_manage-authorization}','manage-authorization','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('8f20e717-6f37-4154-bac7-ad146cb77ad5','Aulos','\0','${role_offline-access}','offline_access','Aulos',NULL,'Aulos'),('912ded8f-8cab-4585-8928-f5817f918d2d','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_query-groups}','query-groups','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('957cd5ef-be32-4ef3-9bfd-6ef3822901b1','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_realm-admin}','realm-admin','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('96afd5de-32ad-46db-b4ce-9d5bd7d71702','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_manage-events}','manage-events','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('a3b9d471-ca68-4a27-b52d-bba700ce2ceb','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_view-identity-providers}','view-identity-providers','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('a5d09554-f710-438d-8cb1-772529e3135f','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','${role_view-consent}','view-consent','master','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c',NULL),('a656289f-7a2c-4a9e-998d-f9919bb29640','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_view-authorization}','view-authorization','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('a7308212-6117-4e97-abeb-c2c38c18f601','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_query-groups}','query-groups','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('a879a39e-cd9b-4389-b3fb-c88947afa1e7','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_query-clients}','query-clients','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('ac517e4b-210f-43dd-8156-e71a76f1e7b9','Aulos','\0','Utente che gestisce i propri eventi','responsabile','Aulos',NULL,'Aulos'),('af67fea2-5f8f-4ea7-a134-46a03bf63e7a','2162596c-1963-4d57-bd5c-ffaef0269e14','','${role_manage-account-links}','manage-account-links','Aulos','2162596c-1963-4d57-bd5c-ffaef0269e14',NULL),('b476d429-ecc1-4ac9-b33c-2d51b8bac19a','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','${role_view-applications}','view-applications','master','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c',NULL),('bea557f7-55bf-4af8-9dc4-7f4449f8a45e','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_view-clients}','view-clients','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('bfa81ecf-18ce-4764-aff9-555f8d94d395','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_view-clients}','view-clients','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('c1b411f4-9b84-4e27-b6be-d45a04bca2cc','2162596c-1963-4d57-bd5c-ffaef0269e14','','${role_delete-account}','delete-account','Aulos','2162596c-1963-4d57-bd5c-ffaef0269e14',NULL),('c2e89870-3b29-4c22-a31b-a5fc58856353','f2fc58d6-5a17-48f6-805d-d75889994e1f','','${role_read-token}','read-token','master','f2fc58d6-5a17-48f6-805d-d75889994e1f',NULL),('c57adbc6-e4ac-4554-8a5e-815faa4cd6b0','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_manage-realm}','manage-realm','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('c988024c-ce1c-40cf-b51d-f5749216b010','2162596c-1963-4d57-bd5c-ffaef0269e14','','${role_view-applications}','view-applications','Aulos','2162596c-1963-4d57-bd5c-ffaef0269e14',NULL),('c9f261e5-ab81-4bca-abd0-e224dbca71ca','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_manage-clients}','manage-clients','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('d4dc3fa3-ec47-4dc4-849d-c3c25e81d0d5','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_query-clients}','query-clients','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('d6933e68-95aa-4183-9323-4a416b702da5','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_view-authorization}','view-authorization','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('dd878016-04c2-4914-93fd-02c313f0ba58','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_view-users}','view-users','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('de8c0214-4a68-4cb9-860f-efffa777c43f','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','','${role_manage-consent}','manage-consent','master','4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c',NULL),('e0c67745-2377-4d0d-8bb2-88c679a54cb5','master','\0','${role_create-realm}','create-realm','master',NULL,'master'),('e4afe5b1-d3d0-47aa-8731-2978148e975e','53a0df34-e058-4d8e-9f3f-ea948ba64bdc','','${role_manage-events}','manage-events','master','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',NULL),('e5c08b69-94ac-431c-a205-7c65398babc9','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_view-identity-providers}','view-identity-providers','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('e913da63-21cd-4858-97d1-d579d07d0b8e','a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca','','${role_read-token}','read-token','Aulos','a9fd8c55-a6b7-426c-ae87-9a17a1f6f2ca',NULL),('e939dcc6-31af-4d71-bcb7-aa609ddf123c','master','\0','${role_offline-access}','offline_access','master',NULL,'master'),('e974c422-5de5-496b-ac65-64e8996f8439','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_view-authorization}','view-authorization','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('eb33cb0d-9646-43d5-b428-c14325a27dee','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_manage-users}','manage-users','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('ed246df5-c274-4a7e-9ebf-1e0a713cf89a','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_view-users}','view-users','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('edb27837-fd79-4c28-852c-9240e82e3614','760ab7aa-727c-4faa-81d6-e250c7c6ace6','','${role_query-users}','query-users','master','760ab7aa-727c-4faa-81d6-e250c7c6ace6',NULL),('edd515cd-4c7c-40bc-bb24-e05f38e45714','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_query-users}','query-users','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL),('f0af10fb-6a7b-48b8-9425-3346562af420','master','\0','${role_uma_authorization}','uma_authorization','master',NULL,'master'),('fdef4f98-0507-4a64-a545-17a1e7637fb3','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5','','${role_view-events}','view-events','Aulos','769c26c4-de9a-475e-83b8-f8d9e4fe9ee5',NULL);
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MIGRATION_MODEL`
--

DROP TABLE IF EXISTS `MIGRATION_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MIGRATION_MODEL` (
  `ID` varchar(36) NOT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `UPDATE_TIME` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  KEY `IDX_UPDATE_TIME` (`UPDATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MIGRATION_MODEL`
--

LOCK TABLES `MIGRATION_MODEL` WRITE;
/*!40000 ALTER TABLE `MIGRATION_MODEL` DISABLE KEYS */;
INSERT INTO `MIGRATION_MODEL` VALUES ('zakbq','12.0.4',1615841344);
/*!40000 ALTER TABLE `MIGRATION_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_CLIENT_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OFFLINE_CLIENT_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `TIMESTAMP` int(11) DEFAULT NULL,
  `DATA` longtext DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) NOT NULL DEFAULT 'local',
  `EXTERNAL_CLIENT_ID` varchar(255) NOT NULL DEFAULT 'local',
  PRIMARY KEY (`USER_SESSION_ID`,`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`OFFLINE_FLAG`),
  KEY `IDX_US_SESS_ID_ON_CL_SESS` (`USER_SESSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_CLIENT_SESSION`
--

LOCK TABLES `OFFLINE_CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_USER_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OFFLINE_USER_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `CREATED_ON` int(11) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `DATA` longtext DEFAULT NULL,
  `LAST_SESSION_REFRESH` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`USER_SESSION_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_CREATEDON` (`CREATED_ON`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_USER_SESSION`
--

LOCK TABLES `OFFLINE_USER_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `POLICY_CONFIG`
--

DROP TABLE IF EXISTS `POLICY_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `POLICY_CONFIG` (
  `POLICY_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  PRIMARY KEY (`POLICY_ID`,`NAME`),
  CONSTRAINT `FKDC34197CF864C4E43` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POLICY_CONFIG`
--

LOCK TABLES `POLICY_CONFIG` WRITE;
/*!40000 ALTER TABLE `POLICY_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `POLICY_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROTOCOL_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `PROTOCOL` varchar(255) NOT NULL,
  `PROTOCOL_MAPPER_NAME` varchar(255) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `CLIENT_SCOPE_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_PROTOCOL_MAPPER_CLIENT` (`CLIENT_ID`),
  KEY `IDX_CLSCOPE_PROTMAP` (`CLIENT_SCOPE_ID`),
  CONSTRAINT `FK_CLI_SCOPE_MAPPER` FOREIGN KEY (`CLIENT_SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`),
  CONSTRAINT `FK_PCM_REALM` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER`
--

LOCK TABLES `PROTOCOL_MAPPER` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER` VALUES ('000feb2e-616f-47f6-a5f1-2dbf9b5a10cc','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'fbca0742-60dc-45be-8183-9bc6cffc254f'),('02b9e24b-acef-4d2d-8e10-e8e0541685ac','upn','openid-connect','oidc-usermodel-property-mapper',NULL,'40c92e7c-bdd9-4f83-94ff-82ea052b3185'),('06202fdb-6674-4139-a573-f7b7ce8d9b6e','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('0aab03ae-9d1a-47d4-97f3-acc1149d755a','username','openid-connect','oidc-usermodel-property-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('146027b0-bd00-4a11-a62c-8411826c11ed','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('18723145-4ce7-4021-a348-a25b60cfabc8','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'7cd91cbe-e19e-45c3-87c1-a775ff5323c5'),('192721aa-5ddb-4d8b-bc85-688c1a49492b','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('20499dd8-427f-4d3e-8c06-724d1b098f3f','role list','saml','saml-role-list-mapper',NULL,'d161f53e-80f9-4f20-ad02-eca6de8b2ac0'),('272da5cc-7ec1-4e5c-adeb-d9dcf5cf4991','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('27b24c61-6645-4201-b13b-393ba75078f3','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('2896494a-e88c-4937-b586-20696e8f31a8','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'fbca0742-60dc-45be-8183-9bc6cffc254f'),('39b8eeed-39da-4281-862d-88749243d051','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('3dd54342-613c-46f5-b661-d5e634076321','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('4214d479-e1e0-4066-b6fc-582df214da49','upn','openid-connect','oidc-usermodel-property-mapper',NULL,'d4645f66-e63e-4dba-a5a0-ef9cde0edec1'),('4f7139de-2212-4d0a-87a1-3db34f3e5be9','email','openid-connect','oidc-usermodel-property-mapper',NULL,'45f3af70-ca60-4c19-afc3-4481d00c15b3'),('54a33067-8fd6-4e28-b701-708c3204c53e','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'5d591862-db65-4dae-950c-d066e986b10e'),('5bf78dcd-165b-4e59-ad98-f99230304568','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('64ea7b12-f0f7-4b63-a83b-6ae9ec2c9f5d','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('6c8b808a-e092-4b89-8652-1e2787f6f1bd','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('749e416f-6cd7-41ea-9438-7577677b6d57','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('7b367a81-5b97-475d-a67a-7170ed7f974a','family name','openid-connect','oidc-usermodel-property-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('7d03590c-9841-47bf-9235-2f8db49512b3','locale','openid-connect','oidc-usermodel-attribute-mapper','96094ef3-d44c-49ab-bbcf-08393ceb9a73',NULL),('85d967ae-1cb4-42e3-90a8-1c32b2350fb4','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'f31bb44c-102c-4f24-9c71-db0ef56ff5bc'),('8df6a7e5-30f5-47d5-85c6-1facfc7a4e6f','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'9231a691-225c-4c48-819b-46427dcc234f'),('8e48e8cd-e160-436e-a2d8-3e875bb067cc','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'a8ed3f14-4b56-4af5-91d5-266882a2e843'),('8fdf3451-8324-4e1c-9ebe-b77223fe4a5c','full name','openid-connect','oidc-full-name-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('914a788d-69ed-4bc4-a285-8012b1a26b40','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'7cd91cbe-e19e-45c3-87c1-a775ff5323c5'),('91adccdf-fa07-4ca7-9fd5-a90ddbd42254','role list','saml','saml-role-list-mapper',NULL,'ade321a3-a4c0-45de-9890-e3016868b7c5'),('92e2492c-4c18-4a4b-bfd3-4f29578503b8','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('93c545c6-2791-4b89-a9bb-cd47d865ddff','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'9b6b0cb1-7524-4adf-b984-fd838c0f6894'),('979c85b1-8589-408e-b854-644e85952cd0','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('9acdd0d3-c7d7-4b55-9d24-a790feb69835','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'9b6b0cb1-7524-4adf-b984-fd838c0f6894'),('a807876e-516e-488b-9866-4e5605008063','audience resolve','openid-connect','oidc-audience-resolve-mapper','fcc03cba-a47c-45c2-9f8b-94ee170077c1',NULL),('a83889d6-ca6b-4fa9-b6f9-4588bccca5fd','family name','openid-connect','oidc-usermodel-property-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('aee49b02-4a57-4d47-be83-074dd79d17e9','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('b1b19c02-a659-4928-a0d8-3c309b8ec3a9','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'a8ed3f14-4b56-4af5-91d5-266882a2e843'),('b24e513a-7443-4daf-888f-39a3891ea1be','email','openid-connect','oidc-usermodel-property-mapper',NULL,'9231a691-225c-4c48-819b-46427dcc234f'),('b42e5e13-233b-498e-8685-4e4a38dc13c9','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('b70c822d-9dd8-4426-a01c-68db79343151','address','openid-connect','oidc-address-mapper',NULL,'4799d80e-e81c-4acf-b5eb-fc4bd7e23df5'),('b819e905-bc68-4389-95d2-c426f0bf8b2f','username','openid-connect','oidc-usermodel-property-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('bae8388e-e29e-47b0-9df7-403530a175cb','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('bc2d71b2-51ac-47b6-8dc4-cc0e9e36f53c','given name','openid-connect','oidc-usermodel-property-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050'),('cbe29f3b-4ae3-4133-82a8-925756d38f6e','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'9b6b0cb1-7524-4adf-b984-fd838c0f6894'),('ce9f02ce-5194-417e-9905-e340da0a0553','audience resolve','openid-connect','oidc-audience-resolve-mapper','50f4c638-c959-40eb-a0be-254da5609b9a',NULL),('d469e6ae-4529-4780-ad3c-5766c6379e32','full name','openid-connect','oidc-full-name-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('d6afedd1-f7ff-4d49-95c3-b90db725d37f','locale','openid-connect','oidc-usermodel-attribute-mapper','98eea42e-2e80-4ba1-afb0-66a15c0f7c67',NULL),('e57f6647-383e-4fdd-ba97-e2daccafb9fd','given name','openid-connect','oidc-usermodel-property-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'d4645f66-e63e-4dba-a5a0-ef9cde0edec1'),('e89f630d-8840-40f2-b1a7-6d54781be923','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('ea329b2c-4215-42c8-9f15-6761eca794c1','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('ec750a9d-d2ce-4241-b618-7a446ffe43b4','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'45f3af70-ca60-4c19-afc3-4481d00c15b3'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','address','openid-connect','oidc-address-mapper',NULL,'efda4309-9a26-4f8f-8151-e0ef533273d2'),('f404ba8e-1faa-4c39-a6dc-7fc70cb46fbf','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'fbca0742-60dc-45be-8183-9bc6cffc254f'),('f7b5ddb4-4a96-46b6-970e-7e63f2f87f95','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'40c92e7c-bdd9-4f83-94ff-82ea052b3185'),('fd8f68e6-79dd-4aa9-a21e-a458a7e98527','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'9165e994-2250-4241-92d4-17d441d3bad5'),('fee3c99c-cdad-49eb-8072-ae080cf395d7','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'1588db9a-7850-4847-9b0a-8c22a31c6050');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROTOCOL_MAPPER_CONFIG` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`PROTOCOL_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_PMCONFIG` FOREIGN KEY (`PROTOCOL_MAPPER_ID`) REFERENCES `PROTOCOL_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER_CONFIG`
--

LOCK TABLES `PROTOCOL_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER_CONFIG` VALUES ('02b9e24b-acef-4d2d-8e10-e8e0541685ac','true','access.token.claim'),('02b9e24b-acef-4d2d-8e10-e8e0541685ac','upn','claim.name'),('02b9e24b-acef-4d2d-8e10-e8e0541685ac','true','id.token.claim'),('02b9e24b-acef-4d2d-8e10-e8e0541685ac','String','jsonType.label'),('02b9e24b-acef-4d2d-8e10-e8e0541685ac','username','user.attribute'),('02b9e24b-acef-4d2d-8e10-e8e0541685ac','true','userinfo.token.claim'),('06202fdb-6674-4139-a573-f7b7ce8d9b6e','true','access.token.claim'),('06202fdb-6674-4139-a573-f7b7ce8d9b6e','locale','claim.name'),('06202fdb-6674-4139-a573-f7b7ce8d9b6e','true','id.token.claim'),('06202fdb-6674-4139-a573-f7b7ce8d9b6e','String','jsonType.label'),('06202fdb-6674-4139-a573-f7b7ce8d9b6e','locale','user.attribute'),('06202fdb-6674-4139-a573-f7b7ce8d9b6e','true','userinfo.token.claim'),('0aab03ae-9d1a-47d4-97f3-acc1149d755a','true','access.token.claim'),('0aab03ae-9d1a-47d4-97f3-acc1149d755a','preferred_username','claim.name'),('0aab03ae-9d1a-47d4-97f3-acc1149d755a','true','id.token.claim'),('0aab03ae-9d1a-47d4-97f3-acc1149d755a','String','jsonType.label'),('0aab03ae-9d1a-47d4-97f3-acc1149d755a','username','user.attribute'),('0aab03ae-9d1a-47d4-97f3-acc1149d755a','true','userinfo.token.claim'),('146027b0-bd00-4a11-a62c-8411826c11ed','true','access.token.claim'),('146027b0-bd00-4a11-a62c-8411826c11ed','profile','claim.name'),('146027b0-bd00-4a11-a62c-8411826c11ed','true','id.token.claim'),('146027b0-bd00-4a11-a62c-8411826c11ed','String','jsonType.label'),('146027b0-bd00-4a11-a62c-8411826c11ed','profile','user.attribute'),('146027b0-bd00-4a11-a62c-8411826c11ed','true','userinfo.token.claim'),('18723145-4ce7-4021-a348-a25b60cfabc8','true','access.token.claim'),('18723145-4ce7-4021-a348-a25b60cfabc8','phone_number_verified','claim.name'),('18723145-4ce7-4021-a348-a25b60cfabc8','true','id.token.claim'),('18723145-4ce7-4021-a348-a25b60cfabc8','boolean','jsonType.label'),('18723145-4ce7-4021-a348-a25b60cfabc8','phoneNumberVerified','user.attribute'),('18723145-4ce7-4021-a348-a25b60cfabc8','true','userinfo.token.claim'),('192721aa-5ddb-4d8b-bc85-688c1a49492b','true','access.token.claim'),('192721aa-5ddb-4d8b-bc85-688c1a49492b','picture','claim.name'),('192721aa-5ddb-4d8b-bc85-688c1a49492b','true','id.token.claim'),('192721aa-5ddb-4d8b-bc85-688c1a49492b','String','jsonType.label'),('192721aa-5ddb-4d8b-bc85-688c1a49492b','picture','user.attribute'),('192721aa-5ddb-4d8b-bc85-688c1a49492b','true','userinfo.token.claim'),('20499dd8-427f-4d3e-8c06-724d1b098f3f','Role','attribute.name'),('20499dd8-427f-4d3e-8c06-724d1b098f3f','Basic','attribute.nameformat'),('20499dd8-427f-4d3e-8c06-724d1b098f3f','false','single'),('272da5cc-7ec1-4e5c-adeb-d9dcf5cf4991','true','access.token.claim'),('272da5cc-7ec1-4e5c-adeb-d9dcf5cf4991','middle_name','claim.name'),('272da5cc-7ec1-4e5c-adeb-d9dcf5cf4991','true','id.token.claim'),('272da5cc-7ec1-4e5c-adeb-d9dcf5cf4991','String','jsonType.label'),('272da5cc-7ec1-4e5c-adeb-d9dcf5cf4991','middleName','user.attribute'),('272da5cc-7ec1-4e5c-adeb-d9dcf5cf4991','true','userinfo.token.claim'),('27b24c61-6645-4201-b13b-393ba75078f3','true','access.token.claim'),('27b24c61-6645-4201-b13b-393ba75078f3','middle_name','claim.name'),('27b24c61-6645-4201-b13b-393ba75078f3','true','id.token.claim'),('27b24c61-6645-4201-b13b-393ba75078f3','String','jsonType.label'),('27b24c61-6645-4201-b13b-393ba75078f3','middleName','user.attribute'),('27b24c61-6645-4201-b13b-393ba75078f3','true','userinfo.token.claim'),('2896494a-e88c-4937-b586-20696e8f31a8','true','access.token.claim'),('2896494a-e88c-4937-b586-20696e8f31a8','realm_access.roles','claim.name'),('2896494a-e88c-4937-b586-20696e8f31a8','String','jsonType.label'),('2896494a-e88c-4937-b586-20696e8f31a8','true','multivalued'),('2896494a-e88c-4937-b586-20696e8f31a8','foo','user.attribute'),('39b8eeed-39da-4281-862d-88749243d051','true','access.token.claim'),('39b8eeed-39da-4281-862d-88749243d051','nickname','claim.name'),('39b8eeed-39da-4281-862d-88749243d051','true','id.token.claim'),('39b8eeed-39da-4281-862d-88749243d051','String','jsonType.label'),('39b8eeed-39da-4281-862d-88749243d051','nickname','user.attribute'),('39b8eeed-39da-4281-862d-88749243d051','true','userinfo.token.claim'),('3dd54342-613c-46f5-b661-d5e634076321','true','access.token.claim'),('3dd54342-613c-46f5-b661-d5e634076321','website','claim.name'),('3dd54342-613c-46f5-b661-d5e634076321','true','id.token.claim'),('3dd54342-613c-46f5-b661-d5e634076321','String','jsonType.label'),('3dd54342-613c-46f5-b661-d5e634076321','website','user.attribute'),('3dd54342-613c-46f5-b661-d5e634076321','true','userinfo.token.claim'),('4214d479-e1e0-4066-b6fc-582df214da49','true','access.token.claim'),('4214d479-e1e0-4066-b6fc-582df214da49','upn','claim.name'),('4214d479-e1e0-4066-b6fc-582df214da49','true','id.token.claim'),('4214d479-e1e0-4066-b6fc-582df214da49','String','jsonType.label'),('4214d479-e1e0-4066-b6fc-582df214da49','username','user.attribute'),('4214d479-e1e0-4066-b6fc-582df214da49','true','userinfo.token.claim'),('4f7139de-2212-4d0a-87a1-3db34f3e5be9','true','access.token.claim'),('4f7139de-2212-4d0a-87a1-3db34f3e5be9','email','claim.name'),('4f7139de-2212-4d0a-87a1-3db34f3e5be9','true','id.token.claim'),('4f7139de-2212-4d0a-87a1-3db34f3e5be9','String','jsonType.label'),('4f7139de-2212-4d0a-87a1-3db34f3e5be9','email','user.attribute'),('4f7139de-2212-4d0a-87a1-3db34f3e5be9','true','userinfo.token.claim'),('5bf78dcd-165b-4e59-ad98-f99230304568','true','access.token.claim'),('5bf78dcd-165b-4e59-ad98-f99230304568','nickname','claim.name'),('5bf78dcd-165b-4e59-ad98-f99230304568','true','id.token.claim'),('5bf78dcd-165b-4e59-ad98-f99230304568','String','jsonType.label'),('5bf78dcd-165b-4e59-ad98-f99230304568','nickname','user.attribute'),('5bf78dcd-165b-4e59-ad98-f99230304568','true','userinfo.token.claim'),('64ea7b12-f0f7-4b63-a83b-6ae9ec2c9f5d','true','access.token.claim'),('64ea7b12-f0f7-4b63-a83b-6ae9ec2c9f5d','locale','claim.name'),('64ea7b12-f0f7-4b63-a83b-6ae9ec2c9f5d','true','id.token.claim'),('64ea7b12-f0f7-4b63-a83b-6ae9ec2c9f5d','String','jsonType.label'),('64ea7b12-f0f7-4b63-a83b-6ae9ec2c9f5d','locale','user.attribute'),('64ea7b12-f0f7-4b63-a83b-6ae9ec2c9f5d','true','userinfo.token.claim'),('6c8b808a-e092-4b89-8652-1e2787f6f1bd','true','access.token.claim'),('6c8b808a-e092-4b89-8652-1e2787f6f1bd','gender','claim.name'),('6c8b808a-e092-4b89-8652-1e2787f6f1bd','true','id.token.claim'),('6c8b808a-e092-4b89-8652-1e2787f6f1bd','String','jsonType.label'),('6c8b808a-e092-4b89-8652-1e2787f6f1bd','gender','user.attribute'),('6c8b808a-e092-4b89-8652-1e2787f6f1bd','true','userinfo.token.claim'),('749e416f-6cd7-41ea-9438-7577677b6d57','true','access.token.claim'),('749e416f-6cd7-41ea-9438-7577677b6d57','website','claim.name'),('749e416f-6cd7-41ea-9438-7577677b6d57','true','id.token.claim'),('749e416f-6cd7-41ea-9438-7577677b6d57','String','jsonType.label'),('749e416f-6cd7-41ea-9438-7577677b6d57','website','user.attribute'),('749e416f-6cd7-41ea-9438-7577677b6d57','true','userinfo.token.claim'),('7b367a81-5b97-475d-a67a-7170ed7f974a','true','access.token.claim'),('7b367a81-5b97-475d-a67a-7170ed7f974a','family_name','claim.name'),('7b367a81-5b97-475d-a67a-7170ed7f974a','true','id.token.claim'),('7b367a81-5b97-475d-a67a-7170ed7f974a','String','jsonType.label'),('7b367a81-5b97-475d-a67a-7170ed7f974a','lastName','user.attribute'),('7b367a81-5b97-475d-a67a-7170ed7f974a','true','userinfo.token.claim'),('7d03590c-9841-47bf-9235-2f8db49512b3','true','access.token.claim'),('7d03590c-9841-47bf-9235-2f8db49512b3','locale','claim.name'),('7d03590c-9841-47bf-9235-2f8db49512b3','true','id.token.claim'),('7d03590c-9841-47bf-9235-2f8db49512b3','String','jsonType.label'),('7d03590c-9841-47bf-9235-2f8db49512b3','locale','user.attribute'),('7d03590c-9841-47bf-9235-2f8db49512b3','true','userinfo.token.claim'),('8df6a7e5-30f5-47d5-85c6-1facfc7a4e6f','true','access.token.claim'),('8df6a7e5-30f5-47d5-85c6-1facfc7a4e6f','email_verified','claim.name'),('8df6a7e5-30f5-47d5-85c6-1facfc7a4e6f','true','id.token.claim'),('8df6a7e5-30f5-47d5-85c6-1facfc7a4e6f','boolean','jsonType.label'),('8df6a7e5-30f5-47d5-85c6-1facfc7a4e6f','emailVerified','user.attribute'),('8df6a7e5-30f5-47d5-85c6-1facfc7a4e6f','true','userinfo.token.claim'),('8e48e8cd-e160-436e-a2d8-3e875bb067cc','true','access.token.claim'),('8e48e8cd-e160-436e-a2d8-3e875bb067cc','phone_number','claim.name'),('8e48e8cd-e160-436e-a2d8-3e875bb067cc','true','id.token.claim'),('8e48e8cd-e160-436e-a2d8-3e875bb067cc','String','jsonType.label'),('8e48e8cd-e160-436e-a2d8-3e875bb067cc','phoneNumber','user.attribute'),('8e48e8cd-e160-436e-a2d8-3e875bb067cc','true','userinfo.token.claim'),('8fdf3451-8324-4e1c-9ebe-b77223fe4a5c','true','access.token.claim'),('8fdf3451-8324-4e1c-9ebe-b77223fe4a5c','true','id.token.claim'),('8fdf3451-8324-4e1c-9ebe-b77223fe4a5c','true','userinfo.token.claim'),('914a788d-69ed-4bc4-a285-8012b1a26b40','true','access.token.claim'),('914a788d-69ed-4bc4-a285-8012b1a26b40','phone_number','claim.name'),('914a788d-69ed-4bc4-a285-8012b1a26b40','true','id.token.claim'),('914a788d-69ed-4bc4-a285-8012b1a26b40','String','jsonType.label'),('914a788d-69ed-4bc4-a285-8012b1a26b40','phoneNumber','user.attribute'),('914a788d-69ed-4bc4-a285-8012b1a26b40','true','userinfo.token.claim'),('91adccdf-fa07-4ca7-9fd5-a90ddbd42254','Role','attribute.name'),('91adccdf-fa07-4ca7-9fd5-a90ddbd42254','Basic','attribute.nameformat'),('91adccdf-fa07-4ca7-9fd5-a90ddbd42254','false','single'),('92e2492c-4c18-4a4b-bfd3-4f29578503b8','true','access.token.claim'),('92e2492c-4c18-4a4b-bfd3-4f29578503b8','profile','claim.name'),('92e2492c-4c18-4a4b-bfd3-4f29578503b8','true','id.token.claim'),('92e2492c-4c18-4a4b-bfd3-4f29578503b8','String','jsonType.label'),('92e2492c-4c18-4a4b-bfd3-4f29578503b8','profile','user.attribute'),('92e2492c-4c18-4a4b-bfd3-4f29578503b8','true','userinfo.token.claim'),('979c85b1-8589-408e-b854-644e85952cd0','true','access.token.claim'),('979c85b1-8589-408e-b854-644e85952cd0','picture','claim.name'),('979c85b1-8589-408e-b854-644e85952cd0','true','id.token.claim'),('979c85b1-8589-408e-b854-644e85952cd0','String','jsonType.label'),('979c85b1-8589-408e-b854-644e85952cd0','picture','user.attribute'),('979c85b1-8589-408e-b854-644e85952cd0','true','userinfo.token.claim'),('9acdd0d3-c7d7-4b55-9d24-a790feb69835','true','access.token.claim'),('9acdd0d3-c7d7-4b55-9d24-a790feb69835','resource_access.${client_id}.roles','claim.name'),('9acdd0d3-c7d7-4b55-9d24-a790feb69835','String','jsonType.label'),('9acdd0d3-c7d7-4b55-9d24-a790feb69835','true','multivalued'),('9acdd0d3-c7d7-4b55-9d24-a790feb69835','foo','user.attribute'),('a83889d6-ca6b-4fa9-b6f9-4588bccca5fd','true','access.token.claim'),('a83889d6-ca6b-4fa9-b6f9-4588bccca5fd','family_name','claim.name'),('a83889d6-ca6b-4fa9-b6f9-4588bccca5fd','true','id.token.claim'),('a83889d6-ca6b-4fa9-b6f9-4588bccca5fd','String','jsonType.label'),('a83889d6-ca6b-4fa9-b6f9-4588bccca5fd','lastName','user.attribute'),('a83889d6-ca6b-4fa9-b6f9-4588bccca5fd','true','userinfo.token.claim'),('aee49b02-4a57-4d47-be83-074dd79d17e9','true','access.token.claim'),('aee49b02-4a57-4d47-be83-074dd79d17e9','zoneinfo','claim.name'),('aee49b02-4a57-4d47-be83-074dd79d17e9','true','id.token.claim'),('aee49b02-4a57-4d47-be83-074dd79d17e9','String','jsonType.label'),('aee49b02-4a57-4d47-be83-074dd79d17e9','zoneinfo','user.attribute'),('aee49b02-4a57-4d47-be83-074dd79d17e9','true','userinfo.token.claim'),('b1b19c02-a659-4928-a0d8-3c309b8ec3a9','true','access.token.claim'),('b1b19c02-a659-4928-a0d8-3c309b8ec3a9','phone_number_verified','claim.name'),('b1b19c02-a659-4928-a0d8-3c309b8ec3a9','true','id.token.claim'),('b1b19c02-a659-4928-a0d8-3c309b8ec3a9','boolean','jsonType.label'),('b1b19c02-a659-4928-a0d8-3c309b8ec3a9','phoneNumberVerified','user.attribute'),('b1b19c02-a659-4928-a0d8-3c309b8ec3a9','true','userinfo.token.claim'),('b24e513a-7443-4daf-888f-39a3891ea1be','true','access.token.claim'),('b24e513a-7443-4daf-888f-39a3891ea1be','email','claim.name'),('b24e513a-7443-4daf-888f-39a3891ea1be','true','id.token.claim'),('b24e513a-7443-4daf-888f-39a3891ea1be','String','jsonType.label'),('b24e513a-7443-4daf-888f-39a3891ea1be','email','user.attribute'),('b24e513a-7443-4daf-888f-39a3891ea1be','true','userinfo.token.claim'),('b42e5e13-233b-498e-8685-4e4a38dc13c9','true','access.token.claim'),('b42e5e13-233b-498e-8685-4e4a38dc13c9','birthdate','claim.name'),('b42e5e13-233b-498e-8685-4e4a38dc13c9','true','id.token.claim'),('b42e5e13-233b-498e-8685-4e4a38dc13c9','String','jsonType.label'),('b42e5e13-233b-498e-8685-4e4a38dc13c9','birthdate','user.attribute'),('b42e5e13-233b-498e-8685-4e4a38dc13c9','true','userinfo.token.claim'),('b70c822d-9dd8-4426-a01c-68db79343151','true','access.token.claim'),('b70c822d-9dd8-4426-a01c-68db79343151','true','id.token.claim'),('b70c822d-9dd8-4426-a01c-68db79343151','country','user.attribute.country'),('b70c822d-9dd8-4426-a01c-68db79343151','formatted','user.attribute.formatted'),('b70c822d-9dd8-4426-a01c-68db79343151','locality','user.attribute.locality'),('b70c822d-9dd8-4426-a01c-68db79343151','postal_code','user.attribute.postal_code'),('b70c822d-9dd8-4426-a01c-68db79343151','region','user.attribute.region'),('b70c822d-9dd8-4426-a01c-68db79343151','street','user.attribute.street'),('b70c822d-9dd8-4426-a01c-68db79343151','true','userinfo.token.claim'),('b819e905-bc68-4389-95d2-c426f0bf8b2f','true','access.token.claim'),('b819e905-bc68-4389-95d2-c426f0bf8b2f','preferred_username','claim.name'),('b819e905-bc68-4389-95d2-c426f0bf8b2f','true','id.token.claim'),('b819e905-bc68-4389-95d2-c426f0bf8b2f','String','jsonType.label'),('b819e905-bc68-4389-95d2-c426f0bf8b2f','username','user.attribute'),('b819e905-bc68-4389-95d2-c426f0bf8b2f','true','userinfo.token.claim'),('bae8388e-e29e-47b0-9df7-403530a175cb','true','access.token.claim'),('bae8388e-e29e-47b0-9df7-403530a175cb','gender','claim.name'),('bae8388e-e29e-47b0-9df7-403530a175cb','true','id.token.claim'),('bae8388e-e29e-47b0-9df7-403530a175cb','String','jsonType.label'),('bae8388e-e29e-47b0-9df7-403530a175cb','gender','user.attribute'),('bae8388e-e29e-47b0-9df7-403530a175cb','true','userinfo.token.claim'),('bc2d71b2-51ac-47b6-8dc4-cc0e9e36f53c','true','access.token.claim'),('bc2d71b2-51ac-47b6-8dc4-cc0e9e36f53c','given_name','claim.name'),('bc2d71b2-51ac-47b6-8dc4-cc0e9e36f53c','true','id.token.claim'),('bc2d71b2-51ac-47b6-8dc4-cc0e9e36f53c','String','jsonType.label'),('bc2d71b2-51ac-47b6-8dc4-cc0e9e36f53c','firstName','user.attribute'),('bc2d71b2-51ac-47b6-8dc4-cc0e9e36f53c','true','userinfo.token.claim'),('cbe29f3b-4ae3-4133-82a8-925756d38f6e','true','access.token.claim'),('cbe29f3b-4ae3-4133-82a8-925756d38f6e','realm_access.roles','claim.name'),('cbe29f3b-4ae3-4133-82a8-925756d38f6e','String','jsonType.label'),('cbe29f3b-4ae3-4133-82a8-925756d38f6e','true','multivalued'),('cbe29f3b-4ae3-4133-82a8-925756d38f6e','foo','user.attribute'),('d469e6ae-4529-4780-ad3c-5766c6379e32','true','access.token.claim'),('d469e6ae-4529-4780-ad3c-5766c6379e32','true','id.token.claim'),('d469e6ae-4529-4780-ad3c-5766c6379e32','true','userinfo.token.claim'),('d6afedd1-f7ff-4d49-95c3-b90db725d37f','true','access.token.claim'),('d6afedd1-f7ff-4d49-95c3-b90db725d37f','locale','claim.name'),('d6afedd1-f7ff-4d49-95c3-b90db725d37f','true','id.token.claim'),('d6afedd1-f7ff-4d49-95c3-b90db725d37f','String','jsonType.label'),('d6afedd1-f7ff-4d49-95c3-b90db725d37f','locale','user.attribute'),('d6afedd1-f7ff-4d49-95c3-b90db725d37f','true','userinfo.token.claim'),('e57f6647-383e-4fdd-ba97-e2daccafb9fd','true','access.token.claim'),('e57f6647-383e-4fdd-ba97-e2daccafb9fd','given_name','claim.name'),('e57f6647-383e-4fdd-ba97-e2daccafb9fd','true','id.token.claim'),('e57f6647-383e-4fdd-ba97-e2daccafb9fd','String','jsonType.label'),('e57f6647-383e-4fdd-ba97-e2daccafb9fd','firstName','user.attribute'),('e57f6647-383e-4fdd-ba97-e2daccafb9fd','true','userinfo.token.claim'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','true','access.token.claim'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','groups','claim.name'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','true','id.token.claim'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','String','jsonType.label'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','true','multivalued'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','foo','user.attribute'),('e5b8d9cc-aae8-4928-b411-db9eb33b077c','true','userinfo.token.claim'),('e89f630d-8840-40f2-b1a7-6d54781be923','true','access.token.claim'),('e89f630d-8840-40f2-b1a7-6d54781be923','zoneinfo','claim.name'),('e89f630d-8840-40f2-b1a7-6d54781be923','true','id.token.claim'),('e89f630d-8840-40f2-b1a7-6d54781be923','String','jsonType.label'),('e89f630d-8840-40f2-b1a7-6d54781be923','zoneinfo','user.attribute'),('e89f630d-8840-40f2-b1a7-6d54781be923','true','userinfo.token.claim'),('ea329b2c-4215-42c8-9f15-6761eca794c1','true','access.token.claim'),('ea329b2c-4215-42c8-9f15-6761eca794c1','birthdate','claim.name'),('ea329b2c-4215-42c8-9f15-6761eca794c1','true','id.token.claim'),('ea329b2c-4215-42c8-9f15-6761eca794c1','String','jsonType.label'),('ea329b2c-4215-42c8-9f15-6761eca794c1','birthdate','user.attribute'),('ea329b2c-4215-42c8-9f15-6761eca794c1','true','userinfo.token.claim'),('ec750a9d-d2ce-4241-b618-7a446ffe43b4','true','access.token.claim'),('ec750a9d-d2ce-4241-b618-7a446ffe43b4','email_verified','claim.name'),('ec750a9d-d2ce-4241-b618-7a446ffe43b4','true','id.token.claim'),('ec750a9d-d2ce-4241-b618-7a446ffe43b4','boolean','jsonType.label'),('ec750a9d-d2ce-4241-b618-7a446ffe43b4','emailVerified','user.attribute'),('ec750a9d-d2ce-4241-b618-7a446ffe43b4','true','userinfo.token.claim'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','true','access.token.claim'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','true','id.token.claim'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','country','user.attribute.country'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','formatted','user.attribute.formatted'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','locality','user.attribute.locality'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','postal_code','user.attribute.postal_code'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','region','user.attribute.region'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','street','user.attribute.street'),('f05e7252-74f4-4b96-bf07-7d8a5feb713b','true','userinfo.token.claim'),('f404ba8e-1faa-4c39-a6dc-7fc70cb46fbf','true','access.token.claim'),('f404ba8e-1faa-4c39-a6dc-7fc70cb46fbf','resource_access.${client_id}.roles','claim.name'),('f404ba8e-1faa-4c39-a6dc-7fc70cb46fbf','String','jsonType.label'),('f404ba8e-1faa-4c39-a6dc-7fc70cb46fbf','true','multivalued'),('f404ba8e-1faa-4c39-a6dc-7fc70cb46fbf','foo','user.attribute'),('f7b5ddb4-4a96-46b6-970e-7e63f2f87f95','true','access.token.claim'),('f7b5ddb4-4a96-46b6-970e-7e63f2f87f95','groups','claim.name'),('f7b5ddb4-4a96-46b6-970e-7e63f2f87f95','true','id.token.claim'),('f7b5ddb4-4a96-46b6-970e-7e63f2f87f95','String','jsonType.label'),('f7b5ddb4-4a96-46b6-970e-7e63f2f87f95','true','multivalued'),('f7b5ddb4-4a96-46b6-970e-7e63f2f87f95','foo','user.attribute'),('fd8f68e6-79dd-4aa9-a21e-a458a7e98527','true','access.token.claim'),('fd8f68e6-79dd-4aa9-a21e-a458a7e98527','updated_at','claim.name'),('fd8f68e6-79dd-4aa9-a21e-a458a7e98527','true','id.token.claim'),('fd8f68e6-79dd-4aa9-a21e-a458a7e98527','String','jsonType.label'),('fd8f68e6-79dd-4aa9-a21e-a458a7e98527','updatedAt','user.attribute'),('fd8f68e6-79dd-4aa9-a21e-a458a7e98527','true','userinfo.token.claim'),('fee3c99c-cdad-49eb-8072-ae080cf395d7','true','access.token.claim'),('fee3c99c-cdad-49eb-8072-ae080cf395d7','updated_at','claim.name'),('fee3c99c-cdad-49eb-8072-ae080cf395d7','true','id.token.claim'),('fee3c99c-cdad-49eb-8072-ae080cf395d7','String','jsonType.label'),('fee3c99c-cdad-49eb-8072-ae080cf395d7','updatedAt','user.attribute'),('fee3c99c-cdad-49eb-8072-ae080cf395d7','true','userinfo.token.claim');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM`
--

DROP TABLE IF EXISTS `REALM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM` (
  `ID` varchar(36) NOT NULL,
  `ACCESS_CODE_LIFESPAN` int(11) DEFAULT NULL,
  `USER_ACTION_LIFESPAN` int(11) DEFAULT NULL,
  `ACCESS_TOKEN_LIFESPAN` int(11) DEFAULT NULL,
  `ACCOUNT_THEME` varchar(255) DEFAULT NULL,
  `ADMIN_THEME` varchar(255) DEFAULT NULL,
  `EMAIL_THEME` varchar(255) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_EXPIRATION` bigint(20) DEFAULT NULL,
  `LOGIN_THEME` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) DEFAULT NULL,
  `PASSWORD_POLICY` text DEFAULT NULL,
  `REGISTRATION_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `RESET_PASSWORD_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `SOCIAL` bit(1) NOT NULL DEFAULT b'0',
  `SSL_REQUIRED` varchar(255) DEFAULT NULL,
  `SSO_IDLE_TIMEOUT` int(11) DEFAULT NULL,
  `SSO_MAX_LIFESPAN` int(11) DEFAULT NULL,
  `UPDATE_PROFILE_ON_SOC_LOGIN` bit(1) NOT NULL DEFAULT b'0',
  `VERIFY_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `MASTER_ADMIN_CLIENT` varchar(36) DEFAULT NULL,
  `LOGIN_LIFESPAN` int(11) DEFAULT NULL,
  `INTERNATIONALIZATION_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_LOCALE` varchar(255) DEFAULT NULL,
  `REG_EMAIL_AS_USERNAME` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_DETAILS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EDIT_USERNAME_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `OTP_POLICY_COUNTER` int(11) DEFAULT 0,
  `OTP_POLICY_WINDOW` int(11) DEFAULT 1,
  `OTP_POLICY_PERIOD` int(11) DEFAULT 30,
  `OTP_POLICY_DIGITS` int(11) DEFAULT 6,
  `OTP_POLICY_ALG` varchar(36) DEFAULT 'HmacSHA1',
  `OTP_POLICY_TYPE` varchar(36) DEFAULT 'totp',
  `BROWSER_FLOW` varchar(36) DEFAULT NULL,
  `REGISTRATION_FLOW` varchar(36) DEFAULT NULL,
  `DIRECT_GRANT_FLOW` varchar(36) DEFAULT NULL,
  `RESET_CREDENTIALS_FLOW` varchar(36) DEFAULT NULL,
  `CLIENT_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `OFFLINE_SESSION_IDLE_TIMEOUT` int(11) DEFAULT 0,
  `REVOKE_REFRESH_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `ACCESS_TOKEN_LIFE_IMPLICIT` int(11) DEFAULT 0,
  `LOGIN_WITH_EMAIL_ALLOWED` bit(1) NOT NULL DEFAULT b'1',
  `DUPLICATE_EMAILS_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `DOCKER_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `REFRESH_TOKEN_MAX_REUSE` int(11) DEFAULT 0,
  `ALLOW_USER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `SSO_MAX_LIFESPAN_REMEMBER_ME` int(11) NOT NULL,
  `SSO_IDLE_TIMEOUT_REMEMBER_ME` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_ORVSDMLA56612EAEFIQ6WL5OI` (`NAME`),
  KEY `IDX_REALM_MASTER_ADM_CLI` (`MASTER_ADMIN_CLIENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM`
--

LOCK TABLES `REALM` WRITE;
/*!40000 ALTER TABLE `REALM` DISABLE KEYS */;
INSERT INTO `REALM` VALUES ('Aulos',60,300,300,NULL,NULL,NULL,'','\0',0,NULL,'Aulos',0,NULL,'\0','','\0','\0','NONE',1800,36000,'\0','\0','53a0df34-e058-4d8e-9f3f-ea948ba64bdc',1800,'\0',NULL,'\0','\0','\0','\0',0,1,30,6,'HmacSHA1','totp','4e3345de-4d06-4f68-a4e5-c5cb3d9f0585','13c56672-2592-4517-8d13-4baafcfff16a','cf91d979-e006-4689-8a8a-c58dd35e9c8c','1416d4ab-56fa-4bfa-8be2-f684fc9430eb','43dc8a85-8a7a-4a04-aa98-a45ea85ca7fc',2592000,'\0',900,'\0','\0','131bf459-d343-4679-b42b-7ebe4279b6e3',0,'\0',0,0),('master',60,300,60,NULL,NULL,NULL,'','\0',0,NULL,'master',0,NULL,'\0','\0','\0','\0','EXTERNAL',1800,36000,'\0','\0','760ab7aa-727c-4faa-81d6-e250c7c6ace6',1800,'\0',NULL,'\0','\0','\0','\0',0,1,30,6,'HmacSHA1','totp','ad63985e-0949-4fd7-9ea7-7e01343e821a','d82df27e-a873-426d-a12f-251a7e88e885','df487cbf-fde4-4b9f-99c0-e49cb96bcf02','89dbfd7a-e12f-4096-8f67-9305270f6154','a782060c-af25-43d0-b88f-96883acbd7ae',2592000,'\0',900,'','\0','11ed5b43-a0ff-48a3-a82a-6618a9890f62',0,'\0',0,0);
/*!40000 ALTER TABLE `REALM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ATTRIBUTE`
--

DROP TABLE IF EXISTS `REALM_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`NAME`,`REALM_ID`),
  KEY `IDX_REALM_ATTR_REALM` (`REALM_ID`),
  CONSTRAINT `FK_8SHXD6L3E9ATQUKACXGPFFPTW` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ATTRIBUTE`
--

LOCK TABLES `REALM_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `REALM_ATTRIBUTE` VALUES ('actionTokenGeneratedByAdminLifespan','43200','Aulos'),('actionTokenGeneratedByUserLifespan','300','Aulos'),('bruteForceProtected','true','Aulos'),('bruteForceProtected','false','master'),('clientOfflineSessionIdleTimeout','0','Aulos'),('clientOfflineSessionMaxLifespan','0','Aulos'),('clientSessionIdleTimeout','0','Aulos'),('clientSessionMaxLifespan','0','Aulos'),('displayName','Aulos','Aulos'),('displayName','Keycloak','master'),('displayNameHtml','<div class=\"kc-logo-text\"><span>Keycloak</span></div>','master'),('failureFactor','30','Aulos'),('failureFactor','30','master'),('frontendUrl','','Aulos'),('maxDeltaTimeSeconds','43200','Aulos'),('maxDeltaTimeSeconds','43200','master'),('maxFailureWaitSeconds','900','Aulos'),('maxFailureWaitSeconds','900','master'),('minimumQuickLoginWaitSeconds','60','Aulos'),('minimumQuickLoginWaitSeconds','60','master'),('offlineSessionMaxLifespan','5184000','Aulos'),('offlineSessionMaxLifespan','5184000','master'),('offlineSessionMaxLifespanEnabled','false','Aulos'),('offlineSessionMaxLifespanEnabled','false','master'),('permanentLockout','false','Aulos'),('permanentLockout','false','master'),('quickLoginCheckMilliSeconds','1000','Aulos'),('quickLoginCheckMilliSeconds','1000','master'),('waitIncrementSeconds','60','Aulos'),('waitIncrementSeconds','60','master'),('webAuthnPolicyAttestationConveyancePreference','not specified','Aulos'),('webAuthnPolicyAttestationConveyancePreferencePasswordless','not specified','Aulos'),('webAuthnPolicyAuthenticatorAttachment','not specified','Aulos'),('webAuthnPolicyAuthenticatorAttachmentPasswordless','not specified','Aulos'),('webAuthnPolicyAvoidSameAuthenticatorRegister','false','Aulos'),('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless','false','Aulos'),('webAuthnPolicyCreateTimeout','0','Aulos'),('webAuthnPolicyCreateTimeoutPasswordless','0','Aulos'),('webAuthnPolicyRequireResidentKey','not specified','Aulos'),('webAuthnPolicyRequireResidentKeyPasswordless','not specified','Aulos'),('webAuthnPolicyRpEntityName','keycloak','Aulos'),('webAuthnPolicyRpEntityNamePasswordless','keycloak','Aulos'),('webAuthnPolicyRpId','','Aulos'),('webAuthnPolicyRpIdPasswordless','','Aulos'),('webAuthnPolicySignatureAlgorithms','ES256','Aulos'),('webAuthnPolicySignatureAlgorithmsPasswordless','ES256','Aulos'),('webAuthnPolicyUserVerificationRequirement','not specified','Aulos'),('webAuthnPolicyUserVerificationRequirementPasswordless','not specified','Aulos'),('_browser_header.contentSecurityPolicy','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';','Aulos'),('_browser_header.contentSecurityPolicy','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';','master'),('_browser_header.contentSecurityPolicyReportOnly','','Aulos'),('_browser_header.contentSecurityPolicyReportOnly','','master'),('_browser_header.strictTransportSecurity','max-age=31536000; includeSubDomains','Aulos'),('_browser_header.strictTransportSecurity','max-age=31536000; includeSubDomains','master'),('_browser_header.xContentTypeOptions','nosniff','Aulos'),('_browser_header.xContentTypeOptions','nosniff','master'),('_browser_header.xFrameOptions','SAMEORIGIN','Aulos'),('_browser_header.xFrameOptions','SAMEORIGIN','master'),('_browser_header.xRobotsTag','none','Aulos'),('_browser_header.xRobotsTag','none','master'),('_browser_header.xXSSProtection','1; mode=block','Aulos'),('_browser_header.xXSSProtection','1; mode=block','master');
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_DEFAULT_GROUPS`
--

DROP TABLE IF EXISTS `REALM_DEFAULT_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_DEFAULT_GROUPS` (
  `REALM_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`GROUP_ID`),
  UNIQUE KEY `CON_GROUP_ID_DEF_GROUPS` (`GROUP_ID`),
  KEY `IDX_REALM_DEF_GRP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_DEF_GROUPS_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_DEFAULT_GROUPS`
--

LOCK TABLES `REALM_DEFAULT_GROUPS` WRITE;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_DEFAULT_ROLES`
--

DROP TABLE IF EXISTS `REALM_DEFAULT_ROLES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_DEFAULT_ROLES` (
  `REALM_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`ROLE_ID`),
  UNIQUE KEY `UK_H4WPD7W4HSOOLNI3H0SW7BTJE` (`ROLE_ID`),
  KEY `IDX_REALM_DEF_ROLES_REALM` (`REALM_ID`),
  CONSTRAINT `FK_EVUDB1PPW84OXFAX2DRS03ICC` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_DEFAULT_ROLES`
--

LOCK TABLES `REALM_DEFAULT_ROLES` WRITE;
/*!40000 ALTER TABLE `REALM_DEFAULT_ROLES` DISABLE KEYS */;
INSERT INTO `REALM_DEFAULT_ROLES` VALUES ('Aulos','89b09cba-22d1-47e6-af80-369fac2d354d'),('Aulos','8f20e717-6f37-4154-bac7-ad146cb77ad5'),('Aulos','ac517e4b-210f-43dd-8156-e71a76f1e7b9'),('master','e939dcc6-31af-4d71-bcb7-aa609ddf123c'),('master','f0af10fb-6a7b-48b8-9425-3346562af420');
/*!40000 ALTER TABLE `REALM_DEFAULT_ROLES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ENABLED_EVENT_TYPES`
--

DROP TABLE IF EXISTS `REALM_ENABLED_EVENT_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_ENABLED_EVENT_TYPES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_TYPES_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NWEDRF5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ENABLED_EVENT_TYPES`
--

LOCK TABLES `REALM_ENABLED_EVENT_TYPES` WRITE;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_EVENTS_LISTENERS`
--

DROP TABLE IF EXISTS `REALM_EVENTS_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_EVENTS_LISTENERS` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_LIST_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NXEV9F5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_EVENTS_LISTENERS`
--

LOCK TABLES `REALM_EVENTS_LISTENERS` WRITE;
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` DISABLE KEYS */;
INSERT INTO `REALM_EVENTS_LISTENERS` VALUES ('Aulos','jboss-logging'),('master','jboss-logging');
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_LOCALIZATIONS`
--

DROP TABLE IF EXISTS `REALM_LOCALIZATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_LOCALIZATIONS` (
  `REALM_ID` varchar(255) NOT NULL,
  `LOCALE` varchar(255) NOT NULL,
  `TEXTS` longtext NOT NULL,
  PRIMARY KEY (`REALM_ID`,`LOCALE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_LOCALIZATIONS`
--

LOCK TABLES `REALM_LOCALIZATIONS` WRITE;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_REQUIRED_CREDENTIAL`
--

DROP TABLE IF EXISTS `REALM_REQUIRED_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_REQUIRED_CREDENTIAL` (
  `TYPE` varchar(255) NOT NULL,
  `FORM_LABEL` varchar(255) DEFAULT NULL,
  `INPUT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`TYPE`),
  CONSTRAINT `FK_5HG65LYBEVAVKQFKI3KPONH9V` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_REQUIRED_CREDENTIAL`
--

LOCK TABLES `REALM_REQUIRED_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` DISABLE KEYS */;
INSERT INTO `REALM_REQUIRED_CREDENTIAL` VALUES ('password','password','','','Aulos'),('password','password','','','master');
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SMTP_CONFIG`
--

DROP TABLE IF EXISTS `REALM_SMTP_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_SMTP_CONFIG` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`NAME`),
  CONSTRAINT `FK_70EJ8XDXGXD0B9HH6180IRR0O` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SMTP_CONFIG`
--

LOCK TABLES `REALM_SMTP_CONFIG` WRITE;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SUPPORTED_LOCALES`
--

DROP TABLE IF EXISTS `REALM_SUPPORTED_LOCALES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALM_SUPPORTED_LOCALES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_SUPP_LOCAL_REALM` (`REALM_ID`),
  CONSTRAINT `FK_SUPPORTED_LOCALES_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SUPPORTED_LOCALES`
--

LOCK TABLES `REALM_SUPPORTED_LOCALES` WRITE;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REDIRECT_URIS`
--

DROP TABLE IF EXISTS `REDIRECT_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REDIRECT_URIS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_REDIR_URI_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_1BURS8PB4OUJ97H5WUPPAHV9F` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REDIRECT_URIS`
--

LOCK TABLES `REDIRECT_URIS` WRITE;
/*!40000 ALTER TABLE `REDIRECT_URIS` DISABLE KEYS */;
INSERT INTO `REDIRECT_URIS` VALUES ('2162596c-1963-4d57-bd5c-ffaef0269e14','/realms/Aulos/account/*'),('4f2353c0-3a72-45f0-a6fe-2b0de3b2d19c','/realms/master/account/*'),('50f4c638-c959-40eb-a0be-254da5609b9a','/realms/Aulos/account/*'),('96094ef3-d44c-49ab-bbcf-08393ceb9a73','/admin/Aulos/console/*'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','/admin/master/console/*'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','http://localhost:4200/*'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','http://localhost/*'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','http://localhost:8000/*'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','/realms/master/account/*');
/*!40000 ALTER TABLE `REDIRECT_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_CONFIG`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REQUIRED_ACTION_CONFIG` (
  `REQUIRED_ACTION_ID` varchar(36) NOT NULL,
  `VALUE` longtext DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REQUIRED_ACTION_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_CONFIG`
--

LOCK TABLES `REQUIRED_ACTION_CONFIG` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_PROVIDER`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REQUIRED_ACTION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_ACTION` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_REQ_ACT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_REQ_ACT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_PROVIDER`
--

LOCK TABLES `REQUIRED_ACTION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` DISABLE KEYS */;
INSERT INTO `REQUIRED_ACTION_PROVIDER` VALUES ('19f58263-0bda-4daa-bc2f-140fe21da9cb','CONFIGURE_TOTP','Configure OTP','master','','\0','CONFIGURE_TOTP',10),('1dd194f5-27eb-4525-b586-2ab8007abeac','VERIFY_EMAIL','Verify Email','Aulos','','\0','VERIFY_EMAIL',50),('33d27fec-14e6-4fba-85b4-e19dca1806dd','delete_account','Delete Account','master','\0','\0','delete_account',60),('4a02ebe0-9170-43ad-b8e1-e6bcfe272dec','VERIFY_EMAIL','Verify Email','master','','\0','VERIFY_EMAIL',50),('4ed831c1-8657-4011-be6c-890bdbafefba','UPDATE_PASSWORD','Update Password','master','','\0','UPDATE_PASSWORD',30),('54f7c9c3-10f7-4cb9-8b55-32ec82031dd8','update_user_locale','Update User Locale','master','','\0','update_user_locale',1000),('675d7bdb-9905-4c04-8e65-2b5e2a92f651','terms_and_conditions','Terms and Conditions','Aulos','\0','\0','terms_and_conditions',20),('6a465ee4-b41a-4bcc-9ddf-a5ab1bc83738','update_user_locale','Update User Locale','Aulos','','\0','update_user_locale',1000),('82186087-2c4f-4626-a20e-273099503f7a','UPDATE_PROFILE','Update Profile','master','','\0','UPDATE_PROFILE',40),('840f7266-2da0-48e2-a4ce-036d7fc8d58c','terms_and_conditions','Terms and Conditions','master','\0','\0','terms_and_conditions',20),('a77aac19-7646-42a0-8524-f8d29c04fb8f','UPDATE_PROFILE','Update Profile','Aulos','','\0','UPDATE_PROFILE',40),('a8d12d50-e37f-48ed-8448-12ff4ad49c9e','delete_account','Delete Account','Aulos','\0','\0','delete_account',60),('d467f377-0f06-45d9-a838-93c4c6293f71','CONFIGURE_TOTP','Configure OTP','Aulos','','\0','CONFIGURE_TOTP',10),('da506733-5860-4ff6-911e-9878dc09d006','UPDATE_PASSWORD','Update Password','Aulos','','\0','UPDATE_PASSWORD',30);
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `RESOURCE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_5HRM2VLF9QL5FU022KQEPOVBR` (`RESOURCE_ID`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU022KQEPOVBR` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_ATTRIBUTE`
--

LOCK TABLES `RESOURCE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_POLICY` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`POLICY_ID`),
  KEY `IDX_RES_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRPOS53XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPP213XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_POLICY`
--

LOCK TABLES `RESOURCE_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SCOPE` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`SCOPE_ID`),
  KEY `IDX_RES_SCOPE_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_FRSRPOS13XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPS213XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SCOPE`
--

LOCK TABLES `RESOURCE_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER` (
  `ID` varchar(36) NOT NULL,
  `ALLOW_RS_REMOTE_MGMT` bit(1) NOT NULL DEFAULT b'0',
  `POLICY_ENFORCE_MODE` varchar(15) NOT NULL,
  `DECISION_STRATEGY` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER`
--

LOCK TABLES `RESOURCE_SERVER` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_PERM_TICKET`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_PERM_TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_PERM_TICKET` (
  `ID` varchar(36) NOT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `REQUESTER` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint(20) NOT NULL,
  `GRANTED_TIMESTAMP` bigint(20) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5PMT` (`OWNER`,`REQUESTER`,`RESOURCE_SERVER_ID`,`RESOURCE_ID`,`SCOPE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG82SSPMT` (`RESOURCE_SERVER_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG83SSPMT` (`RESOURCE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG84SSPMT` (`SCOPE_ID`),
  KEY `FK_FRSRPO2128CX4WNKOG82SSRFY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSPMT` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG83SSPMT` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG84SSPMT` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`),
  CONSTRAINT `FK_FRSRPO2128CX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_PERM_TICKET`
--

LOCK TABLES `RESOURCE_SERVER_PERM_TICKET` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_POLICY` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `TYPE` varchar(255) NOT NULL,
  `DECISION_STRATEGY` varchar(20) DEFAULT NULL,
  `LOGIC` varchar(20) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRPT700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SERV_POL_RES_SERV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRPO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_POLICY`
--

LOCK TABLES `RESOURCE_SERVER_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_RESOURCE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_RESOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_RESOURCE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5HA6` (`NAME`,`OWNER`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_RES_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_RESOURCE`
--

LOCK TABLES `RESOURCE_SERVER_RESOURCE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_SERVER_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRST700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_SCOPE_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRSO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_SCOPE`
--

LOCK TABLES `RESOURCE_SERVER_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_URIS`
--

DROP TABLE IF EXISTS `RESOURCE_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESOURCE_URIS` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`VALUE`),
  CONSTRAINT `FK_RESOURCE_SERVER_URIS` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_URIS`
--

LOCK TABLES `RESOURCE_URIS` WRITE;
/*!40000 ALTER TABLE `RESOURCE_URIS` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ROLE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `ROLE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ROLE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ROLE_ATTRIBUTE` (`ROLE_ID`),
  CONSTRAINT `FK_ROLE_ATTRIBUTE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLE_ATTRIBUTE`
--

LOCK TABLES `ROLE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_MAPPING`
--

DROP TABLE IF EXISTS `SCOPE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCOPE_MAPPING` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`ROLE_ID`),
  KEY `IDX_SCOPE_MAPPING_ROLE` (`ROLE_ID`),
  CONSTRAINT `FK_OUSE064PLMLR732LXJCN1Q5F1` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_MAPPING`
--

LOCK TABLES `SCOPE_MAPPING` WRITE;
/*!40000 ALTER TABLE `SCOPE_MAPPING` DISABLE KEYS */;
INSERT INTO `SCOPE_MAPPING` VALUES ('50f4c638-c959-40eb-a0be-254da5609b9a','5302e4c3-fd65-4ef4-9973-fb4ceae5ff00'),('fcc03cba-a47c-45c2-9f8b-94ee170077c1','6db32d76-4143-4d4c-824e-ceac9dd96e0a');
/*!40000 ALTER TABLE `SCOPE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_POLICY`
--

DROP TABLE IF EXISTS `SCOPE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCOPE_POLICY` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`POLICY_ID`),
  KEY `IDX_SCOPE_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRASP13XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPASS3XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_POLICY`
--

LOCK TABLES `SCOPE_POLICY` WRITE;
/*!40000 ALTER TABLE `SCOPE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `SCOPE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERNAME_LOGIN_FAILURE`
--

DROP TABLE IF EXISTS `USERNAME_LOGIN_FAILURE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERNAME_LOGIN_FAILURE` (
  `REALM_ID` varchar(36) NOT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8 NOT NULL,
  `FAILED_LOGIN_NOT_BEFORE` int(11) DEFAULT NULL,
  `LAST_FAILURE` bigint(20) DEFAULT NULL,
  `LAST_IP_FAILURE` varchar(255) DEFAULT NULL,
  `NUM_FAILURES` int(11) DEFAULT NULL,
  PRIMARY KEY (`REALM_ID`,`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERNAME_LOGIN_FAILURE`
--

LOCK TABLES `USERNAME_LOGIN_FAILURE` WRITE;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_ATTRIBUTE` (`USER_ID`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU043KQEPOVBR` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ATTRIBUTE`
--

LOCK TABLES `USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `USER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT`
--

DROP TABLE IF EXISTS `USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `CREATED_DATE` bigint(20) DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint(20) DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_JKUWUVD56ONTGSUHOGM8UEWRT` (`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`USER_ID`),
  KEY `IDX_USER_CONSENT` (`USER_ID`),
  CONSTRAINT `FK_GRNTCSNT_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT`
--

LOCK TABLES `USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `USER_CONSENT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_CONSENT_CLIENT_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`),
  KEY `IDX_USCONSENT_CLSCOPE` (`USER_CONSENT_ID`),
  CONSTRAINT `FK_GRNTCSNT_CLSC_USC` FOREIGN KEY (`USER_CONSENT_ID`) REFERENCES `USER_CONSENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT_CLIENT_SCOPE`
--

LOCK TABLES `USER_CONSENT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ENTITY`
--

DROP TABLE IF EXISTS `USER_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMAIL_CONSTRAINT` varchar(255) DEFAULT NULL,
  `EMAIL_VERIFIED` bit(1) NOT NULL DEFAULT b'0',
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FEDERATION_LINK` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `LAST_NAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint(20) DEFAULT NULL,
  `SERVICE_ACCOUNT_CLIENT_LINK` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_DYKN684SL8UP1CRFEI6ECKHD7` (`REALM_ID`,`EMAIL_CONSTRAINT`),
  UNIQUE KEY `UK_RU8TT6T700S9V50BU18WS5HA6` (`REALM_ID`,`USERNAME`),
  KEY `IDX_USER_EMAIL` (`EMAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ENTITY`
--

LOCK TABLES `USER_ENTITY` WRITE;
/*!40000 ALTER TABLE `USER_ENTITY` DISABLE KEYS */;
INSERT INTO `USER_ENTITY` VALUES ('0ea8c33e-b299-4af3-9f59-6068bd16e7eb',NULL,'5c017c74-28d9-478a-8014-16af4e16ed9c','\0','',NULL,'Giuliana','Upobaldi','Aulos','es_amministratore_2',1616507403996,NULL,0),('266cdefd-6754-4a6c-945f-558cae27e4eb',NULL,'a72fae71-13ed-445b-bafd-2616c0cf0db4','\0','',NULL,'Giovanna','Bianchi','Aulos','es_responsabile_2',1616507270724,NULL,0),('2eab712e-f2e3-4980-8e59-0c04e6034c88',NULL,'06a93e3e-1e9c-4947-a527-e8dd0fe6b59e','\0','',NULL,'Davide','Upoldi','Aulos','es_amministratore_1',1616507370340,NULL,0),('9c5e25be-93cf-4459-8bae-bc18fdb0f7d5',NULL,'246fa10e-4304-4d8b-b261-f68890834b13','\0','',NULL,'Piero','Mariani','Aulos','es_responsabile_1',1616507241009,NULL,0),('c74ef0bb-d1ed-4697-b018-98c3ede35288',NULL,'71c878f9-5a0e-46fd-a292-bc49825111f4','\0','',NULL,'Franco','Ghibellini','Aulos','es_supervisore_1',1616507299271,NULL,0),('e7ed1987-67cb-4ab9-957c-96a9d0558ba1',NULL,'4ef5d152-1515-412f-aa61-3a4c8bc02f39','\0','',NULL,'Gloria','Arabeschi','Aulos','es_supervisore_2',1616507331963,NULL,0),('f08891c8-3541-45d3-bc57-37cde9096b3d',NULL,'a60a3608-7dd3-4dc5-b00c-2c2c41c26e27','\0','',NULL,NULL,NULL,'master','admin',1615891100710,NULL,0);
/*!40000 ALTER TABLE `USER_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_CONFIG` (
  `USER_FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FK_T13HPU1J94R2EBPEKR39X5EU5` FOREIGN KEY (`USER_FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_CONFIG`
--

LOCK TABLES `USER_FEDERATION_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `FEDERATION_MAPPER_TYPE` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_MAP_FED_PRV` (`FEDERATION_PROVIDER_ID`),
  KEY `IDX_USR_FED_MAP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_FEDMAPPERPM_FEDPRV` FOREIGN KEY (`FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`),
  CONSTRAINT `FK_FEDMAPPERPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER`
--

LOCK TABLES `USER_FEDERATION_MAPPER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_MAPPER_CONFIG` (
  `USER_FEDERATION_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_FEDMAPPER_CFG` FOREIGN KEY (`USER_FEDERATION_MAPPER_ID`) REFERENCES `USER_FEDERATION_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER_CONFIG`
--

LOCK TABLES `USER_FEDERATION_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_PROVIDER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_FEDERATION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `CHANGED_SYNC_PERIOD` int(11) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `FULL_SYNC_PERIOD` int(11) DEFAULT NULL,
  `LAST_SYNC` int(11) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `PROVIDER_NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_PRV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_1FJ32F6PTOLW2QY60CD8N01E8` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_PROVIDER`
--

LOCK TABLES `USER_FEDERATION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_USER_GROUP_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_USER_GROUP_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_REQUIRED_ACTION` (
  `USER_ID` varchar(36) NOT NULL,
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_USER_REQACTIONS` (`USER_ID`),
  CONSTRAINT `FK_6QJ3W1JW9CVAFHE19BWSIUVMD` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_REQUIRED_ACTION`
--

LOCK TABLES `USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` DISABLE KEYS */;
INSERT INTO `USER_REQUIRED_ACTION` VALUES ('e7ed1987-67cb-4ab9-957c-96a9d0558ba1','UPDATE_PASSWORD');
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(255) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_USER_ROLE_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_C4FQV34P1MBYLLOXANG7B1Q3L` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ROLE_MAPPING`
--

LOCK TABLES `USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `USER_ROLE_MAPPING` VALUES ('10a18df0-0e9c-4e3f-8859-4305a1ad021d','0ea8c33e-b299-4af3-9f59-6068bd16e7eb'),('10a18df0-0e9c-4e3f-8859-4305a1ad021d','2eab712e-f2e3-4980-8e59-0c04e6034c88'),('27fb2112-9acf-44e1-8ef4-1894e8314750','0ea8c33e-b299-4af3-9f59-6068bd16e7eb'),('27fb2112-9acf-44e1-8ef4-1894e8314750','266cdefd-6754-4a6c-945f-558cae27e4eb'),('27fb2112-9acf-44e1-8ef4-1894e8314750','2eab712e-f2e3-4980-8e59-0c04e6034c88'),('27fb2112-9acf-44e1-8ef4-1894e8314750','9c5e25be-93cf-4459-8bae-bc18fdb0f7d5'),('27fb2112-9acf-44e1-8ef4-1894e8314750','c74ef0bb-d1ed-4697-b018-98c3ede35288'),('27fb2112-9acf-44e1-8ef4-1894e8314750','e7ed1987-67cb-4ab9-957c-96a9d0558ba1'),('334adf7d-7e99-4d8e-973c-e986820146cc','f08891c8-3541-45d3-bc57-37cde9096b3d'),('3ddd2326-65a2-4cbe-a45a-fe8b703a001a','c74ef0bb-d1ed-4697-b018-98c3ede35288'),('3ddd2326-65a2-4cbe-a45a-fe8b703a001a','e7ed1987-67cb-4ab9-957c-96a9d0558ba1'),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','0ea8c33e-b299-4af3-9f59-6068bd16e7eb'),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','266cdefd-6754-4a6c-945f-558cae27e4eb'),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','2eab712e-f2e3-4980-8e59-0c04e6034c88'),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','9c5e25be-93cf-4459-8bae-bc18fdb0f7d5'),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','c74ef0bb-d1ed-4697-b018-98c3ede35288'),('5302e4c3-fd65-4ef4-9973-fb4ceae5ff00','e7ed1987-67cb-4ab9-957c-96a9d0558ba1'),('6db32d76-4143-4d4c-824e-ceac9dd96e0a','f08891c8-3541-45d3-bc57-37cde9096b3d'),('832e079e-c5d6-4a04-9931-3a48ef94f292','f08891c8-3541-45d3-bc57-37cde9096b3d'),('89b09cba-22d1-47e6-af80-369fac2d354d','0ea8c33e-b299-4af3-9f59-6068bd16e7eb'),('89b09cba-22d1-47e6-af80-369fac2d354d','266cdefd-6754-4a6c-945f-558cae27e4eb'),('89b09cba-22d1-47e6-af80-369fac2d354d','2eab712e-f2e3-4980-8e59-0c04e6034c88'),('89b09cba-22d1-47e6-af80-369fac2d354d','9c5e25be-93cf-4459-8bae-bc18fdb0f7d5'),('89b09cba-22d1-47e6-af80-369fac2d354d','c74ef0bb-d1ed-4697-b018-98c3ede35288'),('89b09cba-22d1-47e6-af80-369fac2d354d','e7ed1987-67cb-4ab9-957c-96a9d0558ba1'),('8f20e717-6f37-4154-bac7-ad146cb77ad5','0ea8c33e-b299-4af3-9f59-6068bd16e7eb'),('8f20e717-6f37-4154-bac7-ad146cb77ad5','266cdefd-6754-4a6c-945f-558cae27e4eb'),('8f20e717-6f37-4154-bac7-ad146cb77ad5','2eab712e-f2e3-4980-8e59-0c04e6034c88'),('8f20e717-6f37-4154-bac7-ad146cb77ad5','9c5e25be-93cf-4459-8bae-bc18fdb0f7d5'),('8f20e717-6f37-4154-bac7-ad146cb77ad5','c74ef0bb-d1ed-4697-b018-98c3ede35288'),('8f20e717-6f37-4154-bac7-ad146cb77ad5','e7ed1987-67cb-4ab9-957c-96a9d0558ba1'),('ac517e4b-210f-43dd-8156-e71a76f1e7b9','266cdefd-6754-4a6c-945f-558cae27e4eb'),('ac517e4b-210f-43dd-8156-e71a76f1e7b9','9c5e25be-93cf-4459-8bae-bc18fdb0f7d5'),('e939dcc6-31af-4d71-bcb7-aa609ddf123c','f08891c8-3541-45d3-bc57-37cde9096b3d'),('f0af10fb-6a7b-48b8-9425-3346562af420','f08891c8-3541-45d3-bc57-37cde9096b3d');
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION`
--

DROP TABLE IF EXISTS `USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_SESSION` (
  `ID` varchar(36) NOT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `LAST_SESSION_REFRESH` int(11) DEFAULT NULL,
  `LOGIN_USERNAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `STARTED` int(11) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `USER_SESSION_STATE` int(11) DEFAULT NULL,
  `BROKER_SESSION_ID` varchar(255) DEFAULT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION`
--

LOCK TABLES `USER_SESSION` WRITE;
/*!40000 ALTER TABLE `USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER_SESSION_NOTE` (
  `USER_SESSION` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` text DEFAULT NULL,
  PRIMARY KEY (`USER_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51D3472` FOREIGN KEY (`USER_SESSION`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION_NOTE`
--

LOCK TABLES `USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WEB_ORIGINS`
--

DROP TABLE IF EXISTS `WEB_ORIGINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WEB_ORIGINS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_WEB_ORIG_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_LOJPHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WEB_ORIGINS`
--

LOCK TABLES `WEB_ORIGINS` WRITE;
/*!40000 ALTER TABLE `WEB_ORIGINS` DISABLE KEYS */;
INSERT INTO `WEB_ORIGINS` VALUES ('96094ef3-d44c-49ab-bbcf-08393ceb9a73','+'),('98eea42e-2e80-4ba1-afb0-66a15c0f7c67','+'),('cfc549ac-12f1-4189-ac9d-bd41c982c5d1','http://localhost:4200'),('dd8ccce6-186b-485c-a8f5-86d4cc8246e4','+');
/*!40000 ALTER TABLE `WEB_ORIGINS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-23 13:50:58
