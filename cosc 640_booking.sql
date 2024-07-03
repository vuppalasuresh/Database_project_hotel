CREATE DATABASE  IF NOT EXISTS `cosc 640` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cosc 640`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cosc 640
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `bookingId` int NOT NULL AUTO_INCREMENT,
  `checkin` date DEFAULT NULL,
  `checkout` date DEFAULT NULL,
  `No_of_people` int DEFAULT NULL,
  `days` int DEFAULT NULL,
  `breakfast` varchar(5) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer` int DEFAULT NULL,
  `roomId` int DEFAULT NULL,
  `staffID` int DEFAULT NULL,
  PRIMARY KEY (`bookingId`),
  KEY `customer` (`customer`),
  KEY `roomId` (`roomId`),
  KEY `staffID` (`staffID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer`) REFERENCES `customer` (`id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`roomId`) REFERENCES `room` (`Roomid`),
  CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`staffID`) REFERENCES `staff` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,'2023-11-01','2023-11-01',1,NULL,'on','Debit Card',NULL,102,NULL),(2,'2023-10-30','2023-11-02',2,NULL,'on','Debit Card',NULL,101,NULL),(3,'2023-10-30','2023-11-02',2,NULL,'on','Debit Card',NULL,101,NULL),(4,'2023-10-30','2023-11-02',2,NULL,'on','Debit Card',NULL,101,NULL),(5,'2023-11-01','2023-11-03',3,NULL,'on','Debit Card',12,101,NULL),(6,'2023-11-01','2023-11-03',3,NULL,'on','Debit Card',12,101,NULL),(7,'2023-11-08','2023-11-09',2,NULL,'on','Credit Card',12,101,NULL),(8,'2023-11-14','2023-11-15',1,NULL,'on','Credit Card',12,101,NULL),(9,'2023-11-14','2023-11-16',2,NULL,'on','cash',12,102,NULL),(10,'2023-11-15','2023-11-17',2,NULL,NULL,'Debit Card',13,102,NULL),(11,'2023-11-15','2023-11-16',1,1,'on','Credit Card',13,101,NULL),(12,'2023-11-15','2023-11-17',2,2,'on','Credit Card',12,101,NULL),(13,'2023-11-15','2023-11-18',1,3,NULL,'Credit Card',12,103,4);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
-- DELIMITER ;;
-- /*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `calculate_days_trigger` BEFORE INSERT ON `booking` FOR EACH ROW SET NEW.days = DATEDIFF(NEW.checkout, NEW.checkin) */;;
-- DELIMITER ;
-- /*!50003 SET sql_mode              = @saved_sql_mode */ ;
-- /*!50003 SET character_set_client  = @saved_cs_client */ ;
-- /*!50003 SET character_set_results = @saved_cs_results */ ;
-- /*!50003 SET collation_connection  = @saved_col_connection */ ;
-- /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

-- /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
-- /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
-- /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
-- /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
-- /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- -- Dump completed on 2023-11-15  8:32:34
