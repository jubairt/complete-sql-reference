-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: librarydb
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `book_reviews`
--

DROP TABLE IF EXISTS `book_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_reviews` (
  `ReviewID` int NOT NULL,
  `Content` text,
  PRIMARY KEY (`ReviewID`),
  FULLTEXT KEY `idx_review` (`Content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_reviews`
--

LOCK TABLES `book_reviews` WRITE;
/*!40000 ALTER TABLE `book_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `book_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `BookID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Author` varchar(255) NOT NULL,
  `PublishedYear` int DEFAULT NULL,
  `Stock` int DEFAULT '0',
  `genre` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`BookID`),
  KEY `idx_author` (`Author`),
  KEY `hash_author` (`Author`),
  KEY `book_id` (`BookID`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (5,'War and Peace','Leo Tolstoy',1869,10,'horror'),(6,'Pride and Prejudice','Jane Austen',1813,80,'horror'),(7,'The Catcher in the Rye','J.D. Salinger',1951,21,'horror'),(8,'The Hobbit','J.R.R. Tolkien',1937,25,'action'),(9,'Fahrenheit 451','Ray Bradbury',1953,22,'action'),(10,'Brave New World','Aldous Huxley',1932,20,'action'),(11,'Crime and Punishment','Fyodor Dostoevsky',1866,18,'action'),(12,'The Odyssey','Homer',-700,21,'action'),(13,'The Iliad','Homer',-750,21,'action'),(14,'Dracula','Bram Stoker',1897,20,'education'),(15,'Frankenstein','Mary Shelley',1818,23,'education'),(30,'BOOK 1','author 1',NULL,2,NULL),(40,'BOOK 2','author 2',NULL,4,NULL),(58,'HELLO','james',NULL,12,NULL),(67,'HI','john',NULL,34,NULL),(100,'book 1','author 1',NULL,19,'education'),(110,'book 2','author 2',NULL,21,'education');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_log`
--

DROP TABLE IF EXISTS `borrow_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `log_message` varchar(255) DEFAULT NULL,
  `log_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_log`
--

LOCK TABLES `borrow_log` WRITE;
/*!40000 ALTER TABLE `borrow_log` DISABLE KEYS */;
INSERT INTO `borrow_log` VALUES (1,'A new borrow record was added','2025-04-24 02:57:46'),(2,'A new borrow record was added','2025-04-24 02:59:50'),(3,'days_borrowed was updated','2025-04-24 03:04:09'),(4,'A borrow record is about to be deleted','2025-04-24 03:05:10'),(5,'A borrow record was deleted','2025-04-24 03:05:10'),(6,'A borrow record is about to be deleted','2025-04-24 03:06:22'),(7,'A borrow record was deleted','2025-04-24 03:06:22'),(8,'A new borrow record was added','2025-04-24 04:15:51');
/*!40000 ALTER TABLE `borrow_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrowing`
--

DROP TABLE IF EXISTS `borrowing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrowing` (
  `BorrowID` int NOT NULL AUTO_INCREMENT,
  `MemberID` int DEFAULT NULL,
  `BookID` int DEFAULT NULL,
  `BorrowDate` date DEFAULT (curdate()),
  `ReturnDate` date DEFAULT NULL,
  `days_borrowed` int DEFAULT NULL,
  PRIMARY KEY (`BorrowID`),
  KEY `idx_borrowing_member` (`MemberID`),
  KEY `idx_borrowing_book` (`BookID`),
  KEY `idx_borrow_book` (`BookID`),
  KEY `idx_date` (`BorrowDate`),
  KEY `book_id` (`BookID`),
  KEY `idx_covering` (`BookID`,`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrowing`
--

LOCK TABLES `borrowing` WRITE;
/*!40000 ALTER TABLE `borrowing` DISABLE KEYS */;
INSERT INTO `borrowing` VALUES (4,4,9,'2024-01-18','2024-01-28',NULL),(5,5,11,'2024-02-01',NULL,NULL),(6,6,13,'2024-02-05',NULL,NULL),(9,9,5,'2024-02-15',NULL,NULL),(10,10,7,'2024-02-18',NULL,NULL),(11,1,9,'2024-02-20',NULL,NULL),(12,2,11,'2024-02-25',NULL,NULL),(13,3,13,'2024-02-28',NULL,NULL),(16,6,6,'2024-03-10',NULL,NULL),(17,7,8,'2024-03-12',NULL,NULL),(18,8,10,'2024-03-15',NULL,NULL),(19,9,12,'2024-03-18',NULL,NULL),(20,10,14,'2024-03-20',NULL,NULL),(22,8,11,'2025-02-13',NULL,NULL),(23,1,101,'2025-04-23',NULL,7),(24,1,101,'2025-04-23',NULL,7),(101,1,1,'2025-04-24',NULL,7);
/*!40000 ALTER TABLE `borrowing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `MemberID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `JoinDate` date DEFAULT (curdate()),
  `MembershipType` enum('Standard','Premium') NOT NULL,
  PRIMARY KEY (`MemberID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'Alice Johnson','2025-01-31','Standard'),(2,'Bob Smith','2025-01-31','Premium'),(3,'Charlie Davis','2025-01-31','Standard'),(4,'David Wilson','2025-01-31','Premium'),(5,'Eva Adams','2025-01-31','Standard'),(6,'Frank Thomas','2025-01-31','Premium'),(7,'Grace Hall','2025-01-31','Standard'),(8,'Henry Clark','2025-01-31','Premium'),(9,'Ivy Lewis','2025-01-31','Standard'),(10,'Jack Walker','2025-01-31','Premium');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-24 14:08:51
