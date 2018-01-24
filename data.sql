use stockanalyses_prod;
-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: stockanalyses_prod
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

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
-- Dumping data for table `bonds`
--

LOCK TABLES `bonds` WRITE;
/*!40000 ALTER TABLE `bonds` DISABLE KEYS */;
REPLACE INTO `bonds` VALUES
(1,'Bitcoin/Euro','XFC000000001',0,'2017-12-09 18:55:05','admin','2017-12-09 18:55:05','admin'),
(2,'Bitcoin/US-Dollar','XFC000000002',0,'2017-12-10 15:23:07','admin','2017-12-10 15:23:07','admin'),
(3,'Litecoin/US-Dollar','XFC000000003',0,now(),'admin',now(),'admin'),
(4,'Litecoin/Bitcoin','XFC000000004',0,now(),'admin',now(),'admin'),
(5,'Ethereum/US-Dollar','XFC000000005',0,now(),'admin',now(),'admin'),
(6,'Ethereum/Bitcoin','XFC000000006',0,now(),'admin',now(),'admin'),
(7,'Ethereum Classic/Bitcoin','XFC000000007',0,now(),'admin',now(),'admin'),
(8,'Ethereum Classic/US-Dollar','XFC000000008',0,now(),'admin',now(),'admin'),
(9,'Recovery Right Token/US-Dollar','XFC000000009',0,now(),'admin',now(),'admin'),
(10,'Recovery Right Token/Bitcoin','XFC000000010',0,now(),'admin',now(),'admin'),
(11,'Zcash/US-Dollar','XFC000000011',0,nnow(),'admin',now(),'admin'),
(12,'Zcash/Bitcoin','XFC000000012',0,now(),'admin',now(),'admin'),
(13,'Monero/US-Dollar','XFC000000013',0,now(),'admin',now(),'admin'),
(14,'Moneroe/Bitcoin','XFC000000014',0,now(),'admin',now(),'admin'),
(15,'Dashcoin/US-Dollar','XFC000000015',0,now(),'admin',now(),'admin'),
(16,'Dashcoin/Bitcoin','XFC000000016',0,now(),'admin',now(),'admin'),
(17,'Ripple/US-Dollar','XFC000000017',0,now(),'admin',now(),'admin'),
(18,'Ripple/Bitcoin','XFC000000018',0,now(),'admin',now(),'admin'),
(19,'IOTA/US-Dollar','XFC000000019',0,now(),'admin',now(),'admin'),
(20,'IOTA/Bitcoin','XFC000000020',0,now(),'admin',now(),'admin'),
(21,'IOTA,/Ethereum','XFC000000021',0,now(),'admin',now(),'admin'),
(22,'EOS/US-Dollar','XFC000000022',0,now(),'admin',now(),'admin'),
(23,'EOS/Bitcoin','XFC000000023',0,now(),'admin',now(),'admin'),
(24,'EOS/Ethereum','XFC000000024',0,now(),'admin',now(),'admin'),
(25,'Santiment/US-Dollar','XFC000000025',0,now(),'admin',now(),'admin'),
(26,'Santiment/Bitoin','XFC000000026',0,now(),'admin',now(),'admin'),
(27,'Santiment/Ethereum','XFC000000027',0,now(),'admin',now(),'admin'),
(28,'OmiseGO/US-Dollar','XFC000000028',0,now(),'admin',now(),'admin'),
(29,'OmiseGO/Bitcoin','XFC000000029',0,now(),'admin',now(),'admin'),
(30,'OmiseGO/Ethereum','XFC000000030',0,now(),'admin',now(),'admin'),
(31,'Bitcoin Cash/US-Dollar','XFC000000031',0,now(),'admin',now(),'admin'),
(32,'Bitcoin Cash/Bitcoin','XFC000000032',0,now(),'admin',now(),'admin'),
(33,'Bitcoin Cash/Ethereum','XFC000000033',0,now(),'admin',now(),'admin'),
(34,'NEO/US-DOllar','XFC000000034',0,now(),'admin',now(),'admin'),
(35,'NEO/Bitcoin','XFC000000035',0,now(),'admin',now(),'admin'),
(36,'NEO/Ethereum','XFC000000036',0,now(),'admin',now(),'admin'),
(37,'Metaverse ETP/US-Dollar','XFC000000037',0,now(),'admin',now(),'admin'),
(38,'Metaverse ETP/Bitcoin','XFC000000038',0,now(),'admin',now(),'admin'),
(39,'Metaverse ETP/Ethereum','XFC000000039',0,now(),'admin',now(),'admin'),
(40,'Qtum/US-Dollar','XFC000000040',0,now(),'admin',now(),'admin'),
(41,'Qtum/Bitcoin','XFC000000041',0,now(),'admin',now(),'admin'),
(42,'Qtum/Ethereum','XFC000000042',0,now(),'admin',now(),'admin'),
(43,'AventCoin/US-Dollar','XFC000000043',0,now(),'admin',now(),'admin'),
(44,'AventCoin/Bitcoin','XFC000000044',0,now(),'admin',now(),'admin'),
(45,'AventCoin/Ethereum','XFC000000045',0,now(),'admin',now(),'admin'),
(46,'Eidoo/US-Dollar','XFC000000046',0,now(),'admin',now(),'admin'),
(47,'Eidoo/Bitcoin','XFC000000047',0,now(),'admin',now(),'admin'),
(48,'Eidoo/Ethereum','XFC000000048',0,now(),'admin',now(),'admin'),
(49,'Bitcoin Gold/US-Dollar','XFC000000049',0,now(),'admin',now(),'admin'),
(50,'Bitcoin Gold/Bitcoin','XFC000000050',0,now(),'admin',now(),'admin'),
(51,'Datum/US-DOllar','XFC000000051',0,now(),'admin',now(),'admin'),
(52,'Datum/Bitcoin','XFC000000052',0,now(),'admin',now(),'admin'),
(53,'Datum/Ethereum','XFC000000053',0,now(),'admin',now(),'admin'),
(54,'Qash/US-Dollar','XFC000000054',0,now(),'admin',now(),'admin'),
(55,'Qash/Bitcoin','XFC000000055',0,now(),'admin',now(),'admin'),
(56,'Qash/Ethereum','XFC000000056',0,now(),'admin',now(),'admin'),
(57,'Yoyow/US-Dollar','XFC000000057',0,now(),'admin',now(),'admin'),
(58,'Yoyow/Bitcoin','XFC000000058',0,now(),'admin',now(),'admin'),
(59,'Yoyow/Ethereum','XFC000000059',0,now(),'admin',now(),'admin'),
(60,'Golem/US-Dollar','XFC000000060',0,now(),'admin',now(),'admin'),
(61,'Golem/Bitocin','XFC000000061',0,now(),'admin',now(),'admin'),
(62,'Golem/Ethereum','XFC000000062',0,now(),'admin',now(),'admin'),
(63,'Status Network Token/US-Dollar','XFC000000063',0,now(),'admin',now(),'admin'),
(64,'Status Network Token/Bitcoin','XFC000000064',0,now(),'admin',now(),'admin'),
(65,'Status Network Token/Ethereum','XFC000000065',0,now(),'admin',now(),'admin'),
(66,'IOTA/Euro','XFC000000066',0,now(),'admin',now(),'admin'),
(67,'Basic Attention Token/US-Dollar','XFC000000067',0,now(),'admin',now(),'admin'),
(68,'Basic Attention Token/Bitcoin','XFC000000068',0,now(),'admin',now(),'admin'),
(69,'Basic Attention Token/Ethereum','XFC000000069',0,now(),'admin',now(),'admin'),
(70,'Decentraland/US-Dollar','XFC000000070',0,now(),'admin',now(),'admin'),
(71,'Decentraland/Bitcoin','XFC000000071',0,now(),'admin',now(),'admin'),
(72,'Decentraland/Ethereum','XFC000000072',0,now(),'admin',now(),'admin'),
(73,'FunFair/US-Dollar','XFC000000073',0,now(),'admin',now(),'admin'),
(74,'FunFair/Bitcoin','XFC000000074',0,now(),'admin',now(),'admin'),
(75,'FunFair/Ethereum','XFC000000075',0,now(),'admin',now(),'admin'),
(76,'0x/US-Dollar','XFC000000076',0,now(),'admin',now(),'admin'),
(77,'0x/Bitcoin','XFC000000077',0,now(),'admin',now(),'admin'),
(78,'0x/Ethereum','XFC000000078',0,now(),'admin',now(),'admin'),
(79,'Time New Bank/US-Dollar','XFC000000079',0,now(),'admin',now(),'admin'),
(80,'Time New Bank/Bitcoin','XFC000000080',0,now(),'admin',now(),'admin'),
(81,'Time New Bank/Ethereum','XFC000000081',0,now(),'admin',now(),'admin'),
(82,'SpankChain/US-Dollar','XFC000000082',0,now(),'admin',now(),'admin'),
(83,'SpankChain/Bitcoin','XFC000000083',0,now(),'admin',now(),'admin'),
(84,'SpankChain/Ethereum','XFC000000084',0,now(),'admin',now(),'admin');

