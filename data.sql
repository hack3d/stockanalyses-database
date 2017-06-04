use database stockanalyses_prod;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES (1,'Euro','EUR',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(2,'Argentine peso','ARS',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(3,'Australian Dollar','AUD',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(4,'Bulgarian lev','BGN',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(5,'Brazilian real','BRL',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(6,'Bitcoin','BTC',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(7,'Canadian Dollar','CAD',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(8,'Swiss francs','CHF',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(9,'Chilean peso','CLP',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(10,'Chinese renminbi','CNY',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(11,'Czech koruna','CZK',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(12,'Danish kron','DKK',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(13,'Pecunix','GAU',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(14,'British pounds','GBP',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(15,'Hong Kong dollar','HKD',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(16,'Hungarian forit','HUF',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(17,'Israeli new shekel','ILS',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(18,'Indian rupee','INR',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(19,'Japanese yen','JPY',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(20,'Litecoin','LTC',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(21,'Mexican peso','MXN',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(22,'Norwegian kron','NOK',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(23,'New Zealand dollar','NZD',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(24,'Peruvian nuevo sol','PEN',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(25,'Polish zloty','PLN',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(26,'Russian ruble','RUB',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(27,'Saudi Arabian Riyal','SAR',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(28,'Swedish krone','SEK',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(29,'Singapore dollar','SGD',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(30,'Sierra Leonean leone','SLL',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(31,'Thai baht','THB',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(32,'Ukrainian hryvnia','UAH',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(33,'US Dollar','USD',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(34,'Ripple','XRP',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(35,'South African rand','ZAR',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(36,'South Korean won','KRW',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin'),(37,'Namecoin','NMC',1,0,'2017-03-11 16:20:28','admin','2017-03-11 16:20:28','admin');
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `downloader_jq`
--

LOCK TABLES `downloader_jq` WRITE;
/*!40000 ALTER TABLE `downloader_jq` DISABLE KEYS */;
INSERT INTO `downloader_jq` VALUES (1100,'bitstamp#btc#eur',2,0,'2017-05-10 20:00:06','2017-05-06 13:00:08','admin','2017-05-10 20:00:06','downloader');
/*!40000 ALTER TABLE `downloader_jq` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `exchange`
--

LOCK TABLES `exchange` WRITE;
/*!40000 ALTER TABLE `exchange` DISABLE KEYS */;
INSERT INTO `exchange` VALUES (1,'Börse Frankfurt','XFRA','DEU',0,'2017-05-06 13:34:36','admin','2017-05-06 13:34:36','admin'),(2,'Bitstamp Ltd.','bitstamp','GBR',5,'2017-05-06 13:34:36','admin','2017-05-06 13:34:36','admin');
/*!40000 ALTER TABLE `exchange` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'stock','2017-05-06 12:59:24','admin','2017-05-06 12:59:24','admin'),(2,'bitcoin','2017-05-06 12:59:24','admin','2017-05-06 12:59:24','admin');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;