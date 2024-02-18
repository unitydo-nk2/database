CREATE DATABASE  IF NOT EXISTS `unityDoDB` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `unityDoDB`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 10.4.85.19    Database: unityDoDB
-- ------------------------------------------------------
-- Server version	8.3.0

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
  `activityStatus` enum('Active','Done') NOT NULL,
  `isGamification` tinyint NOT NULL,
  `suggestionNotes` varchar(500) DEFAULT NULL,
  `categoryId` int NOT NULL,
  `lastUpdate` timestamp NOT NULL,
  `createTime` timestamp NOT NULL,
  `activityFormat` enum('online','onsite','onsiteOverNight') NOT NULL,
  PRIMARY KEY (`activityId`),
  UNIQUE KEY `activityId_UNIQUE` (`activityId`),
  KEY `fk_Activity_location1_idx` (`locationId`),
  KEY `fk_Activity_Category1_idx` (`categoryId`),
  KEY `fk_Activity_User1_idx` (`activityOwner`),
  CONSTRAINT `fk_Activity_Category1` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`),
  CONSTRAINT `fk_Activity_location1` FOREIGN KEY (`locationId`) REFERENCES `location` (`locationId`),
  CONSTRAINT `fk_Activity_User1` FOREIGN KEY (`activityOwner`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES (1,7,'Paint and Sip Night','Artistic expression with a twist','Join us for a creative evening of painting and sipping your favorite drinks.','2024-01-15 11:00:00','2024-01-15 15:00:00','2023-12-25 08:00:00','2024-01-10 11:00:00',20,10,'2023-12-15 03:00:00','Active',1,'Unleash your inner artist while enjoying a social atmosphere!',29,'2023-12-25 08:00:00','2023-12-25 08:00:00','onsite'),(2,2,'Photography Expedition','Capture the beauty of nature','Embark on a photography expedition to capture stunning landscapes and wildlife.','2024-02-20 01:00:00','2024-02-21 11:00:00','2024-02-01 07:00:00','2024-02-15 11:00:00',15,12,'2024-01-25 02:00:00','Active',1,'Discover the art of photography in the great outdoors!',24,'2024-02-01 07:00:00','2024-02-01 07:00:00','onsiteOverNight'),(3,6,'Cooking Masterclass','Culinary delights for everyone','Join our cooking masterclass to enhance your culinary skills and enjoy delicious dishes.','2024-03-10 09:30:00','2024-03-10 13:30:00','2024-02-20 03:00:00','2024-03-05 11:00:00',25,15,'2024-02-10 07:00:00','Active',1,'Become a master chef with our expert chefs!',30,'2024-02-20 03:00:00','2024-02-20 03:00:00','onsite'),(4,7,'Gardening Workshop','Connect with nature through gardening','Learn the art of gardening and cultivate your own green space at home.','2024-04-05 03:00:00','2024-04-05 08:00:00','2024-03-15 02:00:00','2024-03-30 11:00:00',0,14,'2024-03-01 07:00:00','Active',1,'Create your own garden oasis with our gardening experts!',23,'2024-03-15 02:00:00','2024-03-15 02:00:00','onsite'),(5,2,'Fitness Bootcamp','Get fit and stay active','Join our fitness bootcamp for a high-energy workout to achieve your fitness goals.','2024-05-15 00:00:00','2024-05-15 02:30:00','2024-03-31 23:00:00','2024-05-10 11:00:00',10,5,'2024-04-10 03:00:00','Active',1,'Transform your body with our dynamic fitness program!',15,'2024-03-31 23:00:00','2024-03-31 23:00:00','onsite'),(6,2,'Swimming Challenge','Dive into the fun','Join our swimming challenge for a day of aquatic excitement.','2023-04-20 07:00:00','2023-04-20 11:00:00','2023-03-10 02:00:00','2023-04-15 11:00:00',15,4,'2023-03-20 04:00:00','Active',1,'Compete and win prizes in our swimming contest!',17,'2023-03-10 02:00:00','2023-03-10 02:00:00','onsite'),(7,6,'Online Coding Bootcamp','Enhance your coding skills','Join our online coding bootcamp to boost your programming knowledge.','2023-06-01 11:00:00','2023-06-10 13:00:00','2023-05-15 03:00:00','2023-05-30 11:00:00',0,16,'2023-05-01 07:00:00','Active',1,'Level up your coding game with us!',12,'2023-05-15 03:00:00','2023-05-15 03:00:00','online'),(8,7,'Campfire and Stargazing','Experience the night sky','Join us for an overnight adventure with campfire and stargazing.','2023-07-15 12:00:00','2023-07-16 01:00:00','2023-06-25 08:00:00','2023-07-10 11:00:00',12,7,'2023-06-30 03:00:00','Active',1,'Connect with nature under the stars!',21,'2023-06-25 08:00:00','2023-06-25 08:00:00','onsiteOverNight'),(9,2,'Salsa Dance Workshop','Feel the rhythm','Join our one-day salsa dance workshop to spice up your dance moves.','2023-11-15 07:30:00','2023-11-15 11:00:00','2023-10-25 05:30:00','2023-11-10 11:00:00',10,6,'2023-11-01 03:00:00','Active',1,'Learn to dance to the vibrant beats!',28,'2023-10-25 05:30:00','2023-10-25 05:30:00','onsite'),(10,6,'Digital Art Webinar','Unleash your creativity','Participate in our online webinar to explore the world of digital art.','2023-12-05 09:00:00','2023-12-05 11:30:00','2023-11-20 07:00:00','2023-12-01 11:00:00',0,16,'2023-11-10 02:00:00','Active',1,'Discover the magic of digital art!',33,'2023-11-20 07:00:00','2023-11-20 07:00:00','online');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activityFavorite`
