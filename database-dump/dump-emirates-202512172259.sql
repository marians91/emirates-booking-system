-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: emirates
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aeromobile`
--

DROP TABLE IF EXISTS `aeromobile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aeromobile` (
  `id_aeromobile` int unsigned NOT NULL AUTO_INCREMENT,
  `registration_number` char(10) NOT NULL,
  `modello` varchar(50) NOT NULL,
  PRIMARY KEY (`id_aeromobile`),
  UNIQUE KEY `uk_aeromobile_registration` (`registration_number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aeromobile`
--

LOCK TABLES `aeromobile` WRITE;
/*!40000 ALTER TABLE `aeromobile` DISABLE KEYS */;
INSERT INTO `aeromobile` VALUES (1,'A6-EUA','A380-800'),(2,'A6-EUB','A380-800'),(3,'A6-EUC','A380-800'),(4,'A6-EBA','B777-300ER'),(5,'A6-EBB','B777-300ER'),(6,'A6-EBC','B777-300ER');
/*!40000 ALTER TABLE `aeromobile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aeroporto`
--

DROP TABLE IF EXISTS `aeroporto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aeroporto` (
  `id_aeroporto` int NOT NULL AUTO_INCREMENT,
  `codice_iata` char(3) NOT NULL,
  `codice_icao` char(4) DEFAULT NULL,
  `nome` varchar(200) NOT NULL,
  `citta` varchar(100) NOT NULL,
  PRIMARY KEY (`id_aeroporto`),
  UNIQUE KEY `codice_iata` (`codice_iata`),
  UNIQUE KEY `codice_icao` (`codice_icao`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aeroporto`
--

