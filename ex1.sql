/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 10.4.6-MariaDB : Database - ex1
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ex1` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `ex1`;

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `boardId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `displayStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `title` char(200) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `hit` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `article` */

insert  into `article`(`id`,`regDate`,`updateDate`,`delDate`,`delStatus`,`boardId`,`memberId`,`displayStatus`,`title`,`body`,`hit`) values 
(1,'2020-08-31 10:27:13','2020-08-31 10:27:13',NULL,0,1,1,1,'제목``','내용``',0),
(2,'2020-08-31 10:27:14','2020-08-31 10:27:14',NULL,0,1,1,1,'제목``','내용``',0),
(3,'2020-08-31 10:27:14','2020-08-31 10:27:14',NULL,0,1,1,1,'제목``','내용``',0),
(4,'2020-08-31 10:27:14','2020-08-31 10:27:14',NULL,0,1,1,1,'제목``','내용``',0),
(5,'2020-08-31 10:27:14','2020-08-31 10:27:14',NULL,0,1,1,1,'제목``','내용``',0),
(6,'2020-08-31 10:27:15','2020-08-31 10:27:15',NULL,0,1,1,1,'제목``','내용``',0),
(7,'2020-08-31 10:27:15','2020-08-31 10:27:15',NULL,0,1,1,1,'제목``','내용``',0),
(8,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(9,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(10,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(11,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(12,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(13,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(14,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(15,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(16,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(17,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(18,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(19,'2020-08-31 10:27:16','2020-08-31 10:27:16',NULL,0,1,1,1,'제목``','내용``',0),
(20,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(21,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(22,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(23,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(24,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(25,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(26,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(27,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(28,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',1),
(29,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(30,'2020-08-31 10:27:17','2020-08-31 10:27:17',NULL,0,1,1,1,'제목``','내용``',0),
(31,'2020-08-31 10:27:18','2020-08-31 10:27:18',NULL,0,1,1,1,'제목``','내용``',1),
(32,'2020-08-31 10:27:18','2020-08-31 10:27:18',NULL,0,1,1,1,'제목``','내용``',0),
(33,'2020-08-31 10:27:20','2020-08-31 10:27:20',NULL,0,1,1,1,'제목``','내용``',0),
(34,'2020-08-31 10:27:20','2020-08-31 10:27:20',NULL,0,1,1,1,'제목``','내용``',0),
(35,'2020-08-31 10:27:20','2020-08-31 10:27:20',NULL,0,1,1,1,'제목``','내용``',7),
(36,'2020-08-31 10:27:40','2020-08-31 10:27:40',NULL,0,2,1,1,'제목``','내용``',0),
(37,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(38,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(39,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(40,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(41,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(42,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(43,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(44,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(45,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(46,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(47,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(48,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(49,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(50,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(51,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(52,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(53,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(54,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(55,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(56,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(57,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(58,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(59,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(60,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(61,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(62,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(63,'2020-08-31 10:27:41','2020-08-31 10:27:41',NULL,0,2,1,1,'제목``','내용``',0),
(64,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(65,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(66,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(67,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(68,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(69,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(70,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(71,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(72,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(73,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(74,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(75,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(76,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(77,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(78,'2020-08-31 10:27:42','2020-08-31 10:27:42',NULL,0,2,1,1,'제목``','내용``',0),
(79,'2020-08-31 10:27:43','2020-08-31 10:27:43',NULL,0,2,1,1,'제목``','내용``',13),
(80,'2020-08-31 10:28:01','2020-08-31 10:28:01',NULL,0,1,2,1,'aaaa','aaaa',0),
(81,'2020-08-31 10:28:01','2020-08-31 10:28:01',NULL,0,1,2,1,'aaaa','aaaa',0),
(82,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(83,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(84,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(85,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(86,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(87,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(88,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(89,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(90,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(91,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(92,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(93,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(94,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(95,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(96,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(97,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(98,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(99,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(100,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(101,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(102,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(103,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(104,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(105,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(106,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(107,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(108,'2020-08-31 10:28:02','2020-08-31 10:28:02',NULL,0,1,2,1,'aaaa','aaaa',0),
(109,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(110,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(111,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(112,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(113,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(114,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(115,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(116,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(117,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(118,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(119,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(120,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(121,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(122,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(123,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(124,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(125,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(126,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(127,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(128,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(129,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(130,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(131,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(132,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(133,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(134,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(135,'2020-08-31 10:28:03','2020-08-31 10:28:03',NULL,0,1,2,1,'aaaa','aaaa',0),
(136,'2020-08-31 10:28:04','2020-08-31 10:28:04',NULL,0,1,2,1,'aaaa','aaaa',0),
(137,'2020-08-31 10:28:04','2020-08-31 10:28:04',NULL,0,1,2,1,'aaaa','aaaa',0),
(138,'2020-08-31 10:28:04','2020-08-31 10:28:04',NULL,0,1,2,1,'aaaa','aaaa',0),
(139,'2020-08-31 10:28:04','2020-08-31 10:28:04',NULL,0,1,2,1,'aaaa','aaaa',0),
(140,'2020-08-31 10:28:04','2020-08-31 10:28:04',NULL,0,1,2,1,'aaaa','aaaa',0),
(141,'2020-08-31 10:28:04','2020-08-31 10:28:04',NULL,0,1,2,1,'aaaa','aaaa',0),
(142,'2020-08-31 10:28:07','2020-08-31 10:28:07',NULL,0,2,2,1,'aaaa','aaaa',0),
(143,'2020-08-31 10:28:07','2020-08-31 10:28:07',NULL,0,2,2,1,'aaaa','aaaa',0),
(144,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(145,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(146,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(147,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(148,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(149,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(150,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(151,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(152,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(153,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(154,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(155,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(156,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(157,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(158,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(159,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(160,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(161,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(162,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(163,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(164,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(165,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(166,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(167,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(168,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(169,'2020-08-31 10:28:08','2020-08-31 10:28:08',NULL,0,2,2,1,'aaaa','aaaa',0),
(170,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(171,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(172,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(173,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(174,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(175,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(176,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(177,'2020-08-31 10:28:09','2020-08-31 10:28:09',NULL,0,2,2,1,'aaaa','aaaa',0),
(178,'2020-08-31 11:12:21','2020-08-31 11:12:21',NULL,0,2,3,1,'aa','aa',15);

/*Table structure for table `articleLike` */

DROP TABLE IF EXISTS `articleLike`;

CREATE TABLE `articleLike` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `articleId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `point` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `articleLike` */

