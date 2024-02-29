-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: wonder
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'dphiane@yahoo.fr','[]','$2y$13$R1Qe.rY92mRWmgGeG4V8DOS4n0fkMkHAeMe5b2t9mT6NYzW6SSHVi','Dominique','Phiane','https://randomuser.me/api/portraits/women/44.jpg'),(2,'azerty@gmail.com','[]','$2y$13$K2IKUiIcG4rcBbu4k12UBObvsyQhCH8pZfiM1oQNrEUQ5Hqg8Bg7.','azerty','gmail','\'https://randomuser.me/api/portraits/women/45.jpg\''),(4,'azerty@azerty.com','[]','$2y$13$ZNiFzQ1vCNawjTOsZJZ6meDjtIyLunEAl.Pf7n7fBKIgsqBnIlt0y','azerty','qwerty','https://randomuser.me/api/portraits/women/20.jpg'),(6,'wonder@wonder.fr','[]','$2y$13$vTlTW0eg45Mo/f9pqsPwyedjDPaBcXk64DaB57zzVP5vyvQKHYCQa','wonder','wonder','https://randomuser.me/api/portraits/women/44.jpg'),(10,'azerty@azerty.c','[]','$2y$13$0rKI0iA5.D2TLsRJU8lOmeY0quPMQiE7dv84XG/xXDLzCmLiMv4ly','Domi','PHi','https://randomuser.me/api/portraits/women/44.jpg'),(12,'azey@azerty.com','[]','$2y$13$5ln8ach5ZNGqviv37aFjsu9p2zdqxoix1CrCUytRtib1RXn.do9je','Domi','qwerty','profiles/a7792a84800dac74e87a.webp'),(13,'erty@azerty.com','[]','$2y$13$9YWM1D9QTVThjhXUAViVHe9Lv9obHYmzdZcVR3fA3BttZl5zuvjWe','azerty','qwerty','profiles/a4b00aaca56c3ef2f59f.png'),(14,'azertyee@azerty.com','[]','$2y$13$5uu0GSPeOk7I3Jb7VruxCOcq/6uuA/qk33GYOSC9pEFFFvajxLfza','Domi','PHi','profiles/0cfd20e587c0cf7d968d.png');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-29 21:56:05
