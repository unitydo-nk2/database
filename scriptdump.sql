CREATE DATABASE  IF NOT EXISTS `unitydodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `unitydodb`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: unitydodb
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `activityId` int NOT NULL AUTO_INCREMENT,
  `activityOwner` int NOT NULL,
  `activityName` varchar(150) NOT NULL,
  `activityBriefDescription` varchar(100) NOT NULL,
  `activityDescription` varchar(300) NOT NULL,
  `activityDate` timestamp NOT NULL,
  `activityEndDate` timestamp NOT NULL,
  `registerStartDate` timestamp NOT NULL,
  `registerEndDate` timestamp NOT NULL,
  `amount` int NOT NULL,
  `locationId` int DEFAULT NULL,
  `announcementDate` timestamp NOT NULL,
  `activityStatus` varchar(255) NOT NULL,
  `isGamification` int NOT NULL,
  `suggestionNotes` varchar(500) DEFAULT NULL,
  `categoryId` int NOT NULL,
  `lastUpdate` timestamp NOT NULL,
  `createTime` timestamp NOT NULL,
  `activityFormat` varchar(255) NOT NULL,
  PRIMARY KEY (`activityId`),
  UNIQUE KEY `activityId_UNIQUE` (`activityId`),
  KEY `fk_Activity_location1_idx` (`locationId`),
  KEY `fk_Activity_Category1_idx` (`categoryId`),
  KEY `fk_Activity_User1_idx` (`activityOwner`),
  CONSTRAINT `fk_Activity_Category1` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`),
  CONSTRAINT `fk_Activity_location1` FOREIGN KEY (`locationId`) REFERENCES `location` (`locationId`),
  CONSTRAINT `fk_Activity_User1` FOREIGN KEY (`activityOwner`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (31,7,'Paint and Sip Night119','Artistic expression with a twist','Join us for a creative evening of painting and sipping your favorite drinks.','2024-01-16 08:00:00','2024-01-15 15:00:00','2023-12-26 05:00:00','2024-01-11 08:00:00',20,72,'2023-12-16 00:00:00','Active',1,NULL,29,'2023-12-08 14:55:37','2023-12-25 08:00:00','onsite'),(32,2,'Photography Expedition','Capture the beauty of nature','Embark on a photography expedition to capture stunning landscapes and wildlife.','2024-02-20 01:00:00','2024-02-21 11:00:00','2024-02-01 07:00:00','2024-02-15 11:00:00',15,12,'2024-01-25 02:00:00','Active',1,'Discover the art of photography in the great outdoors!',24,'2024-02-01 07:00:00','2024-02-01 07:00:00','onsiteOverNight'),(33,6,'Cooking Masterclass','Culinary delights for everyone','Join our cooking masterclass to enhance your culinary skills and enjoy delicious dishes.','2024-03-10 09:30:00','2024-03-10 13:30:00','2024-02-20 03:00:00','2024-03-05 11:00:00',25,16,'2024-02-10 07:00:00','Active',1,'Become a master chef with our expert chefs!',30,'2024-02-20 03:00:00','2024-02-20 03:00:00','onsite'),(34,7,'Gardening Workshop','Connect with nature through gardening','Learn the art of gardening and cultivate your own green space at home.','2024-04-05 03:00:00','2024-04-05 08:00:00','2024-03-15 02:00:00','2024-03-30 11:00:00',0,14,'2024-03-01 07:00:00','Active',1,'Create your own garden oasis with our gardening experts!',23,'2024-03-15 02:00:00','2024-03-15 02:00:00','onsite'),(35,2,'Fitness Bootcamp','Get fit and stay active','Join our fitness bootcamp for a high-energy workout to achieve your fitness goals.','2024-05-15 00:00:00','2024-05-15 02:30:00','2024-03-31 23:00:00','2024-05-10 11:00:00',10,5,'2024-04-10 03:00:00','Active',1,'Transform your body with our dynamic fitness program!',15,'2024-03-31 23:00:00','2024-03-31 23:00:00','onsite'),(36,2,'Swimming Challenge','Dive into the fun','Join our swimming challenge for a day of aquatic excitement.','2023-04-20 07:00:00','2023-04-20 11:00:00','2023-03-10 02:00:00','2023-04-15 11:00:00',15,4,'2023-03-20 04:00:00','Active',1,'Compete and win prizes in our swimming contest!',17,'2023-03-10 02:00:00','2023-03-10 02:00:00','onsite'),(37,6,'Online Coding Bootcamp','Enhance your coding skills','Join our online coding bootcamp to boost your programming knowledge.','2023-06-01 11:00:00','2023-06-10 13:00:00','2023-05-15 03:00:00','2023-05-30 11:00:00',0,NULL,'2023-05-01 07:00:00','Active',1,'Level up your coding game with us!',12,'2023-05-15 03:00:00','2023-05-15 03:00:00','online'),(38,7,'Campfire and Stargazing','Experience the night sky','Join us for an overnight adventure with campfire and stargazing.','2023-07-15 12:00:00','2023-07-16 01:00:00','2023-06-25 08:00:00','2023-07-10 11:00:00',12,7,'2023-06-30 03:00:00','Active',1,'Connect with nature under the stars!',21,'2023-06-25 08:00:00','2023-06-25 08:00:00','onsiteOverNight'),(39,2,'Salsa Dance Workshop','Feel the rhythm','Join our one-day salsa dance workshop to spice up your dance moves.','2023-11-15 07:30:00','2023-11-15 11:00:00','2023-10-25 05:30:00','2023-11-10 11:00:00',10,6,'2023-11-01 03:00:00','Active',1,'Learn to dance to the vibrant beats!',28,'2023-10-25 05:30:00','2023-10-25 05:30:00','onsite'),(40,6,'Digital Art Webinar','Unleash your creativity','Participate in our online webinar to explore the world of digital art.','2023-12-05 09:00:00','2023-12-05 11:30:00','2023-11-20 07:00:00','2023-12-01 11:00:00',0,NULL,'2023-11-10 02:00:00','Active',1,'Discover the magic of digital art!',33,'2023-11-20 07:00:00','2023-11-20 07:00:00','online'),(41,9,'Sample Activity','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2023-12-31 16:59:59','2023-11-30 17:00:00','2023-12-30 16:59:59',100,39,'2023-11-30 05:00:00','ACTIVE',1,'Some notes for the activity',3,'2023-11-28 08:30:00','2023-11-28 05:00:00','online'),(42,9,'Sample Activity','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2023-12-31 16:59:59','2023-11-30 17:00:00','2023-12-30 16:59:59',100,40,'2023-11-30 05:00:00','ACTIVE',1,'Some notes for the activity',3,'2023-11-28 08:30:00','2023-11-28 05:00:00','online'),(43,9,'Sample Activity','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2023-12-31 16:59:59','2023-11-30 17:00:00','2023-12-30 16:59:59',100,41,'2023-11-30 05:00:00','ACTIVE',1,'Some notes for the activity',3,'2023-11-28 08:30:00','2023-11-28 05:00:00','online'),(44,9,'Sample Activity','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2023-12-31 16:59:59','2023-11-30 17:00:00','2023-12-30 16:59:59',100,42,'2023-11-30 05:00:00','ACTIVE',1,'Some notes for the activity',3,'2023-11-28 08:30:00','2023-11-28 05:00:00','online'),(45,9,'Sample Activity2','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2023-12-31 16:59:59','2023-11-30 17:00:00','2023-12-30 16:59:59',100,43,'2023-11-30 05:00:00','ACTIVE',1,'Some notes for the activity',3,'2023-11-28 08:30:00','2023-11-28 05:00:00','online'),(46,9,'Sample Activity3','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2023-12-31 16:59:59','2023-11-30 17:00:00','2023-12-30 16:59:59',100,44,'2023-11-30 05:00:00','ACTIVE',1,'Some notes for the activity',5,'2023-11-28 08:30:00','2023-11-28 05:00:00','online'),(47,9,'Sample Activity5555','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2023-12-31 16:59:59','2023-11-30 17:00:00','2023-12-30 16:59:59',100,47,'2023-11-30 05:00:00','ACTIVE',1,'Some notes for the activity',5,'2023-11-28 08:30:00','2023-11-28 05:00:00','online'),(50,14,'sss','sadasd','asdasdasd','2023-12-09 06:39:00','2023-12-23 08:40:00','2023-12-10 15:35:00','2023-12-11 15:35:00',12,58,'2023-12-13 15:35:00','Active',0,NULL,19,'2023-12-08 08:51:31','2023-12-08 08:51:31','online'),(51,14,'sss','sadasd','asdasdasd','2023-12-09 06:39:00','2023-12-23 08:40:00','2023-12-10 15:35:00','2023-12-11 15:35:00',12,59,'2023-12-13 15:35:00','Active',0,NULL,19,'2023-12-08 08:53:48','2023-12-08 08:53:48','online'),(52,15,'Sample Activity','Brief description of the sample activity','Detailed description of the sample activity','2023-12-31 05:00:00','2024-01-10 11:00:00','2023-12-01 02:00:00','2023-12-15 10:00:00',100,62,'2023-11-30 08:30:00','Active',1,'Any suggestion notes for the activity',12,'2023-12-08 09:02:20','2023-12-08 09:02:20','ONLINE'),(53,16,'siraphop \"successfully POST\" celebration','post dai leaw','post dai leaw post dai leaw post dai leaw post dai leaw','2023-12-09 16:07:00','2023-12-09 16:07:00','2023-12-09 16:07:00','2023-12-09 16:07:00',100,63,'2023-12-09 16:07:00','Active',1,NULL,8,'2023-12-08 09:08:05','2023-12-08 09:08:05','online');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activityfavorite`
--

DROP TABLE IF EXISTS `activityfavorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activityfavorite` (
  `activityFavoriteID` int NOT NULL AUTO_INCREMENT,
  `activityHistoryId` int NOT NULL,
  `isFavorite` int NOT NULL,
  PRIMARY KEY (`activityFavoriteID`),
  KEY `fk_activityFavorite_ActivityHistory1_idx` (`activityHistoryId`),
  CONSTRAINT `fk_activityFavorite_ActivityHistory1` FOREIGN KEY (`activityHistoryId`) REFERENCES `useractivityhistory` (`activityHistoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activityfavorite`
--

LOCK TABLES `activityfavorite` WRITE;
/*!40000 ALTER TABLE `activityfavorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `activityfavorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activityreview`
--

DROP TABLE IF EXISTS `activityreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activityreview` (
  `activityReviewId` int NOT NULL AUTO_INCREMENT,
  `activityId` int NOT NULL,
  `userId` int NOT NULL,
  `score` int NOT NULL,
  `reviewDescription` varchar(500) NOT NULL,
  PRIMARY KEY (`activityReviewId`),
  KEY `fk_activityReview_Activity1_idx` (`activityId`),
  KEY `fk_activityReview_Users1_idx` (`userId`),
  CONSTRAINT `fk_activityReview_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`),
  CONSTRAINT `fk_activityReview_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activityreview`
--

LOCK TABLES `activityreview` WRITE;
/*!40000 ALTER TABLE `activityreview` DISABLE KEYS */;
/*!40000 ALTER TABLE `activityreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `answerId` int NOT NULL AUTO_INCREMENT,
  `registrationId` int DEFAULT NULL,
  `questionId` int NOT NULL,
  `answer` varchar(400) NOT NULL,
  PRIMARY KEY (`answerId`),
  KEY `fk_answer_Registeration1_idx` (`registrationId`),
  KEY `fk_Answer_QuestionTitle1_idx` (`questionId`),
  CONSTRAINT `fk_Answer_QuestionTitle1` FOREIGN KEY (`questionId`) REFERENCES `questiontitle` (`quetionId`),
  CONSTRAINT `fk_answer_Registeration1` FOREIGN KEY (`registrationId`) REFERENCES `registration` (`registrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  `mainCategory` int NOT NULL,
  PRIMARY KEY (`categoryId`),
  KEY `fk_Category_subCategory1_idx` (`mainCategory`),
  CONSTRAINT `fk_Category_subCategory1` FOREIGN KEY (`mainCategory`) REFERENCES `maincategory` (`mainCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Animal care',1),(2,'Social services',1),(3,'Healthcare',1),(4,'Leisure and sporting',1),(5,'Environmental',1),(6,'Creative',1),(7,'Others',1),(8,'Science & Technology',2),(9,'Mathematics',2),(10,'Art',2),(11,'Music',2),(12,'Others',2),(13,'Boxing',3),(14,'Hiking',3),(15,'Running',3),(16,'Walking',3),(17,'Swimming',3),(18,'Football',3),(19,'Basketball',3),(20,'Volleyball',3),(21,'Others',3),(22,'Aerobics',4),(23,'Yoga',4),(24,'Cover Dance',4),(25,'Gymnastics',4),(26,'Others',4),(27,'Painting',5),(28,'Drawing',5),(29,'Sculpture',5),(30,'Music',5),(31,'Singing',5),(32,'Dancing',5),(33,'Writing',5),(34,'Poetry',5),(35,'Literature',5),(36,'Others',5),(37,'Start-up',6),(38,'Marketing',6),(39,'Financial',6),(40,'E-commerce',6),(41,'Logistics',6),(42,'Others',6),(43,'Others',7),(44,'Animal care',1),(45,'Social services',1),(46,'Healthcare',1),(47,'Leisure and sporting',1),(48,'Environmental',1),(49,'Creative',1),(50,'Others',1),(51,'Science & Technology',2),(52,'Mathematics',2),(53,'Art',2),(54,'Music',2),(55,'Others',2),(56,'Boxing',3),(57,'Hiking',3),(58,'Running',3),(59,'Walking',3),(60,'Swimming',3),(61,'Football',3),(62,'Basketball',3),(63,'Volleyball',3),(64,'Others',3),(65,'Aerobics',4),(66,'Yoga',4),(67,'Cover Dance',4),(68,'Gymnastics',4),(69,'Others',4),(70,'Painting',5),(71,'Drawing',5),(72,'Sculpture',5),(73,'Music',5),(74,'Singing',5),(75,'Dancing',5),(76,'Writing',5),(77,'Poetry',5),(78,'Literature',5),(79,'Others',5),(80,'Start-up',6),(81,'Marketing',6),(82,'Financial',6),(83,'E-commerce',6),(84,'Logistics',6),(85,'Others',6),(86,'Others',7);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `imageId` int NOT NULL AUTO_INCREMENT,
  `activityId` int DEFAULT NULL,
  `label` varchar(100) NOT NULL,
  `alt` varchar(100) NOT NULL,
  `imagepath` varchar(300) NOT NULL,
  PRIMARY KEY (`imageId`),
  KEY `fk_image_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_image_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `locationId` int NOT NULL AUTO_INCREMENT,
  `locationName` varchar(150) NOT NULL,
  `googleMapLink` varchar(300) NOT NULL,
  `locationLongitude` double NOT NULL,
  `locationLatitude` double NOT NULL,
  PRIMARY KEY (`locationId`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Doi Suthep Temple','https://maps.google.com/maps?q=Doi+Suthep+Temple,Chiang+Mai,Thailand',98.842499,18.804388),(2,'James Bond Island','https://maps.google.com/maps?q=James+Bond+Island,Phang+Nga,Thailand',98.529864,8.269304),(3,'Hua Hin Beach','https://maps.google.com/maps?q=Hua+Hin+Beach,Prachuap+Khiri+Khan,Thailand',99.956897,12.561806),(4,'Pai Canyon','https://maps.google.com/maps?q=Pai+Canyon,Mae+Hong+Son,Thailand',98.440406,19.365791),(5,'Ko Phi Phi Leh','https://maps.google.com/maps?q=Ko+Phi+Phi+Leh,Krabi,Thailand',98.764579,7.681415),(6,'Erawan National Park','https://maps.google.com/maps?q=Erawan+National+Park,Kanchanaburi,Thailand',99.2132,14.402426),(7,'Similan Islands','https://maps.google.com/maps?q=Similan+Islands,Phang+Nga,Thailand',97.645233,8.655676),(8,'Ko Samui','https://maps.google.com/maps?q=Ko+Samui,Surat+Thani,Thailand',100.06316,9.512017),(9,'Wat Rong Khun (White Temple)','https://maps.google.com/maps?q=Wat+Rong+Khun,Chiang+Rai,Thailand',99.779937,19.82428),(10,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',99.840411,10.100359),(11,'Wat Pho','https://maps.google.com/maps?q=Wat+Pho,Bangkok,Thailand',100.493941,13.746703),(12,'Phuket Beach','https://maps.google.com/maps?q=Patong+Beach,Phuket,Thailand',98.293087,7.89568),(13,'Chiang Mai Old City','https://maps.google.com/maps?q=Chiang+Mai+Old+City,Chiang+Mai,Thailand',98.993685,18.785124),(14,'Krabi Railay Beach','https://maps.google.com/maps?q=Railay+Beach,Krabi,Thailand',98.838603,8.010108),(15,'Ayutthaya Historical Park','https://maps.google.com/maps?q=Ayutthaya,Historical+Park,Ayutthaya,Thailand',100.552113,14.361914),(16,'Doi Suthep Temple','https://maps.google.com/maps?q=Doi+Suthep+Temple,Chiang+Mai,Thailand',98.842499,18.804388),(17,'James Bond Island','https://maps.google.com/maps?q=James+Bond+Island,Phang+Nga,Thailand',98.529864,8.269304),(18,'Hua Hin Beach','https://maps.google.com/maps?q=Hua+Hin+Beach,Prachuap+Khiri+Khan,Thailand',99.956897,12.561806),(19,'Pai Canyon','https://maps.google.com/maps?q=Pai+Canyon,Mae+Hong+Son,Thailand',98.440406,19.365791),(20,'Ko Phi Phi Leh','https://maps.google.com/maps?q=Ko+Phi+Phi+Leh,Krabi,Thailand',98.764579,7.681415),(21,'Erawan National Park','https://maps.google.com/maps?q=Erawan+National+Park,Kanchanaburi,Thailand',99.2132,14.402426),(22,'Similan Islands','https://maps.google.com/maps?q=Similan+Islands,Phang+Nga,Thailand',97.645233,8.655676),(23,'Ko Samui','https://maps.google.com/maps?q=Ko+Samui,Surat+Thani,Thailand',100.06316,9.512017),(24,'Wat Rong Khun (White Temple)','https://maps.google.com/maps?q=Wat+Rong+Khun,Chiang+Rai,Thailand',99.779937,19.82428),(25,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',99.840411,10.100359),(26,'Wat Pho','https://maps.google.com/maps?q=Wat+Pho,Bangkok,Thailand',100.493941,13.746703),(27,'Phuket Beach','https://maps.google.com/maps?q=Patong+Beach,Phuket,Thailand',98.293087,7.89568),(28,'Chiang Mai Old City','https://maps.google.com/maps?q=Chiang+Mai+Old+City,Chiang+Mai,Thailand',98.993685,18.785124),(29,'Krabi Railay Beach','https://maps.google.com/maps?q=Railay+Beach,Krabi,Thailand',98.838603,8.010108),(30,'Ayutthaya Historical Park','https://maps.google.com/maps?q=Ayutthaya,Historical+Park,Ayutthaya,Thailand',100.552113,14.361914),(31,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(32,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(33,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(34,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(35,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(36,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(37,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(38,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(39,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(40,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(41,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(42,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(43,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(44,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(45,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(46,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(47,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(48,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(49,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(50,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(51,'Sample Location','https://www.google.com/maps',40.7128,-74.006),(52,'ssss','sssdsad',0,0),(53,'siraphoppppp','pppppp',0,0),(54,'sdfsdfdsf','sdfsdfdsf',0,0),(55,'sadasdasd','asdasdasd',0,0),(56,'sadasdasd','asdasdasd',0,0),(57,'sadasdasd','asdasdasd',0,0),(58,'sadasdasd','asdasdasd',0,0),(59,'sadasdasd','asdasdasd',0,0),(60,'Sample Location','https://maps.google.com/sample',12.345678,23.456789),(61,'Sample Location','https://maps.google.com/sample',12.345678,23.456789),(62,'Sample Location','https://maps.google.com/sample',12.345678,23.456789),(63,'siraphop home','mai meee',0,0),(64,'Sample Location','https://www.google.com/maps',0,0),(65,'Sample Location','https://www.google.com/maps',0,0),(66,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',0,0),(67,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',0,0),(68,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',0,0),(69,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',0,0),(70,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',0,0),(71,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',0,0),(72,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',0,0);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maincategory`
--

DROP TABLE IF EXISTS `maincategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maincategory` (
  `mainCategoryId` int NOT NULL AUTO_INCREMENT,
  `mainCategory` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`mainCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maincategory`
--

LOCK TABLES `maincategory` WRITE;
/*!40000 ALTER TABLE `maincategory` DISABLE KEYS */;
INSERT INTO `maincategory` VALUES (1,'Volunteers',NULL),(2,'Education',NULL),(3,'Exercises',NULL),(4,'Dance',NULL),(5,'Art & Music',NULL),(6,'Business',NULL),(7,'Others',NULL),(8,'Volunteers',NULL),(9,'Education',NULL),(10,'Exercises',NULL),(11,'Dance',NULL),(12,'Art & Music',NULL),(13,'Business',NULL),(14,'Others',NULL);
/*!40000 ALTER TABLE `maincategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalinfomation`
--

DROP TABLE IF EXISTS `medicalinfomation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalinfomation` (
  `idmedicalInfomation` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`idmedicalInfomation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalinfomation`
--

LOCK TABLES `medicalinfomation` WRITE;
/*!40000 ALTER TABLE `medicalinfomation` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicalinfomation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questiontitle`
--

DROP TABLE IF EXISTS `questiontitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questiontitle` (
  `quetionId` int NOT NULL,
  `Question` varchar(100) NOT NULL,
  `activityId` int DEFAULT NULL,
  PRIMARY KEY (`quetionId`),
  KEY `fk_questionTitle_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_questionTitle_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questiontitle`
--

LOCK TABLES `questiontitle` WRITE;
/*!40000 ALTER TABLE `questiontitle` DISABLE KEYS */;
/*!40000 ALTER TABLE `questiontitle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `registrationId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `registrationDate` datetime NOT NULL,
  `status` tinytext NOT NULL,
  `activityId` int NOT NULL,
  PRIMARY KEY (`registrationId`),
  UNIQUE KEY `registerationId_UNIQUE` (`registrationId`),
  KEY `fk_Registeration_Users1_idx` (`userId`),
  KEY `fk_Registeration_Activity1_idx` (`activityId`),
  KEY `fk_Registration_Activity1_idx` (`activityId`),
  KEY `fk_Registration_Users1_idx` (`userId`),
  CONSTRAINT `fk_Registeration_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`),
  CONSTRAINT `fk_Registeration_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (1,4,'2024-01-15 11:17:22','confirmed',35),(2,4,'2022-01-15 11:17:22','registered',36),(3,4,'2022-01-15 11:17:22','registered',37),(4,4,'2022-01-15 11:17:22','registered',38),(5,10,'2023-12-07 21:11:38','s',35),(6,11,'2023-12-07 22:01:12','s',31);
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requirements`
--

DROP TABLE IF EXISTS `requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requirements` (
  `requirementId` int NOT NULL AUTO_INCREMENT,
  `activityId` int NOT NULL,
  `medicalInfomation` int NOT NULL,
  PRIMARY KEY (`requirementId`),
  KEY `fk_requirements_Activity1_idx` (`activityId`),
  KEY `fk_requirements_medicalInfomation1_idx` (`medicalInfomation`),
  CONSTRAINT `fk_requirements_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`),
  CONSTRAINT `fk_requirements_medicalInfomation1` FOREIGN KEY (`medicalInfomation`) REFERENCES `medicalinfomation` (`idmedicalInfomation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requirements`
--

LOCK TABLES `requirements` WRITE;
/*!40000 ALTER TABLE `requirements` DISABLE KEYS */;
/*!40000 ALTER TABLE `requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(250) NOT NULL,
  `name` varchar(100) NOT NULL,
  `surName` varchar(100) NOT NULL,
  `nickName` varchar(70) NOT NULL,
  `email` varchar(100) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `religion` varchar(50) NOT NULL,
  `telephoneNumber` varchar(50) NOT NULL,
  `address` varchar(400) NOT NULL,
  `role` varchar(255) NOT NULL,
  `emergencyPhoneNumber` varchar(45) NOT NULL,
  `profileImg` varchar(300) DEFAULT NULL,
  `line` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `x` varchar(100) DEFAULT NULL,
  `createTime` timestamp NOT NULL,
  `updateTime` timestamp NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1','password123','John','Doe','JD123','john.doe@email.com','Male','1990-05-15','Christian','+1234567890','123 Main St, City, Country','user','+0987654321','profile1.jpg','john_doe_line','john_doe_instagram','john_doe_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(2,'user2','password456','Jane','Smith','JS456','jane.smith@email.com','Female','1985-08-20','Buddhist','+9876543210','456 Elm St, City, Country','activityOwner','+1234509876','profile2.jpg','jane_smith_line','jane_smith_instagram','jane_smith_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(3,'admin1','adminpassword','Admin','User','Admin123','admin@email.com','Other','1970-01-01','None','+1111111111','789 Oak St, City, Country','admin','+2222222222','admin_profile.jpg','admin_line','admin_instagram','admin_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(4,'user3','userpass123','Alice','Johnson','AJ123','alice@email.com','Female','1995-03-10','Hindu','+3333333333','789 Elm St, City, Country','user','+3333333333','alice_profile.jpg','alice_line','alice_instagram','alice_x','2023-01-15 05:30:00','2023-01-15 05:30:00'),(5,'user4','userpass456','Bob','Williams','BW456','bob@email.com','Male','1988-11-25','Atheist','+4444444444','123 Oak St, City, Country','user','+4444444444','bob_profile.jpg','bob_line','bob_instagram','bob_x','2023-01-16 02:45:00','2023-01-16 02:45:00'),(6,'activityOwner1','activitypass123','Sarah','Miller','SM123','sarah@email.com','Female','1980-07-05','Jewish','+5555555555','456 Pine St, City, Country','activityOwner','+5555555555','sarah_profile.jpg','sarah_line','sarah_instagram','sarah_x','2023-01-17 07:20:00','2023-01-17 07:20:00'),(7,'activityOwner2','activitypass456','Michael','Brown','MB456','michael@email.com','Male','1982-04-12','Christian','+6666666666','789 Maple St, City, Country','activityOwner','+6666666666','michael_profile.jpg','michael_line','michael_instagram','michael_x','2023-01-18 11:10:00','2023-01-18 11:10:00'),(8,'admin2','adminpassword2','Admin','User2','Admin234','admin2@email.com','Other','1975-02-15','None','+7777777777','456 Cedar St, City, Country','admin','+7777777777','admin2_profile.jpg','admin2_line','admin2_instagram','admin2_x','2023-01-19 14:05:00','2023-01-19 14:05:00'),(9,'sampleUser','samplePassword','John','Doe','JD','john.doe@example.com','Male','1990-01-01','Christianity','1234567890','123 Main St, City','USER','9876543210','https://example.com/profile.jpg','john_doe','john_doe_insta','additional_info','2023-01-01 05:00:00','2023-01-01 08:30:00'),(10,'johndoe','secretpassword','John','Doe','JD','john.doe@example.com','Male','1990-01-01','Christian','+1234567890','123 Main St, City','User','+9876543210','https://example.com/profile.jpg',NULL,NULL,NULL,'2023-01-01 05:00:00','2023-01-01 05:30:00'),(11,'userNameIsInRelease2','passwordIsInRelease2','sadasda','dadasdasd','asdadasd','asdada@asda.cdf','female','2023-12-29','Sikhism','1234567890','123456789012345678901234567890','User','1234567890',NULL,NULL,NULL,NULL,'2023-12-07 15:01:12','2023-12-07 15:01:12'),(12,'\"siraphop\"_UserName','\"siraphop\"_Password','\"siraphop\"_Name','\"siraphop\"_SurName','\"siraphop\"_nickName','\"siraphop\"@email.com','male','2023-12-08','Buddhism','0123456789','\"siraphop\" Address','ActivityOwner','9876543210','\"siraphop\"profile_image_link','\"siraphop\"_lineId','\"siraphop\"_instagram','\"siraphop\"_xAccount','2023-12-08 08:22:08','2023-12-08 08:22:08'),(13,'\"fdsfsdfsdf\"_UserName','\"fdsfsdfsdf\"_Password','\"fdsfsdfsdf\"_Name','\"fdsfsdfsdf\"_SurName','\"fdsfsdfsdf\"_nickName','\"fdsfsdfsdf\"@email.com','male','2023-12-08','Buddhism','0123456789','\"fdsfsdfsdf\" Address','ActivityOwner','9876543210','\"fdsfsdfsdf\"profile_image_link','\"fdsfsdfsdf\"_lineId','\"fdsfsdfsdf\"_instagram','\"fdsfsdfsdf\"_xAccount','2023-12-08 08:27:15','2023-12-08 08:27:15'),(14,'\"asdasdasd\"_UserName','\"asdasdasd\"_Password','\"asdasdasd\"_Name','\"asdasdasd\"_SurName','\"asdasdasd\"_nickName','\"asdasdasd\"@email.com','male','2023-12-08','Buddhism','0123456789','\"asdasdasd\" Address','ActivityOwner','9876543210','\"asdasdasd\"profile_image_link','\"asdasdasd\"_lineId','\"asdasdasd\"_instagram','\"asdasdasd\"_xAccount','2023-12-08 08:35:31','2023-12-08 08:35:31'),(15,'\"winnerinwza\"_UserName','\"winnerinwza\"_Password','\"winnerinwza\"_Name','\"winnerinwza\"_SurName','\"winnerinwza\"_nickName','\"winnerinwza\"@email.com','male','2023-12-08','Buddhism','0123456789','\"winnerinwza\" Address','ActivityOwner','9876543210','\"winnerinwza\"profile_image_link','\"winnerinwza\"_lineId','\"winnerinwza\"_instagram','\"winnerinwza\"_xAccount','2023-12-08 09:01:29','2023-12-08 09:01:29'),(16,'\"phopparker\"','\"phopparker\"_Password','\"phopparker\"_Name','\"phopparker\"_SurName','\"phopparker\"_nickName','\"phopparker\"@email.com','male','2023-12-08','Buddhism','0123456789','\"phopparker\" Address','ActivityOwner','9876543210','\"phopparker\"profile_image_link','\"phopparker\"_lineId','\"phopparker\"_instagram','\"phopparker\"_xAccount','2023-12-08 09:08:05','2023-12-08 09:08:05'),(17,'undefined','undefined_Password','undefined_Name','undefined_SurName','undefined_nickName','undefined@email.com','male','2023-12-08','Buddhism','0123456789','undefined Address','ActivityOwner','9876543210','undefinedprofile_image_link','undefined_lineId','undefined_instagram','undefined_xAccount','2023-12-08 09:12:28','2023-12-08 09:12:28'),(18,'user1','password123','John','Doe','JD123','john.doe@email.com','Male','1990-05-15','Christian','+1234567890','123 Main St, City, Country','user','+0987654321','profile1.jpg','john_doe_line','john_doe_instagram','john_doe_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(19,'user2','password456','Jane','Smith','JS456','jane.smith@email.com','Female','1985-08-20','Buddhist','+9876543210','456 Elm St, City, Country','activityOwner','+1234509876','profile2.jpg','jane_smith_line','jane_smith_instagram','jane_smith_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(20,'admin1','adminpassword','Admin','User','Admin123','admin@email.com','Other','1970-01-01','None','+1111111111','789 Oak St, City, Country','admin','+2222222222','admin_profile.jpg','admin_line','admin_instagram','admin_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(21,'user3','userpass123','Alice','Johnson','AJ123','alice@email.com','Female','1995-03-10','Hindu','+3333333333','789 Elm St, City, Country','user','+3333333333','alice_profile.jpg','alice_line','alice_instagram','alice_x','2023-01-15 05:30:00','2023-01-15 05:30:00'),(22,'user4','userpass456','Bob','Williams','BW456','bob@email.com','Male','1988-11-25','Atheist','+4444444444','123 Oak St, City, Country','user','+4444444444','bob_profile.jpg','bob_line','bob_instagram','bob_x','2023-01-16 02:45:00','2023-01-16 02:45:00'),(23,'activityOwner1','activitypass123','Sarah','Miller','SM123','sarah@email.com','Female','1980-07-05','Jewish','+5555555555','456 Pine St, City, Country','activityOwner','+5555555555','sarah_profile.jpg','sarah_line','sarah_instagram','sarah_x','2023-01-17 07:20:00','2023-01-17 07:20:00'),(24,'activityOwner2','activitypass456','Michael','Brown','MB456','michael@email.com','Male','1982-04-12','Christian','+6666666666','789 Maple St, City, Country','activityOwner','+6666666666','michael_profile.jpg','michael_line','michael_instagram','michael_x','2023-01-18 11:10:00','2023-01-18 11:10:00'),(25,'admin2','adminpassword2','Admin','User2','Admin234','admin2@email.com','Other','1975-02-15','None','+7777777777','456 Cedar St, City, Country','admin','+7777777777','admin2_profile.jpg','admin2_line','admin2_instagram','admin2_x','2023-01-19 14:05:00','2023-01-19 14:05:00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useractivityhistory`
--

DROP TABLE IF EXISTS `useractivityhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useractivityhistory` (
  `activityHistoryId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `activityId` int NOT NULL,
  PRIMARY KEY (`activityHistoryId`),
  KEY `fk_activityHistory_Users1_idx` (`userId`),
  KEY `fk_activityHistory_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_activityHistory_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`),
  CONSTRAINT `fk_activityHistory_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useractivityhistory`
--

-- LOCK TABLES `useractivityhistory` WRITE;
-- /*!40000 ALTER TABLE `useractivityhistory` DISABLE KEYS */;
-- INSERT INTO `useractivityhistory` VALUES (1,1,31),(2,4,32),(3,5,33),(4,1,34),(5,4,35),(6,5,36),(7,1,37),(8,4,38),(9,5,39),(10,1,40),(11,4,31),(12,5,32),(13,1,33),(14,4,34),(15,5,35),(16,1,36),(17,4,37),(18,5,38),(19,1,39),(20,4,40),(21,5,31),(22,1,32),(23,4,33),(24,5,34),(25,1,35),(26,4,36),(27,5,37),(28,1,38),(29,4,39),(30,5,40),(31,1,31),(32,4,32),(33,5,33),(34,1,34),(35,4,35),(36,5,36),(37,1,37),(38,4,38),(39,5,39),(40,1,40),(41,4,31),(42,5,32),(43,1,33),(44,4,34),(45,5,35),(46,1,36),(47,4,37),(48,5,38),(49,1,39),(50,4,40),(51,5,31),(52,1,32),(53,4,33),(54,5,34),(55,1,35),(56,4,36),(57,5,37),(58,1,38),(59,4,39),(60,5,40),(61,1,31),(62,4,32),(63,5,33),(64,1,34),(65,4,35),(66,5,36),(67,1,37),(68,4,38),(69,5,39),(70,1,40),(71,4,31),(72,5,32),(73,1,33),(74,4,34),(75,5,35),(76,1,36),(77,4,37),(78,5,38),(79,1,39),(80,4,40),(81,5,31),(82,1,32),(83,4,33),(84,5,34),(85,1,35),(86,4,36),(87,5,37),(88,1,38),(89,4,39),(90,5,40),(91,1,31),(92,4,32),(93,5,33),(94,1,34),(95,4,35),(96,5,36),(97,1,37),(98,4,38),(99,5,39),(100,1,40),(101,4,31),(102,5,32),(103,1,33),(104,4,34),(105,5,35),(106,1,36),(107,4,37),(108,5,38),(109,1,39),(110,4,40),(111,5,31),(112,1,32),(113,4,33),(114,5,34),(115,1,35),(116,4,36),(117,5,37),(118,1,38),(119,4,39),(120,5,40),(121,1,31),(122,4,32),(123,5,33),(124,1,34),(125,4,35),(126,5,36),(127,1,37),(128,4,38),(129,5,39),(130,1,40),(131,4,31),(132,5,32),(133,1,33),(134,4,34),(135,5,35),(136,1,36),(137,4,37),(138,5,38),(139,1,39),(140,4,40),(141,5,31),(142,1,32),(143,4,33),(144,5,34),(145,1,35),(146,4,36),(147,5,37),(148,1,38),(149,4,39),(150,5,40),(151,1,31),(152,4,32),(153,5,33),(154,1,34),(155,4,35),(156,5,36),(157,1,37),(158,4,38),(159,5,39),(160,1,40),(161,4,31),(162,5,32),(163,1,33),(164,4,34),(165,5,35),(166,1,36),(167,4,37),(168,5,38),(169,1,39),(170,4,40),(171,5,31),(172,1,32),(173,4,33),(174,5,34),(175,1,35),(176,4,36),(177,5,37),(178,1,38),(179,4,39),(180,5,40),(181,1,31),(182,4,32),(183,5,33),(184,1,34),(185,4,35),(186,5,36),(187,1,37),(188,4,38),(189,5,39),(190,1,40),(191,4,31),(192,5,32),(193,1,33),(194,4,34),(195,5,35),(196,1,36),(197,4,37),(198,5,38),(199,1,39),(200,4,40),(201,5,31),(202,1,32),(203,4,33),(204,5,34),(205,1,35),(206,4,36),(207,5,37),(208,1,38),(209,4,39),(210,5,40),(211,1,31),(212,4,32),(213,5,33),(214,1,34),(215,4,35),(216,5,36),(217,1,37),(218,4,38),(219,5,39),(220,1,40),(221,4,31),(222,5,32),(223,1,33),(224,4,34),(225,5,35),(226,1,36),(227,4,37),(228,5,38),(229,1,39),(230,4,40),(231,5,31),(232,1,32),(233,4,33),(234,5,34),(235,1,35),(236,4,36),(237,5,37),(238,1,38),(239,4,39),(240,5,40),(241,1,31),(242,4,32),(243,5,33),(244,1,34),(245,4,35),(246,5,36),(247,1,37),(248,4,38),(249,5,39),(250,1,40),(251,4,31),(252,5,32),(253,1,33),(254,4,34),(255,5,35),(256,1,36),(257,4,37),(258,5,38),(259,1,39),(260,4,40),(261,5,31),(262,1,32),(263,4,33),(264,5,34),(265,1,35),(266,4,36),(267,5,37),(268,1,38),(269,4,39),(270,5,40);
-- /*!40000 ALTER TABLE `useractivityhistory` ENABLE KEYS */;
-- UNLOCK TABLES;

--
-- Table structure for table `usermedicalinfo`
--

DROP TABLE IF EXISTS `usermedicalinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usermedicalinfo` (
  `congenitalDiseasesID` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `medicalInfomation` int NOT NULL,
  PRIMARY KEY (`congenitalDiseasesID`),
  KEY `fk_congenitalDiseases_Users1_idx` (`userId`),
  KEY `fk_CongenitalDiseases_medicalInfomation1_idx` (`medicalInfomation`),
  CONSTRAINT `fk_CongenitalDiseases_medicalInfomation1` FOREIGN KEY (`medicalInfomation`) REFERENCES `medicalinfomation` (`idmedicalInfomation`),
  CONSTRAINT `fk_congenitalDiseases_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usermedicalinfo`
--

LOCK TABLES `usermedicalinfo` WRITE;
/*!40000 ALTER TABLE `usermedicalinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `usermedicalinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `validation`
--

DROP TABLE IF EXISTS `validation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `validation` (
  `validationId` int NOT NULL AUTO_INCREMENT,
  `activityId` int NOT NULL,
  `validationType` varchar(100) NOT NULL,
  `validationRule` double NOT NULL,
  PRIMARY KEY (`validationId`),
  KEY `fk_Validation_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_Validation_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validation`
--

LOCK TABLES `validation` WRITE;
/*!40000 ALTER TABLE `validation` DISABLE KEYS */;
/*!40000 ALTER TABLE `validation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'unitydodb'
--

--
-- Dumping routines for database 'unitydodb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-09 16:39:06