insert  into `articleLike`(`id`,`regDate`,`articleId`,`memberId`,`point`) values 
(1,'2020-08-31 11:12:29',35,3,1);

/*Table structure for table `attr` */

DROP TABLE IF EXISTS `attr`;

CREATE TABLE `attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `relTypeCode` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `typeCode` char(30) COLLATE utf8_unicode_ci NOT NULL,
  `type2Code` char(30) COLLATE utf8_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relTypeCode` (`relTypeCode`,`relId`,`typeCode`,`type2Code`),
  KEY `relTypeCode_2` (`relTypeCode`,`typeCode`,`type2Code`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `attr` */

insert  into `attr`(`id`,`regDate`,`updateDate`,`relTypeCode`,`relId`,`typeCode`,`type2Code`,`value`) values 
(9,'2020-08-31 11:06:18','2020-09-02 10:25:14','member',3,'extra','emailAuthCode','90446a4f-1188-4171-840b-4f75e99571c0'),
(10,'2020-08-31 11:06:18','2020-08-31 11:06:18','member',3,'extra','lastPasswordChangeDate','2020-08-31 11:06:18'),
(11,'2020-08-31 11:06:18','2020-08-31 11:07:09','member',3,'extra','emailAuthed','tmdqjaha12@naver.com'),
(20,'2020-08-31 11:11:45','2020-09-02 12:17:31','member',1,'extra','emailAuthCode','8b2817ec-5a59-47cf-b1ca-8850bfed9c67'),
(21,'2020-08-31 11:11:47','2020-08-31 11:11:47','member',1,'extra','lastPasswordChangeDate','2020-08-31 11:06:18'),
(22,'2020-08-31 11:11:49','2020-08-31 11:11:49','member',1,'extra','emailAuthed','admin@admin.com');

/*Table structure for table `board` */

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `code` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `memberId` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `board` */

insert  into `board`(`id`,`regDate`,`updateDate`,`delDate`,`delStatus`,`code`,`name`,`memberId`) values 
(1,'2020-08-31 10:28:19','2020-08-31 10:28:19',NULL,0,'notice','공지',1),
(2,'2020-09-01 13:45:41','2020-09-01 13:45:41',NULL,0,'question','문의',1),
(31,'2020-09-01 13:46:02','2020-09-01 13:46:02',NULL,0,'ip8q1et01a','33',3),
(32,'2020-09-02 09:53:50','2020-09-02 09:53:50',NULL,0,'syej9onlvl','22',3),
(33,'2020-09-02 09:58:16','2020-09-02 09:58:16',NULL,0,'4d230xawhy','00',1),
(35,'2020-09-02 10:02:28','2020-09-02 10:02:28',NULL,0,'oz763h8zz8','123',1),
(36,'2020-09-02 12:09:04','2020-09-02 12:09:04',NULL,0,'ozi2436vgz','44',3),
(37,'2020-09-02 12:09:13','2020-09-02 12:09:13',NULL,0,'ertjvo9vsf','4',3),
(38,'2020-09-02 12:12:04','2020-09-02 12:12:04',NULL,0,'brtaxld8f3','11',1),
(39,'2020-09-02 12:13:48','2020-09-02 12:13:48',NULL,0,'ntdotg5ecr','112',1),
(40,'2020-09-02 12:18:27','2020-09-02 12:18:27',NULL,0,'ukucy5os30','adada',1);

/*Table structure for table `boardApplyDoc` */

DROP TABLE IF EXISTS `boardApplyDoc`;

CREATE TABLE `boardApplyDoc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `applyStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `memberId` int(10) unsigned NOT NULL,
  `name` char(200) COLLATE utf8_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `boardId` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `boardApplyDoc` */

insert  into `boardApplyDoc`(`id`,`regDate`,`updateDate`,`delDate`,`delStatus`,`applyStatus`,`memberId`,`name`,`body`,`boardId`) values 
(23,'2020-09-01 13:45:36','2020-09-02 12:12:04',NULL,1,1,3,'11','11',30),
(24,'2020-09-01 13:45:47','2020-09-02 09:53:50',NULL,1,1,3,'22','22',32),
(25,'2020-09-01 13:45:53','2020-09-01 13:46:02',NULL,0,1,3,'33','33',31),
(27,'2020-09-02 09:36:45','2020-09-02 12:09:04',NULL,0,1,3,'44','44',36),
(30,'2020-09-02 09:50:11','2020-09-02 09:53:50',NULL,0,1,3,'22','22',32),
(31,'2020-09-02 09:50:16','2020-09-02 09:53:50',NULL,0,1,3,'22','22',32),
(32,'2020-09-02 09:52:05','2020-09-02 09:53:50',NULL,0,1,3,'22','22',32),
(33,'2020-09-02 09:52:14','2020-09-02 12:09:13',NULL,0,1,3,'4','44',37),
(34,'2020-09-02 09:56:53','2020-09-02 10:24:37',NULL,1,0,3,'00','00',0),
(35,'2020-09-02 09:57:51','2020-09-02 10:24:37',NULL,1,0,3,'00','00',0),
(36,'2020-09-02 09:58:04','2020-09-02 09:58:16',NULL,0,1,1,'00','00',33),
(37,'2020-09-02 10:02:11','2020-09-02 10:02:28',NULL,1,1,1,'123','123',35),
(38,'2020-09-02 10:02:23','2020-09-02 10:02:28',NULL,1,0,3,'123','123',0),
(39,'2020-09-02 12:11:38','2020-09-02 12:12:04',NULL,1,1,1,'11','11',38),
(40,'2020-09-02 12:11:59','2020-09-02 12:12:04',NULL,1,1,1,'11','11',38),
(41,'2020-09-02 12:13:42','2020-09-02 12:13:48',NULL,1,1,1,'112','112',39),
(42,'2020-09-02 12:18:22','2020-09-02 12:18:27',NULL,0,1,1,'adada','dasads',40);

/*Table structure for table `boardDetailList` */

DROP TABLE IF EXISTS `boardDetailList`;

CREATE TABLE `boardDetailList` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `boardId` int(10) unsigned NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `displayStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` char(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `boardDetailList` */

/*Table structure for table `file` */

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `relTypeCode` char(50) COLLATE utf8_unicode_ci NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `originFileName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fileExt` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `typeCode` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `type2Code` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `fileSize` int(10) unsigned NOT NULL,
  `fileExtTypeCode` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `fileExtType2Code` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `fileNo` tinyint(2) unsigned NOT NULL,
  `body` longblob DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `relId` (`relId`,`relTypeCode`,`typeCode`,`type2Code`,`fileNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `file` */

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `loginId` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `loginPw` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `name` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `nickname` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `cellphoneNo` char(30) COLLATE utf8_unicode_ci NOT NULL,
  `level` int(1) unsigned NOT NULL DEFAULT 0,
  `delStatus` int(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginId` (`loginId`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `member` */

insert  into `member`(`id`,`regDate`,`updateDate`,`loginId`,`loginPw`,`name`,`nickname`,`email`,`cellphoneNo`,`level`,`delStatus`) values 
(1,'2020-08-31 10:50:09','2020-08-31 10:50:09','admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','admin','admin','admin@admin.com','',10,0),
(3,'2020-08-31 11:06:18','2020-08-31 11:06:18','aaaaa','ed968e840d10d2d313a870bc131a4e2c311d7ad09bdf32b3418147221f51a6e2','aaaaa','aaaaa','tmdqjaha12@naver.com','',1,0);

/*Table structure for table `reply` */

DROP TABLE IF EXISTS `reply`;

CREATE TABLE `reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `delDate` datetime DEFAULT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `displayStatus` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(50) COLLATE utf8_unicode_ci NOT NULL,
  `relId` int(10) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relId` (`relId`,`relTypeCode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `reply` */

insert  into `reply`(`id`,`regDate`,`updateDate`,`delDate`,`delStatus`,`displayStatus`,`memberId`,`relTypeCode`,`relId`,`body`) values 
(1,'2020-08-31 10:32:55','2020-08-31 10:32:55',NULL,0,1,1,'article',10,'내용1'),
(2,'2020-09-02 12:22:00','2020-09-02 12:22:00',NULL,0,1,1,'article',178,'ada');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