/*!40000 ALTER TABLE `bonds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
REPLACE INTO `countries` VALUES
(1,'DEU','Germand','2017-12-05 21:26:00','admin','2017-12-05 21:26:00','admin'),
(2,'GBR','Great Britain','2017-12-05 21:26:00','admin','2017-12-05 21:26:00','admin');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `exchanges`
--

LOCK TABLES `exchanges` WRITE;
/*!40000 ALTER TABLE `exchanges` DISABLE KEYS */;
REPLACE INTO `exchanges` VALUES
(3,'Bitstamp Ltd.','BTSP','GBR',6,'2017-12-05 21:38:26','admin','2017-12-21 17:23:48','admin'),
(4,'iFinex Inc.','BTFX','GBR',3,'2017-12-05 21:38:26','admin','2017-12-21 17:23:48','admin');
/*!40000 ALTER TABLE `exchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `exchange_to_trade`
--

LOCK TABLES `exchange_to_trade` WRITE;
/*!40000 ALTER TABLE `exchange_to_trade` DISABLE KEYS */;
REPLACE INTO `exchange_to_trade` VALUES
(6,1,3,0,'2017-12-10 19:23:45','admin','2017-12-10 19:23:45','admin'),
(7,1,4,0,'2017-12-21 11:36:46','admin','2017-12-21 11:36:46','admin'),
(8,2,4,0,'2018-01-17 22:05:52','admin','2018-01-17 22:05:52','admin');
/*!40000 ALTER TABLE `exchange_to_trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `indicator`
--

LOCK TABLES `indicator` WRITE;
/*!40000 ALTER TABLE `indicator` DISABLE KEYS */;
REPLACE INTO `indicator` VALUES
(1,'sma','Simple Moving Average','2017-10-18 07:47:52','admin','2017-10-18 07:47:52','admin'),
(2,'macd','Moving Average Convergence/Divergence','2017-10-18 07:50:34','admin','2017-10-18 07:50:34','admin');
/*!40000 ALTER TABLE `indicator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `trade_fee`
--

LOCK TABLES `trade_fee` WRITE;
/*!40000 ALTER TABLE `trade_fee` DISABLE KEYS */;
/*!40000 ALTER TABLE `trade_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
REPLACE INTO `type` VALUES
(1,'stock','2017-06-30 16:53:13','admin','2017-06-30 16:53:13','admin'),
(2,'crypto_currency','2017-06-30 16:53:13','admin','2017-06-30 16:53:13','admin'),
(3,'portfolio','2017-08-21 21:33:04','admin','2017-08-21 21:33:04','admin'),
(4,'enabled','2017-08-21 21:45:35','admin','2017-08-21 21:45:35','admin'),
(5,'watchlist','2017-08-21 21:50:09','admin','2017-08-21 21:50:09','admin'),
(6,'disabled','2017-08-22 07:39:17','admin','2017-08-22 07:39:17','admin'),
(7,'buy','2017-08-22 07:46:01','admin','2017-08-22 07:46:01','admin'),
(8,'sell','2017-08-22 07:46:01','admin','2017-08-22 07:46:01','admin'),
(9,'hold','2017-08-22 07:46:01','admin','2017-08-22 07:46:01','admin'),
(10,'add','2017-08-22 07:48:14','admin','2017-08-22 07:48:14','admin'),
(11,'delete','2017-08-22 07:48:14','admin','2017-08-22 07:48:14','admin'),
(12,'update','2017-08-22 07:48:14','admin','2017-08-22 07:48:14','admin');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
REPLACE INTO `users` VALUES
(1,'admin','',2,'123456','DEU',3,'2017-06-30 16:53:13','admin','2017-06-30 16:53:13','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-19  8:29:07
