-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: crm
-- ------------------------------------------------------
-- Server version	5.7.33-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `concerns`
--

DROP TABLE IF EXISTS `concerns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concerns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Группы поставщиков';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concerns`
--

LOCK TABLES `concerns` WRITE;
/*!40000 ALTER TABLE `concerns` DISABLE KEYS */;
INSERT INTO `concerns` VALUES (1,'Non Dapibus Rutrum Corp.'),(2,'Nibh Foundation'),(3,'Blandit Institute'),(4,'Ullamcorper Velit Industries'),(5,'Tellus Foundation');
/*!40000 ALTER TABLE `concerns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='Отделы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Head'),(2,'IT'),(3,'Marketing'),(4,'Sales'),(5,'Legal'),(6,'Technical'),(7,'HR');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_types`
--

DROP TABLE IF EXISTS `doc_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='Типы документов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_types`
--

LOCK TABLES `doc_types` WRITE;
/*!40000 ALTER TABLE `doc_types` DISABLE KEYS */;
INSERT INTO `doc_types` VALUES (1,'Contract'),(2,'Supplementary agreement'),(3,'Specification'),(4,'Other');
/*!40000 ALTER TABLE `doc_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(200) DEFAULT NULL,
  `description` text,
  `size` int(11) DEFAULT NULL,
  `status_id` bigint(10) unsigned NOT NULL,
  `doc_type_id` bigint(10) unsigned NOT NULL,
  `supplier_id` bigint(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `documents_name` (`filename`),
  KEY `status_id` (`status_id`),
  KEY `doc_type_id` (`doc_type_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `doc_filename` (`filename`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `statuses` (`id`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`doc_type_id`) REFERENCES `doc_types` (`id`),
  CONSTRAINT `documents_ibfk_3` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COMMENT='Документы поставщиков';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'aliquet molestie tellus.','sollicitudin a, malesuada id,',2937,2,3,1,'2022-02-14 20:59:41',NULL),(2,'bibendum ullamcorper.','magna nec quam. Curabitur',4097,3,2,4,'2022-02-14 20:59:41',NULL),(3,'Cras vehicula aliquet','quis, pede. Praesent eu dui. Cum sociis natoque',259,2,1,1,'2022-02-14 20:59:41',NULL),(4,'lobortis augue scelerisque','Sed auctor odio a purus. Duis elementum,',4023,3,3,9,'2022-02-14 20:59:41',NULL),(5,'rhoncus. Donec','mollis dui, in sodales elit erat',2645,2,2,6,'2022-02-14 20:59:41',NULL),(6,'quis, tristique','et magnis dis',8820,2,3,4,'2022-02-14 20:59:41',NULL),(7,'ullamcorper, velit','at fringilla',9367,2,2,2,'2022-02-14 20:59:41',NULL),(8,'aliquam arcu. Aliquam','odio',1315,2,3,4,'2022-02-14 20:59:41',NULL),(9,'mauris. Morbi','consequat auctor, nunc nulla',1810,2,2,10,'2022-02-14 20:59:41',NULL),(10,'Donec','dignissim pharetra. Nam ac nulla. In tincidunt',3998,2,3,10,'2022-02-14 20:59:41',NULL),(11,'elementum, lorem ut','et tristique pellentesque, tellus sem',4239,1,4,7,'2022-02-15 23:53:36',NULL),(12,'erat vel','vel turpis. Aliquam adipiscing',8459,2,2,7,'2022-02-15 23:53:36',NULL),(13,'eget laoreet','tincidunt adipiscing. Mauris molestie pharetra',5194,3,3,9,'2022-02-15 23:53:36',NULL),(14,'cursus','lacinia mattis. Integer eu lacus. Quisque imperdiet,',7077,2,2,7,'2022-02-15 23:53:36',NULL),(15,'justo. Proin non','amet, consectetuer adipiscing elit. Etiam laoreet, libero',9643,3,2,5,'2022-02-15 23:53:36',NULL),(16,'elementum, dui','tempus non,',9828,3,2,9,'2022-02-15 23:53:36',NULL),(17,'nulla','aliquet, metus urna convallis erat,',3996,3,2,1,'2022-02-15 23:53:36',NULL),(18,'cursus. Nunc mauris','Nam tempor diam dictum',3498,2,1,4,'2022-02-15 23:53:36',NULL),(19,'Donec dignissim','rhoncus. Nullam velit dui, semper et,',2440,1,3,7,'2022-02-15 23:53:36',NULL),(20,'porttitor scelerisque neque.','risus.',7306,3,3,3,'2022-02-15 23:53:36',NULL);
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `supervisor` bigint(10) unsigned NOT NULL,
  `department_id` bigint(10) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `supervisor_id` (`supervisor`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`supervisor`) REFERENCES `employees` (`id`),
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Xander Kerr','m',1,1),(2,'Kathleen Kane','f',1,2),(3,'Zelda Lynn','f',1,3),(4,'Xena Gilliam','f',3,3),(5,'Benjamin Haley','m',1,4),(6,'Faith Bryant','f',3,3),(7,'Colt Roy','m',1,6),(8,'Courtney Moore','f',1,7),(9,'Lane Barton','m',2,2),(10,'Judah Wolfe','m',3,3);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='Регионы компаний';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,'Moscow'),(2,'South'),(3,'North-West'),(4,'Ural'),(5,'West Siberia'),(6,'East Siberia');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spheres`
--

DROP TABLE IF EXISTS `spheres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spheres` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='Сферы деятельности компаний';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spheres`
--

LOCK TABLES `spheres` WRITE;
/*!40000 ALTER TABLE `spheres` DISABLE KEYS */;
INSERT INTO `spheres` VALUES (1,'IT'),(2,'Telecom'),(3,'Manufacturing'),(4,'Trading'),(5,'Consulting'),(6,'Construction'),(7,'Education');
/*!40000 ALTER TABLE `spheres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Статусы документов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` VALUES (1,'Original'),(2,'Copy'),(3,'Project');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_contact_info`
--

DROP TABLE IF EXISTS `sup_contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_contact_info` (
  `sup_id` bigint(20) unsigned NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `yur_adress` varchar(200) DEFAULT NULL,
  `fiz_adress` varchar(200) DEFAULT NULL,
  `INN` varchar(20) DEFAULT NULL,
  `KPP` varchar(20) DEFAULT NULL,
  UNIQUE KEY `sup_id` (`sup_id`),
  CONSTRAINT `sup_contact_info_ibfk_1` FOREIGN KEY (`sup_id`) REFERENCES `suppliers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Контактная информация поставщиков';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_contact_info`
--

LOCK TABLES `sup_contact_info` WRITE;
/*!40000 ALTER TABLE `sup_contact_info` DISABLE KEYS */;
INSERT INTO `sup_contact_info` VALUES (1,'+7 (495) 277-19-11','901-5514 Nec Road','Ap #517-9267 Placerat Av.','79745597021','68154485264'),(2,'+7 (495) 419-31-08','563-2700 Donec St.','7114 Eget Street','81492316457','73618075214'),(3,'+7 (495) 008-11-83','P.O. Box 338, 6517 A Rd.','P.O. Box 540, 7019 Per St.','84858102343','27640181565'),(4,'+7 (495) 372-58-03','7585 Gravida St.','Ap #711-8170 Suspendisse Rd.','19368324816','64452793976'),(5,'+7 (495) 296-81-78','Ap #546-5580 Aliquam Road','Ap #285-6837 Facilisi. Ave','25975435861','98880480441'),(6,'+7 (495) 342-31-79','Ap #886-686 Lacus. Ave','P.O. Box 573, 3790 Aliquam Road','98817987345','69185635492'),(7,'+7 (495) 329-06-86','P.O. Box 728, 5312 Eleifend St.','Ap #171-9284 Erat, St.','19458990645','85465821211'),(8,'+7 (495) 579-61-62','Ap #740-6785 Dis St.','P.O. Box 402, 931 Tempor Ave','66635246465','75227878041'),(9,'+7 (495) 652-95-34','957-5118 Eget, Av.','487-9063 Dolor Av.','92481172981','57175472973'),(10,'+7 (495) 794-32-19','818 Lacus Ave','187-8432 A St.','47473283212','27173526672');
/*!40000 ALTER TABLE `sup_contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `responsible_id` bigint(10) unsigned NOT NULL,
  `concern_id` bigint(10) unsigned NOT NULL,
  `region_id` bigint(10) unsigned NOT NULL,
  `sphere_id` bigint(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  KEY `responsible_employee_id` (`responsible_id`),
  KEY `concern_id` (`concern_id`),
  KEY `region_id` (`region_id`),
  KEY `sphere_id` (`sphere_id`),
  KEY `sup_name` (`name`),
  CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`responsible_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `suppliers_ibfk_2` FOREIGN KEY (`concern_id`) REFERENCES `concerns` (`id`),
  CONSTRAINT `suppliers_ibfk_3` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`),
  CONSTRAINT `suppliers_ibfk_4` FOREIGN KEY (`sphere_id`) REFERENCES `spheres` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='Поставщики';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Non Dapibus Rutrum Corp.',6,2,2,6,'2022-02-14 20:48:45',NULL),(2,'Nibh Foundation',5,3,3,7,'2022-02-14 20:48:45',NULL),(3,'Blandit Institute',5,2,5,5,'2022-02-14 20:48:45',NULL),(4,'Ullamcorper Velit Industries',10,4,4,7,'2022-02-14 20:48:45',NULL),(5,'Tellus Foundation',6,2,2,1,'2022-02-14 20:48:45',NULL),(6,'Nec Luctus Felis Ltd',8,4,2,3,'2022-02-14 20:48:45',NULL),(7,'Dui LLC',4,3,3,2,'2022-02-14 20:48:45',NULL),(8,'Donec Nibh Enim PC',8,1,3,3,'2022-02-14 20:48:45',NULL),(9,'Donec Inc.',5,1,2,6,'2022-02-14 20:48:45',NULL),(10,'Fermentum Risus Corp.',9,4,6,4,'2022-02-14 20:48:45',NULL);
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-15 23:54:46
