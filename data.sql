use stockanalyses_prod;


--
-- Dumping data for table `type`
--

INSERT INTO `type` VALUES
(1,'stock', now(),'admin',now(),'admin'),
(2,'crypto_currency',now(),'admin',now(),'admin');


--
-- Dumping data for table `currency`
--

INSERT INTO `currency` VALUES
(1,'Euro','EUR',1,0,now(),'admin',now(),'admin'),
(2,'Argentine peso','ARS',1,0,now(),'admin',now(),'admin'),
(3,'Australian Dollar','AUD',1,0,now(),'admin',now(),'admin'),
(4,'Bulgarian lev','BGN',1,0,now(),'admin',now(),'admin'),
(5,'Brazilian real','BRL',1,0,now(),'admin',now(),'admin'),
(6,'Bitcoin','BTC',1,0,now(),'admin',now(),'admin'),
(7,'Canadian Dollar','CAD',1,0,now(),'admin',now(),'admin'),
(8,'Swiss francs','CHF',1,0,now(),'admin',now(),'admin'),
(9,'Chilean peso','CLP',1,0,now(),'admin',now(),'admin'),
(10,'Chinese renminbi','CNY',1,0,now(),'admin',now(),'admin'),
(11,'Czech koruna','CZK',1,0,now(),'admin',now(),'admin'),
(12,'Danish kron','DKK',1,0,now(),'admin',now(),'admin'),
(13,'Pecunix','GAU',1,0,now(),'admin',now(),'admin'),
(14,'British pounds','GBP',1,0,now(),'admin',now(),'admin'),
(15,'Hong Kong dollar','HKD',1,0,now(),'admin',now(),'admin'),
(16,'Hungarian forit','HUF',1,0,now(),'admin',now(),'admin'),
(17,'Israeli new shekel','ILS',1,0,now(),'admin',now(),'admin'),
(18,'Indian rupee','INR',1,0,now(),'admin',now(),'admin'),
(19,'Japanese yen','JPY',1,0,now(),'admin',now(),'admin'),
(20,'Litecoin','LTC',1,0,now(),'admin',now(),'admin'),
(21,'Mexican peso','MXN',1,0,now(),'admin',now(),'admin'),
(22,'Norwegian kron','NOK',1,0,now(),'admin',now(),'admin'),
(23,'New Zealand dollar','NZD',1,0,now(),'admin',now(),'admin'),
(24,'Peruvian nuevo sol','PEN',1,0,now(),'admin',now(),'admin'),
(25,'Polish zloty','PLN',1,0,now(),'admin',now(),'admin'),
(26,'Russian ruble','RUB',1,0,now(),'admin',now(),'admin'),
(27,'Saudi Arabian Riyal','SAR',1,0,now(),'admin',now(),'admin'),
(28,'Swedish krone','SEK',1,0,now(),'admin',now(),'admin'),
(29,'Singapore dollar','SGD',1,0,now(),'admin',now(),'admin'),
(30,'Sierra Leonean leone','SLL',1,0,now(),'admin',now(),'admin'),
(31,'Thai baht','THB',1,0,now(),'admin',now(),'admin'),
(32,'Ukrainian hryvnia','UAH',1,0,now(),'admin',now(),'admin'),
(33,'US Dollar','USD',1,0,now(),'admin',now(),'admin'),
(34,'Ripple','XRP',1,0,now(),'admin',now(),'admin'),
(35,'South African rand','ZAR',1,0,now(),'admin',now(),'admin'),
(36,'South Korean won','KRW',1,0,now(),'admin',now(),'admin'),
(37,'Namecoin','NMC',1,0,now(),'admin',now(),'admin');


--
-- Dumping data for table `downloader_jq`
--

INSERT INTO `downloader_jq` VALUES
(1000,'bitstamp#btc#eur',2,0,now(),now(),'admin',now(),'admin');


--
-- Dumping data for table `exchange`
--

INSERT INTO `exchange` VALUES
(1,'B�rse Frankfurt','XFRA','DEU',0,now(),'admin',now(),'admin'),
(2,'Bitstamp Ltd.','bitstamp','GBR',5,now(),'admin',now(),'admin');



--
-- Dumping data for table `users`
--

INSERT INTO `users` VALUES
(1, 'admin', '', '2', '123456', 'DEU', '3', now(), 'admin', now(), 'admin');