--

DROP TABLE IF EXISTS `activityFavorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activityFavorite` (
  `activityFavoriteId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `activityId` int NOT NULL,
  PRIMARY KEY (`activityFavoriteId`),
  KEY `fk_activityFavorite_Users1_idx` (`userId`),
  KEY `fk_activityFavorite_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_activityFavorite_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE,
  CONSTRAINT `fk_activityFavorite_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activityFavorite`
--

LOCK TABLES `activityFavorite` WRITE;
/*!40000 ALTER TABLE `activityFavorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `activityFavorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activityReview`
--

DROP TABLE IF EXISTS `activityReview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activityReview` (
  `activityReviewId` int NOT NULL AUTO_INCREMENT,
  `activityId` int NOT NULL,
  `userId` int NOT NULL,
  `score` int NOT NULL,
  `reviewDescription` varchar(500) NOT NULL,
  PRIMARY KEY (`activityReviewId`),
  KEY `fk_activityReview_Activity1_idx` (`activityId`),
  KEY `fk_activityReview_Users1_idx` (`userId`),
  CONSTRAINT `fk_activityReview_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE,
  CONSTRAINT `fk_activityReview_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activityReview`
--

LOCK TABLES `activityReview` WRITE;
/*!40000 ALTER TABLE `activityReview` DISABLE KEYS */;
/*!40000 ALTER TABLE `activityReview` ENABLE KEYS */;
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
  KEY `fk_answer_Registration1_idx` (`registrationId`),
  KEY `fk_Answer_QuestionTitle1_idx` (`questionId`),
  CONSTRAINT `fk_Answer_QuestionTitle1` FOREIGN KEY (`questionId`) REFERENCES `questionTitle` (`questionId`),
  CONSTRAINT `fk_answer_Registration1` FOREIGN KEY (`registrationId`) REFERENCES `registration` (`registrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
  CONSTRAINT `fk_Category_subCategory1` FOREIGN KEY (`mainCategory`) REFERENCES `mainCategory` (`mainCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Animal care',1),(2,'Social services',1),(3,'Healthcare',1),(4,'Leisure and sporting',1),(5,'Environmental',1),(6,'Creative',1),(7,'Others',1),(8,'Science & Technology',2),(9,'Mathematics',2),(10,'Art',2),(11,'Music',2),(12,'Others',2),(13,'Boxing',3),(14,'Hiking',3),(15,'Running',3),(16,'Walking',3),(17,'Swimming',3),(18,'Football',3),(19,'Basketball',3),(20,'Volleyball',3),(21,'Others',3),(22,'Aerobics',4),(23,'Yoga',4),(24,'Cover Dance',4),(25,'Gymnastics',4),(26,'Others',4),(27,'Painting',5),(28,'Drawing',5),(29,'Sculpture',5),(30,'Music',5),(31,'Singing',5),(32,'Dancing',5),(33,'Writing',5),(34,'Poetry',5),(35,'Literature',5),(36,'Others',5),(37,'Start-up',6),(38,'Marketing',6),(39,'Financial',6),(40,'E-commerce',6),(41,'Logistics',6),(42,'Others',6),(43,'Others',7);
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
  CONSTRAINT `fk_image_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Doi Suthep Temple','https://maps.google.com/maps?q=Doi+Suthep+Temple,Chiang+Mai,Thailand',98.842499,18.804388),(2,'James Bond Island','https://maps.google.com/maps?q=James+Bond+Island,Phang+Nga,Thailand',98.529864,8.269304),(3,'Hua Hin Beach','https://maps.google.com/maps?q=Hua+Hin+Beach,Prachuap+Khiri+Khan,Thailand',99.956897,12.561806),(4,'Pai Canyon','https://maps.google.com/maps?q=Pai+Canyon,Mae+Hong+Son,Thailand',98.440406,19.365791),(5,'Ko Phi Phi Leh','https://maps.google.com/maps?q=Ko+Phi+Phi+Leh,Krabi,Thailand',98.764579,7.681415),(6,'Erawan National Park','https://maps.google.com/maps?q=Erawan+National+Park,Kanchanaburi,Thailand',99.2132,14.402426),(7,'Similan Islands','https://maps.google.com/maps?q=Similan+Islands,Phang+Nga,Thailand',97.645233,8.655676),(8,'Ko Samui','https://maps.google.com/maps?q=Ko+Samui,Surat+Thani,Thailand',100.06316,9.512017),(9,'Wat Rong Khun (White Temple)','https://maps.google.com/maps?q=Wat+Rong+Khun,Chiang+Rai,Thailand',99.779937,19.82428),(10,'Ko Tao','https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',99.840411,10.100359),(11,'Wat Pho','https://maps.google.com/maps?q=Wat+Pho,Bangkok,Thailand',100.493941,13.746703),(12,'Phuket Beach','https://maps.google.com/maps?q=Patong+Beach,Phuket,Thailand',98.293087,7.89568),(13,'Chiang Mai Old City','https://maps.google.com/maps?q=Chiang+Mai+Old+City,Chiang+Mai,Thailand',98.993685,18.785124),(14,'Krabi Railay Beach','https://maps.google.com/maps?q=Railay+Beach,Krabi,Thailand',98.838603,8.010108),(15,'Ayutthaya Historical Park','https://maps.google.com/maps?q=Ayutthaya,Historical+Park,Ayutthaya,Thailand',100.552113,14.361914),(16,'ZOOM','https://demo-zoomlink.com/',0,0);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mainCategory`
--

DROP TABLE IF EXISTS `mainCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mainCategory` (
  `mainCategoryId` int NOT NULL AUTO_INCREMENT,
  `mainCategory` varchar(100) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`mainCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mainCategory`
--

LOCK TABLES `mainCategory` WRITE;
/*!40000 ALTER TABLE `mainCategory` DISABLE KEYS */;
INSERT INTO `mainCategory` VALUES (1,'Volunteers',NULL),(2,'Education',NULL),(3,'Exercises',NULL),(4,'Dance',NULL),(5,'Art & Music',NULL),(6,'Business',NULL),(7,'Others',NULL);
/*!40000 ALTER TABLE `mainCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalInfomation`
--

DROP TABLE IF EXISTS `medicalInfomation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalInfomation` (
  `idmedicalInfomation` int NOT NULL AUTO_INCREMENT,
  `type` enum('Amedicalinfomation','D','I') NOT NULL,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`idmedicalInfomation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalInfomation`
--

LOCK TABLES `medicalInfomation` WRITE;
/*!40000 ALTER TABLE `medicalInfomation` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicalInfomation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionTitle`
--

DROP TABLE IF EXISTS `questionTitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionTitle` (
  `questionId` int NOT NULL,
  `Question` varchar(100) NOT NULL,
  `activityId` int DEFAULT NULL,
  PRIMARY KEY (`questionId`),
  KEY `fk_questionTitle_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_questionTitle_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionTitle`
--

LOCK TABLES `questionTitle` WRITE;
/*!40000 ALTER TABLE `questionTitle` DISABLE KEYS */;
/*!40000 ALTER TABLE `questionTitle` ENABLE KEYS */;
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
  `status` enum('registered','selected','confirmed','success','review') NOT NULL,
  `activityId` int NOT NULL,
  PRIMARY KEY (`registrationId`),
  UNIQUE KEY `registrationId_UNIQUE` (`registrationId`),
  KEY `fk_Registration_Users1_idx` (`userId`),
  KEY `fk_Registration_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_Registration_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE,
  CONSTRAINT `fk_Registration_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
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
  CONSTRAINT `fk_requirements_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE,
  CONSTRAINT `fk_requirements_medicalInfomation1` FOREIGN KEY (`medicalInfomation`) REFERENCES `medicalInfomation` (`idmedicalInfomation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
  `role` enum('user','activityOwner','admin') NOT NULL,
  `emergencyPhoneNumber` varchar(45) NOT NULL,
  `profileImg` varchar(300) DEFAULT NULL,
  `line` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `x` varchar(100) DEFAULT NULL,
  `createTime` timestamp NOT NULL,
  `updateTime` timestamp NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1','password123','John','Doe','JD123','john.doe@email.com','Male','1990-05-15','Christian','+1234567890','123 Main St, City, Country','user','+0987654321','profile1.jpg','john_doe_line','john_doe_instagram','john_doe_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(2,'user2','password456','Jane','Smith','JS456','jane.smith@email.com','Female','1985-08-20','Buddhist','+9876543210','456 Elm St, City, Country','activityOwner','+1234509876','profile2.jpg','jane_smith_line','jane_smith_instagram','jane_smith_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(3,'admin1','adminpassword','Admin','User','Admin123','admin@email.com','Other','1970-01-01','None','+1111111111','789 Oak St, City, Country','admin','+2222222222','admin_profile.jpg','admin_line','admin_instagram','admin_x','2023-10-09 07:50:00','2023-10-09 07:50:00'),(4,'user3','userpass123','Alice','Johnson','AJ123','alice@email.com','Female','1995-03-10','Hindu','+3333333333','789 Elm St, City, Country','user','+3333333333','alice_profile.jpg','alice_line','alice_instagram','alice_x','2023-01-15 05:30:00','2023-01-15 05:30:00'),(5,'user4','userpass456','Bob','Williams','BW456','bob@email.com','Male','1988-11-25','Atheist','+4444444444','123 Oak St, City, Country','user','+4444444444','bob_profile.jpg','bob_line','bob_instagram','bob_x','2023-01-16 02:45:00','2023-01-16 02:45:00'),(6,'activityOwner1','activitypass123','Sarah','Miller','SM123','sarah@email.com','Female','1980-07-05','Jewish','+5555555555','456 Pine St, City, Country','activityOwner','+5555555555','sarah_profile.jpg','sarah_line','sarah_instagram','sarah_x','2023-01-17 07:20:00','2023-01-17 07:20:00'),(7,'activityOwner2','activitypass456','Michael','Brown','MB456','michael@email.com','Male','1982-04-12','Christian','+6666666666','789 Maple St, City, Country','activityOwner','+6666666666','michael_profile.jpg','michael_line','michael_instagram','michael_x','2023-01-18 11:10:00','2023-01-18 11:10:00'),(8,'admin2','adminpassword2','Admin','User2','Admin234','admin2@email.com','Other','1975-02-15','None','+7777777777','456 Cedar St, City, Country','admin','+7777777777','admin2_profile.jpg','admin2_line','admin2_instagram','admin2_x','2023-01-19 14:05:00','2023-01-19 14:05:00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userActivityHistory`
--

DROP TABLE IF EXISTS `userActivityHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userActivityHistory` (
  `activityHistoryId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `activityId` int NOT NULL,
  PRIMARY KEY (`activityHistoryId`),
  KEY `fk_activityHistory_Users1_idx` (`userId`),
  KEY `fk_activityHistory_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_activityHistory_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE,
  CONSTRAINT `fk_activityHistory_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userActivityHistory`
--

LOCK TABLES `userActivityHistory` WRITE;
/*!40000 ALTER TABLE `userActivityHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `userActivityHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userMedicalInfo`
--

DROP TABLE IF EXISTS `userMedicalInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userMedicalInfo` (
  `congenitalDiseasesID` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `medicalInfomation` int NOT NULL,
  PRIMARY KEY (`congenitalDiseasesID`),
  KEY `fk_congenitalDiseases_Users1_idx` (`userId`),
  KEY `fk_CongenitalDiseases_medicalInfomation1_idx` (`medicalInfomation`),
  CONSTRAINT `fk_CongenitalDiseases_medicalInfomation1` FOREIGN KEY (`medicalInfomation`) REFERENCES `medicalInfomation` (`idmedicalInfomation`),
  CONSTRAINT `fk_congenitalDiseases_Users1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userMedicalInfo`
--

LOCK TABLES `userMedicalInfo` WRITE;
/*!40000 ALTER TABLE `userMedicalInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `userMedicalInfo` ENABLE KEYS */;
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
  `validationType` enum('QRCode','stepCounter','GPS','heartRate','distanceCal') DEFAULT NULL,
  `validationRule` double NOT NULL,
  PRIMARY KEY (`validationId`),
  KEY `fk_Validation_Activity1_idx` (`activityId`),
  CONSTRAINT `fk_Validation_Activity1` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `validation`
--

LOCK TABLES `validation` WRITE;
/*!40000 ALTER TABLE `validation` DISABLE KEYS */;
/*!40000 ALTER TABLE `validation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-19  4:07:34