LOCK TABLES `aeroporto` WRITE;
/*!40000 ALTER TABLE `aeroporto` DISABLE KEYS */;
INSERT INTO `aeroporto` VALUES (1,'DXB','OMDB','Dubai International Airport','Dubai'),(2,'MXP','LIMC','Milano Malpensa','Milano'),(3,'FCO','LIRF','Roma Fiumicino','Roma'),(4,'LHR','EGLL','London Heathrow','Londra'),(5,'CDG','LFPG','Paris Charles de Gaulle','Parigi'),(6,'JFK','KJFK','John F. Kennedy International','New York'),(7,'LAX','KLAX','Los Angeles International','Los Angeles'),(8,'BKK','VTBS','Suvarnabhumi Airport','Bangkok'),(9,'SIN','WSSS','Singapore Changi','Singapore'),(10,'SYD','YSSY','Sydney Kingsford Smith','Sydney');
/*!40000 ALTER TABLE `aeroporto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biglietto`
--

DROP TABLE IF EXISTS `biglietto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biglietto` (
  `id_biglietto` int NOT NULL AUTO_INCREMENT,
  `numero_biglietto` char(13) NOT NULL,
  `id_prenotazione` int NOT NULL,
  `id_passeggero` int NOT NULL,
  `id_classe` tinyint NOT NULL,
  `tipo_biglietto` enum('SOLO_ANDATA','ANDATA_RITORNO','MULTI_CITTA') NOT NULL,
  `data_emissione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_biglietto`),
  UNIQUE KEY `uk_biglietto_numero` (`numero_biglietto`),
  KEY `fk_biglietto_classe` (`id_classe`),
  KEY `idx_biglietto_prenotazione` (`id_prenotazione`),
  KEY `idx_biglietto_passeggero` (`id_passeggero`),
  CONSTRAINT `fk_biglietto_classe` FOREIGN KEY (`id_classe`) REFERENCES `classe` (`id_classe`) ON UPDATE CASCADE,
  CONSTRAINT `fk_biglietto_passeggero` FOREIGN KEY (`id_passeggero`) REFERENCES `passeggero` (`id_passeggero`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_biglietto_prenotazione` FOREIGN KEY (`id_prenotazione`) REFERENCES `prenotazione` (`id_prenotazione`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biglietto`
--

LOCK TABLES `biglietto` WRITE;
/*!40000 ALTER TABLE `biglietto` DISABLE KEYS */;
INSERT INTO `biglietto` VALUES (1,'1761234567890',1,1,3,'ANDATA_RITORNO','2025-12-10 14:35:00'),(2,'1761234567891',1,2,3,'ANDATA_RITORNO','2025-12-10 14:35:00'),(3,'1761234567892',1,3,3,'ANDATA_RITORNO','2025-12-10 14:35:00'),(4,'1761234567893',1,4,3,'ANDATA_RITORNO','2025-12-10 14:35:00'),(5,'1769876543210',2,5,2,'SOLO_ANDATA','2025-12-15 09:25:00'),(6,'1761111111111',3,8,1,'ANDATA_RITORNO','2025-12-18 16:50:00'),(7,'1762222222222',3,9,1,'ANDATA_RITORNO','2025-12-18 16:50:00'),(8,'1763333333333',4,6,3,'SOLO_ANDATA','2025-12-12 11:05:00'),(9,'1764444444444',5,7,2,'SOLO_ANDATA','2025-12-14 18:35:00');
/*!40000 ALTER TABLE `biglietto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biglietto_has_volo`
--

DROP TABLE IF EXISTS `biglietto_has_volo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biglietto_has_volo` (
  `id_biglietto` int NOT NULL,
  `id_volo` int NOT NULL,
  `id_posto` int NOT NULL,
  `sequenza` int NOT NULL,
  `segmento_tipo` enum('Principale','Connessione') NOT NULL,
  PRIMARY KEY (`id_biglietto`,`id_volo`),
  KEY `id_posto` (`id_posto`),
  KEY `idx_volo` (`id_volo`),
  CONSTRAINT `biglietto_has_volo_ibfk_1` FOREIGN KEY (`id_biglietto`) REFERENCES `biglietto` (`id_biglietto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `biglietto_has_volo_ibfk_2` FOREIGN KEY (`id_volo`) REFERENCES `volo` (`id_volo`),
  CONSTRAINT `biglietto_has_volo_ibfk_3` FOREIGN KEY (`id_posto`) REFERENCES `posto` (`id_posto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biglietto_has_volo`
--

LOCK TABLES `biglietto_has_volo` WRITE;
/*!40000 ALTER TABLE `biglietto_has_volo` DISABLE KEYS */;
INSERT INTO `biglietto_has_volo` VALUES (1,1,21,1,'Principale'),(1,2,22,2,'Connessione'),(1,3,29,3,'Principale'),(1,4,30,4,'Connessione'),(2,1,23,1,'Principale'),(2,2,24,2,'Connessione'),(2,3,31,3,'Principale'),(2,4,32,4,'Connessione'),(3,1,25,1,'Principale'),(3,2,26,2,'Connessione'),(3,3,33,3,'Principale'),(3,4,34,4,'Connessione'),(4,1,27,1,'Principale'),(4,2,28,2,'Connessione'),(4,3,35,3,'Principale'),(4,4,36,4,'Connessione'),(5,5,15,1,'Principale'),(6,1,1,1,'Principale'),(6,2,2,2,'Connessione'),(6,3,5,3,'Principale'),(6,4,6,4,'Connessione'),(7,1,3,1,'Principale'),(7,2,4,2,'Connessione'),(7,3,7,3,'Principale'),(7,4,8,4,'Connessione'),(8,7,37,1,'Principale'),(9,9,55,1,'Principale');
/*!40000 ALTER TABLE `biglietto_has_volo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classe`
--

DROP TABLE IF EXISTS `classe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classe` (
  `id_classe` tinyint NOT NULL AUTO_INCREMENT,
  `nome_classe` varchar(20) NOT NULL,
  PRIMARY KEY (`id_classe`),
  UNIQUE KEY `uk_classe_nome` (`nome_classe`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classe`
--

LOCK TABLES `classe` WRITE;
/*!40000 ALTER TABLE `classe` DISABLE KEYS */;
INSERT INTO `classe` VALUES (2,'Business'),(3,'Economy'),(1,'First');
/*!40000 ALTER TABLE `classe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `id_pagamento` int NOT NULL AUTO_INCREMENT,
  `id_prenotazione` int NOT NULL,
  `importo` decimal(10,2) NOT NULL,
  `data_pagamento` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pagamento`),
  KEY `idx_pagamento_prenotazione` (`id_prenotazione`),
  CONSTRAINT `fk_pagamento_prenotazione` FOREIGN KEY (`id_prenotazione`) REFERENCES `prenotazione` (`id_prenotazione`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_pagamento_importo` CHECK ((`importo` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES (1,1,2400.00,'2025-12-10 14:40:00'),(2,1,2400.00,'2025-12-20 10:15:00'),(3,2,2500.00,'2025-12-15 09:30:00'),(4,3,16000.00,'2025-12-18 17:00:00'),(5,4,950.00,'2025-12-12 11:10:00'),(6,5,900.00,'2025-12-14 18:40:00');
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passeggero`
--

DROP TABLE IF EXISTS `passeggero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passeggero` (
  `id_passeggero` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `data_nascita` date NOT NULL,
  `email` varchar(150) NOT NULL,
  `id_skywards` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id_passeggero`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `id_skywards` (`id_skywards`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passeggero`
--

LOCK TABLES `passeggero` WRITE;
/*!40000 ALTER TABLE `passeggero` DISABLE KEYS */;
INSERT INTO `passeggero` VALUES (1,'Mario','Rossi','1975-03-15','mario.rossi@example.com','EK1234567890'),(2,'Laura','Rossi','1978-07-22','laura.rossi@example.com','EK1234567891'),(3,'Giulia','Rossi','2005-11-10','giulia.rossi@example.com','EK1234567892'),(4,'Marco','Rossi','2008-04-18','marco.rossi@example.com','EK1234567893'),(5,'Alessandro','Bianchi','1982-09-05','a.bianchi@company.it','EK9876543210'),(6,'Sofia','Verdi','1990-12-25','sofia.verdi@email.com',NULL),(7,'Luca','Neri','1988-06-30','luca.neri@email.com',NULL),(8,'Francesca','Ferrari','1995-02-14','francesca.ferrari@example.com',NULL),(9,'Andrea','Ferrari','1993-08-20','andrea.ferrari@example.com',NULL);
/*!40000 ALTER TABLE `passeggero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posto`
--

DROP TABLE IF EXISTS `posto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posto` (
  `id_posto` int NOT NULL AUTO_INCREMENT,
  `id_aeromobile` int unsigned NOT NULL,
  `id_classe` tinyint NOT NULL,
  `numero_posto` varchar(5) NOT NULL,
  `disponibile` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_posto`),
  UNIQUE KEY `uk_posto_aeromobile` (`id_aeromobile`,`numero_posto`),
  KEY `fk_posto_classe` (`id_classe`),
  KEY `idx_posto_disponibilita` (`id_aeromobile`,`disponibile`),
  CONSTRAINT `fk_posto_aeromobile` FOREIGN KEY (`id_aeromobile`) REFERENCES `aeromobile` (`id_aeromobile`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_posto_classe` FOREIGN KEY (`id_classe`) REFERENCES `classe` (`id_classe`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posto`
--

LOCK TABLES `posto` WRITE;
/*!40000 ALTER TABLE `posto` DISABLE KEYS */;
INSERT INTO `posto` VALUES (1,1,1,'1A',0),(2,1,1,'1C',0),(3,1,1,'1E',0),(4,1,1,'1F',0),(5,1,1,'1K',0),(6,1,1,'2A',0),(7,1,1,'2C',0),(8,1,1,'2E',0),(9,1,1,'2F',1),(10,1,1,'2K',1),(11,1,1,'3A',1),(12,1,1,'3C',1),(13,1,1,'3E',1),(14,1,1,'3F',1),(15,1,2,'6A',0),(16,1,2,'6C',1),(17,1,2,'6E',1),(18,1,2,'6K',1),(19,1,2,'7A',1),(20,1,2,'7C',1),(21,1,2,'7E',0),(22,1,2,'7K',0),(23,1,2,'8A',0),(24,1,2,'8C',0),(25,1,2,'8E',0),(26,1,2,'8K',0),(27,1,2,'9A',0),(28,1,2,'9C',0),(29,1,2,'9E',0),(30,1,2,'9K',0),(31,1,2,'10A',0),(32,1,2,'10C',0),(33,1,2,'10E',0),(34,1,2,'10K',0),(35,1,3,'43A',0),(36,1,3,'43B',0),(37,1,3,'43C',0),(38,1,3,'43D',1),(39,1,3,'43E',1),(40,1,3,'43F',1),(41,1,3,'43G',1),(42,1,3,'43H',1),(43,1,3,'43J',1),(44,1,3,'43K',1),(45,1,3,'44A',1),(46,1,3,'44B',1),(47,1,3,'44C',1),(48,1,3,'44D',1),(49,1,3,'44E',1),(50,1,3,'44F',1),(51,1,3,'44G',1),(52,1,3,'44H',1),(53,1,3,'44J',1),(54,1,3,'44K',1),(55,1,3,'45A',0),(56,1,3,'45B',1),(57,1,3,'45C',1),(58,1,3,'45D',1),(59,1,3,'45E',1),(60,1,3,'45F',1),(61,1,3,'45G',1),(62,1,3,'45H',1),(63,1,3,'45J',1),(64,1,3,'45K',1),(65,4,2,'1A',1),(66,4,2,'1C',1),(67,4,2,'1E',1),(68,4,2,'1K',1),(69,4,2,'2A',1),(70,4,2,'2C',1),(71,4,2,'2E',1),(72,4,2,'2K',1),(73,4,2,'3A',1),(74,4,2,'3C',1),(75,4,3,'20A',1),(76,4,3,'20B',1),(77,4,3,'20C',1),(78,4,3,'20D',1),(79,4,3,'20E',1),(80,4,3,'20F',1),(81,4,3,'20G',1),(82,4,3,'20H',1),(83,4,3,'20J',1),(84,4,3,'20K',1),(85,4,3,'21A',1),(86,4,3,'21B',1),(87,4,3,'21C',1),(88,4,3,'21D',1),(89,4,3,'21E',1),(90,4,3,'21F',1),(91,4,3,'21G',1),(92,4,3,'21H',1),(93,4,3,'21J',1),(94,4,3,'21K',1);
/*!40000 ALTER TABLE `posto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenotazione`
--

DROP TABLE IF EXISTS `prenotazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenotazione` (
  `id_prenotazione` int NOT NULL AUTO_INCREMENT,
  `codice_pnr` char(6) NOT NULL,
  `id_passeggero` int NOT NULL,
  `data_prenotazione` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `prezzo` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_prenotazione`),
  UNIQUE KEY `uk_prenotazione_pnr` (`codice_pnr`),
  KEY `fk_prenotazione_passeggero` (`id_passeggero`),
  KEY `idx_prenotazione_data` (`data_prenotazione`),
  CONSTRAINT `fk_prenotazione_passeggero` FOREIGN KEY (`id_passeggero`) REFERENCES `passeggero` (`id_passeggero`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenotazione`
--

LOCK TABLES `prenotazione` WRITE;
/*!40000 ALTER TABLE `prenotazione` DISABLE KEYS */;
INSERT INTO `prenotazione` VALUES (1,'ABC123',1,'2025-12-10 14:30:00',4800.00),(2,'DEF456',5,'2025-12-15 09:20:00',2500.00),(3,'GHI789',8,'2025-12-18 16:45:00',16000.00),(4,'JKL012',6,'2025-12-12 11:00:00',950.00),(5,'MNO345',7,'2025-12-14 18:30:00',1800.00);
/*!40000 ALTER TABLE `prenotazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rotta`
--

DROP TABLE IF EXISTS `rotta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rotta` (
  `id_rotta` int NOT NULL AUTO_INCREMENT,
  `id_aeroporto_origine` int NOT NULL,
  `id_aeroporto_destinazione` int NOT NULL,
  PRIMARY KEY (`id_rotta`),
  UNIQUE KEY `uk_rotta` (`id_aeroporto_origine`,`id_aeroporto_destinazione`),
  KEY `fk_rotta_destinazione` (`id_aeroporto_destinazione`),
  CONSTRAINT `fk_rotta_destinazione` FOREIGN KEY (`id_aeroporto_destinazione`) REFERENCES `aeroporto` (`id_aeroporto`) ON DELETE RESTRICT,
  CONSTRAINT `fk_rotta_origine` FOREIGN KEY (`id_aeroporto_origine`) REFERENCES `aeroporto` (`id_aeroporto`) ON DELETE RESTRICT,
  CONSTRAINT `chk_rotta_aeroporti_diversi` CHECK ((`id_aeroporto_origine` <> `id_aeroporto_destinazione`))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rotta`
--

LOCK TABLES `rotta` WRITE;
/*!40000 ALTER TABLE `rotta` DISABLE KEYS */;
INSERT INTO `rotta` VALUES (2,1,2),(12,1,3),(14,1,4),(3,1,6),(5,1,7),(7,1,8),(9,1,10),(1,2,1),(11,3,1),(13,4,1),(4,6,1),(6,7,1),(8,8,1),(10,10,1);
/*!40000 ALTER TABLE `rotta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volo`
--

DROP TABLE IF EXISTS `volo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volo` (
  `id_volo` int NOT NULL AUTO_INCREMENT,
  `codice_volo` char(6) NOT NULL,
  `id_rotta` int NOT NULL,
  `id_aeromobile` int unsigned NOT NULL,
  `data_volo` date NOT NULL,
  `ora_partenza` time NOT NULL,
  `ora_arrivo` time NOT NULL,
  PRIMARY KEY (`id_volo`),
  UNIQUE KEY `uk_volo` (`codice_volo`,`data_volo`),
  KEY `fk_volo_aeromobile` (`id_aeromobile`),
  KEY `idx_volo_rotta` (`id_rotta`),
  CONSTRAINT `fk_volo_aeromobile` FOREIGN KEY (`id_aeromobile`) REFERENCES `aeromobile` (`id_aeromobile`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_volo_rotta` FOREIGN KEY (`id_rotta`) REFERENCES `rotta` (`id_rotta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volo`
--

LOCK TABLES `volo` WRITE;
/*!40000 ALTER TABLE `volo` DISABLE KEYS */;
INSERT INTO `volo` VALUES (1,'EK091',1,1,'2026-01-15','14:20:00','22:45:00'),(2,'EK201',4,1,'2026-01-16','03:10:00','08:35:00'),(3,'EK202',5,1,'2026-01-22','10:30:00','18:45:00'),(4,'EK092',2,1,'2026-01-23','02:50:00','07:10:00'),(5,'EK095',1,4,'2026-01-15','22:30:00','06:50:00'),(6,'EK096',2,4,'2026-01-16','09:00:00','13:20:00'),(7,'EK001',4,1,'2026-01-15','08:30:00','13:55:00'),(8,'EK011',6,1,'2026-01-15','14:45:00','22:30:00'),(9,'EK384',8,4,'2026-01-15','02:25:00','08:50:00'),(10,'EK413',10,1,'2026-01-15','22:30:00','16:40:00');
/*!40000 ALTER TABLE `volo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'emirates'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-17 22:59:43
