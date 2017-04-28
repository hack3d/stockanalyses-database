CREATE DATABASE  IF NOT EXISTS `stockanalyses_prod` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `stockanalyses_prod`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: stockanalyses_v2
-- ------------------------------------------------------
-- Server version	5.7.17-0ubuntu0.16.04.1

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
-- Table structure for table `advice_queue`
--

DROP TABLE IF EXISTS `advice_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advice_queue` (
  `idadvice_queue` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `portfolio_head` int(11) NOT NULL,
  `portfolio_pos` int(11) NOT NULL,
  `portfolio_setting_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `state` int(11) NOT NULL COMMENT 'pending;succesful;error',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idadvice_queue`),
  KEY `fk_advice_queue_portfolio_setting1_idx` (`portfolio_head`,`portfolio_pos`,`portfolio_setting_name`),
  KEY `fk_advice_queue_type1_idx` (`state`),
  CONSTRAINT `fk_advice_queue_portfolio_setting1` FOREIGN KEY (`portfolio_head`, `portfolio_pos`, `portfolio_setting_name`) REFERENCES `portfolio_setting` (`portfolio_head`, `portfolio_pos`, `setting_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_advice_queue_type1` FOREIGN KEY (`state`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `country_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `currency_id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `symbol_currency` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `historical_data` tinyint(4) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '0 --> active\n1 --> inactive / disabled',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency_now`
--

DROP TABLE IF EXISTS `currency_now`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_now` (
  `currency_now_id` int(11) NOT NULL AUTO_INCREMENT,
  `base_currency` int(11) NOT NULL,
  `quote_currency` int(11) NOT NULL,
  `volume` decimal(18,8) DEFAULT NULL,
  `latest_trade` datetime DEFAULT NULL,
  `bid` decimal(15,5) DEFAULT NULL,
  `ask` decimal(15,5) DEFAULT NULL,
  `high` decimal(15,5) DEFAULT NULL,
  `currency_volume` decimal(15,5) DEFAULT NULL,
  `close` decimal(15,5) DEFAULT NULL,
  `low` decimal(15,5) DEFAULT NULL,
  `exchange_idexchange` int(11) DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`currency_now_id`),
  KEY `fk_base_currency_idx` (`base_currency`),
  KEY `fk_quote_currency_idx` (`quote_currency`),
  KEY `fk_exchange_idx` (`exchange_idexchange`),
  CONSTRAINT `fk_base_currency` FOREIGN KEY (`base_currency`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_exchange` FOREIGN KEY (`exchange_idexchange`) REFERENCES `exchange` (`idexchange`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_quote_currency` FOREIGN KEY (`quote_currency`) REFERENCES `currency` (`currency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_v2`.`currency_now_AFTER_INSERT` AFTER INSERT ON `currency_now` FOR EACH ROW
BEGIN
	declare v_base varchar(4);
    declare v_quote varchar(4);
    declare v_message varchar(255);
    
    set v_base = (select symbol_currency from currency where currency_id = new.base_currency);
    set v_quote = (select symbol_currency from currency where currency_id = new.quote_currency);
    
    set v_message = (select concat('Insert new dataset for base ', v_base, ' and quote ', v_quote, ' with the id ', LAST_INSERT_ID()));
    call sp_insert_log('I1002', v_message, 'currency_now_TRIGGER');

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `downloader_jq`
--

DROP TABLE IF EXISTS `downloader_jq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloader_jq` (
  `action` int(11) NOT NULL COMMENT '1000 --> current data',
  `value` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `type_idtype` int(11) NOT NULL,
  `state` int(11) DEFAULT '0' COMMENT '0 --> active',
  `timestamp` datetime NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`action`),
  KEY `fk_downloader_jq_type1_idx` (`type_idtype`),
  CONSTRAINT `fk_downloader_jq_type1` FOREIGN KEY (`type_idtype`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_v2`.`downloader_jq_AFTER_UPDATE` AFTER UPDATE ON `downloader_jq` FOR EACH ROW
BEGIN
	declare v_message varchar(255);
	declare v_exchange varchar(45);
    declare v_base varchar(45);
    declare v_quote varchar(45);

	IF new.action = 1300 THEN
    
		-- get exchange, base and quote
		select substring_index(new.value, '#', 1), substring_index(substring_index(new.value, '#', 2), '#', -1), substring_index(substring_index(new.value, '#', 3), '#', -1) into v_exchange, v_base, v_quote;
		
		set v_message = (SELECT CONCAT('Set action to ', new.action, 'for exchange ', v_exchange, ' and base ', base, ' and quote ', quote));
        
        call sp_insert_log('D1300', v_message, 'downloader_jq_TRIGGER');
        
    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `email_queue`
--

DROP TABLE IF EXISTS `email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_queue` (
  `idemail_queue` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `emailaddress` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idemail_queue`),
  KEY `idx_insert_user` (`insert_user`),
  KEY `idx_modify_user` (`modify_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange`
--

DROP TABLE IF EXISTS `exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange` (
  `idexchange` int(11) NOT NULL AUTO_INCREMENT,
  `exchange_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'NAme of the exchange',
  `exchange_symbol` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'MIC Code: XFRA',
  `country_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'DEU',
  `interval` int(11) DEFAULT '0' COMMENT 'interval in seconds',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idexchange`),
  KEY `fk_exchange_country1_idx` (`country_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_holidays`
--

DROP TABLE IF EXISTS `exchange_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_holidays` (
  `exchange_holidays_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_exchange` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`exchange_holidays_id`),
  KEY `fk_exchange_holidays_exchange1_idx` (`id_exchange`),
  CONSTRAINT `fk_exchange_holidays_exchange1` FOREIGN KEY (`id_exchange`) REFERENCES `exchange` (`idexchange`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_time`
--

DROP TABLE IF EXISTS `exchange_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_time` (
  `exchange_time_id` int(11) NOT NULL AUTO_INCREMENT,
  `open_exchange` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `close_exchange` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `summer` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user_id` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `id_exchange` int(11) NOT NULL,
  PRIMARY KEY (`exchange_time_id`),
  KEY `fk_exchange_time_exchange1_idx` (`id_exchange`),
  CONSTRAINT `fk_exchange_time_exchange1` FOREIGN KEY (`id_exchange`) REFERENCES `exchange` (`idexchange`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import_jq`
--

DROP TABLE IF EXISTS `import_jq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_jq` (
  `action` int(11) NOT NULL,
  `id_stock` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` datetime DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`action`,`id_stock`,`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_v2`.`import_jq_AFTER_INSERT` AFTER INSERT ON `import_jq` FOR EACH ROW
BEGIN
	declare v_action int;
    declare v_message varchar(255);
    declare v_exchange varchar(45);
    declare v_base varchar(45);
    declare v_quote varchar(45);
    declare v_interval int;

	IF new.action = 1000 THEN
		set v_action = 1000;
    
		-- get exchange, base and quote
		select substring_index(new.id_stock, '#', 1), substring_index(substring_index(new.id_stock, '#', 2), '#', -1), substring_index(substring_index(new.id_stock, '#', 3), '#', -1) into v_exchange, v_base, v_quote;
		
		set v_interval = (select `interval` from `exchange` where `exchange_symbol` = v_exchange);
        
        IF v_interval > 0 THEN
			update downloader_jq set `action` = v_action, `timestamp` = DATE_ADD(now(), INTERVAL v_interval SECOND), `modify_user` = 'import_jq_TRIGGER', `modify_timestamp` = now()
            where `value` = new.id_stock and `action` >= 1200;
            
            set v_message = (SELECT CONCAT('Reset downloader job to action: ', v_action, '. Exchange: ', v_exchange));
            call sp_insert_log('I1000', v_message, 'import_jq_TRIGGER');
		ELSE
			set v_message = (SELECT CONCAT('No interval for the exchange: ', v_exchange));
			call sp_insert_log('I1001', v_message, 'import_jq_TRIGGER');
        END IF;
    
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `index_world`
--

DROP TABLE IF EXISTS `index_world`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `index_world` (
  `index_world_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yahoo_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_datetime` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`index_world_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicator_jq`
--

DROP TABLE IF EXISTS `indicator_jq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicator_jq` (
  `idindicator_jq` int(11) NOT NULL AUTO_INCREMENT,
  `action` int(11) NOT NULL COMMENT 'action --> indicator\n1000 --> SMA',
  `value` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` int(11) NOT NULL COMMENT '0 --> active',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idindicator_jq`),
  KEY `idx_value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `idlog` int(11) NOT NULL AUTO_INCREMENT,
  `kennung` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `log_message` text COLLATE utf8_unicode_ci,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idlog`),
  KEY `idx_kennung` (`kennung`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio_head`
--

DROP TABLE IF EXISTS `portfolio_head`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolio_head` (
  `portfolio_head_id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `portfolioname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `capital_start` double DEFAULT '10000',
  `capital_current` double DEFAULT '10000',
  `type` int(11) NOT NULL COMMENT 'portfolio; watchlist',
  `state` int(11) NOT NULL COMMENT 'enabled; disabled',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`portfolio_head_id`),
  KEY `fk_user_id_idx` (`user`),
  KEY `fk_portfolio_head_type1_idx` (`state`),
  KEY `fk_portfolio_head_type2_idx` (`type`),
  CONSTRAINT `fk_portfolio_head_type1` FOREIGN KEY (`state`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_head_type2` FOREIGN KEY (`type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id2` FOREIGN KEY (`user`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_v2`.`portfolio_log_AFTER_INSERT`
AFTER INSERT ON `stockanalyses_v2`.`portfolio_head`
FOR EACH ROW
BEGIN
	set @type = (select type.idtype from type where type.type_name = 'add');
    set @value = (select concat('Portfolio ', new.portfolioname, ' wurde eroeffnet mit einem Startkapital von ', new.capital_start));
	insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)
    values (NEW.portfolio_head_id, 0, @type, @value, New.insert_user, now());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `portfolio_log`
--

DROP TABLE IF EXISTS `portfolio_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolio_log` (
  `portfolio_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `portfolio_head` int(11) NOT NULL,
  `portfolio_pos` int(11) NOT NULL COMMENT 'If portfolio is new the position has to be 0.',
  `type` int(11) NOT NULL COMMENT 'add, delete, update',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`portfolio_log_id`),
  KEY `fk_portfolio_head_id_idx` (`portfolio_head`),
  KEY `fk_portfolio_log_type1_idx` (`type`),
  KEY `fk_portfolio_log_portfolio_pos1_idx` (`portfolio_pos`),
  CONSTRAINT `fk_portfolio_head_id1` FOREIGN KEY (`portfolio_head`) REFERENCES `portfolio_head` (`portfolio_head_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_log_portfolio_pos1` FOREIGN KEY (`portfolio_pos`) REFERENCES `portfolio_pos` (`portfolio_pos_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_log_type1` FOREIGN KEY (`type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='log all actions on the portfolio';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio_pos`
--

DROP TABLE IF EXISTS `portfolio_pos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolio_pos` (
  `portfolio_pos_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_portfolio_head` int(11) NOT NULL,
  `value` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'stock or currency',
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `exchange` int(11) NOT NULL,
  `state` int(11) NOT NULL COMMENT 'buy; sell; hold',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`portfolio_pos_id`),
  KEY `fk_portfolio_head_id_idx` (`id_portfolio_head`),
  KEY `fk_portfolio_pos_type1_idx` (`state`),
  KEY `fk_portfolio_pos_exchange1_idx` (`exchange`),
  CONSTRAINT `fk_portfolio_head_id` FOREIGN KEY (`id_portfolio_head`) REFERENCES `portfolio_head` (`portfolio_head_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_pos_exchange1` FOREIGN KEY (`exchange`) REFERENCES `exchange` (`idexchange`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_pos_type1` FOREIGN KEY (`state`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_v2`.`portfolio_pos_AFTER_INSERT`
AFTER INSERT ON `stockanalyses_v2`.`portfolio_pos`
FOR EACH ROW
BEGIN

	set @type = (select type.idtype from type where type.type_name = 'add');

    set @portfolioname = (select portfolioname from portfolio_head where portfolio_head.portfolio_head_id = new.id_portfolio_head);

    set @value = (select concat('Portfolio ', @portfolioname, ' wurde das Wertpapier ', new.value, 'hinzugefuegt mit der Menge ', new.quantity, 'zum Preis von ', new.price));

	insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)

    values (NEW.id_portfolio_head, new.portfolio_pos_id, @type, @value, New.insert_user, now());

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `portfolio_setting`
--

DROP TABLE IF EXISTS `portfolio_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolio_setting` (
  `portfolio_head` int(11) NOT NULL,
  `portfolio_pos` int(11) NOT NULL,
  `setting_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` int(11) NOT NULL COMMENT 'enabled; disabled',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` int(11) NOT NULL,
  PRIMARY KEY (`portfolio_head`,`portfolio_pos`,`setting_name`),
  KEY `fk_portfolio_setting_portfolio_head1_idx` (`portfolio_head`),
  KEY `fk_portfolio_setting_portfolio_pos1_idx` (`portfolio_pos`),
  KEY `idx_setting_name` (`setting_name`),
  KEY `fk_portfolio_setting_type1_idx` (`state`),
  CONSTRAINT `fk_portfolio_setting_portfolio_head1` FOREIGN KEY (`portfolio_head`) REFERENCES `portfolio_head` (`portfolio_head_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_setting_portfolio_pos1` FOREIGN KEY (`portfolio_pos`) REFERENCES `portfolio_pos` (`portfolio_pos_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_setting_type1` FOREIGN KEY (`state`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='settings for portfolio positions';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_v2`.`portfolio_setting_AFTER_INSERT`
AFTER INSERT ON `stockanalyses_v2`.`portfolio_setting`
FOR EACH ROW
BEGIN

	/* die id des typs wird ermittelt */

	set @type = (select type.idtype from type where type.type_name = 'add');

    /* der portfolioname wird ermittelt */

    set @portfolioname = (select portfolioname from portfolio_head where portfolio_head.portfolio_head_id = new.portfolio_head);

    /* das wertpapier oder währung wird ermittelt */

    set @portfolio_pos_value = (select portfolio_pos.value from portfolio_pos where portfolio_pos.portfolio_pos_id = portfolio_pos);

    /* die log-message wird zusammengestellt */

    set @value = (select concat('Portfolio ', @portfolioname, 'mit der Position ', @portfolio_pos_value, ' hat das Attribut ', new.setting_name, ' mit dem Wert ', new.value, 'hinzugefuegt'));

    /* alle daten werden ins portfolio_log geschrieben */

	insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)

    values (NEW.portfolio_head, new.portfolio_pos, @type, @value, New.insert_user, now());



	/****************************************************************

     * je nachdem welche einstellung eingefügt wird zusätzlich noch

     * ein eintrag in die advice queue angelegt.

     ****************************************************************/

	CASE new.setting_name

    	/* DEMA Indikator */

    	WHEN 'dema' then call sp_insert_advice_queue(new.portfolio_head, new.portfolio_pos, new.setting_name, new.insert_user);

    END CASE;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `yahoo_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isin` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_index_world` int(11) DEFAULT NULL,
  `id_exchange_time` int(11) DEFAULT NULL,
  `historical_data` int(11) NOT NULL DEFAULT '0' COMMENT '1 --> enabled',
  `state` tinyint(4) NOT NULL DEFAULT '2' COMMENT 'state:\n0 --> enabled\n1 --> disabled\n2 --> waiting for activation',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`stock_id`),
  KEY `fk_index_world_id_idx` (`id_index_world`),
  KEY `fk_exchange_time_id_idx` (`id_exchange_time`),
  CONSTRAINT `fk_exchange_time_id` FOREIGN KEY (`id_exchange_time`) REFERENCES `exchange_time` (`exchange_time_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_index_world_id` FOREIGN KEY (`id_index_world`) REFERENCES `index_world` (`index_world_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_v2`.`stock_AINS`
AFTER INSERT ON `stockanalyses_v2`.`stock`
FOR EACH ROW
Begin
	insert into downloader_jq(action, id_stock, state, timestamp) values('1000', NEW.stock_id, 0, now()), ('2100', New.stock_id, 0, now()), ('3100', New.stock_id, 0, now());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `stock_current`
--

DROP TABLE IF EXISTS `stock_current`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_current` (
  `stock_current_id` int(11) NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `utctime` datetime DEFAULT NULL,
  `day_min` double DEFAULT NULL,
  `day_max` double DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `id_stock` int(11) DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  PRIMARY KEY (`stock_current_id`),
  KEY `fk_stock_id_idx` (`id_stock`),
  CONSTRAINT `fk_stock_id` FOREIGN KEY (`id_stock`) REFERENCES `stock` (`stock_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_daily`
--

DROP TABLE IF EXISTS `stock_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_daily` (
  `stock_daily_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `open` double DEFAULT NULL,
  `high` double DEFAULT NULL,
  `low` double DEFAULT NULL,
  `close` double DEFAULT NULL,
  `volume` bigint(20) DEFAULT NULL,
  `adj_close` double DEFAULT NULL,
  `id_stock` int(11) NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  PRIMARY KEY (`stock_daily_id`),
  KEY `fk_stock_id_idx` (`id_stock`),
  CONSTRAINT `fk_stock_id2` FOREIGN KEY (`id_stock`) REFERENCES `stock` (`stock_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_weekly`
--

DROP TABLE IF EXISTS `stock_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_weekly` (
  `stock_weekly_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `open` double DEFAULT NULL,
  `high` double DEFAULT NULL,
  `low` double DEFAULT NULL,
  `close` double DEFAULT NULL,
  `volume` bigint(20) DEFAULT NULL,
  `adj_close` double DEFAULT NULL,
  `id_stock` int(11) NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  PRIMARY KEY (`stock_weekly_id`),
  KEY `fk_stock_id_idx` (`id_stock`),
  CONSTRAINT `fk_stock_id3` FOREIGN KEY (`id_stock`) REFERENCES `stock` (`stock_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_fee`
--

DROP TABLE IF EXISTS `trade_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade_fee` (
  `idtrade_fee` int(11) NOT NULL AUTO_INCREMENT,
  `exchange` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT 'stock; currency; paying out',
  `fee` decimal(10,0) DEFAULT NULL,
  `fee_type` int(11) NOT NULL COMMENT 'percent; euro; dollar; ...',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtrade_fee`),
  KEY `fk_trade_fee_exchange1_idx` (`exchange`),
  KEY `fk_trade_fee_type1_idx` (`type`),
  KEY `fk_trade_fee_type2_idx` (`fee_type`),
  CONSTRAINT `fk_trade_fee_exchange1` FOREIGN KEY (`exchange`) REFERENCES `exchange` (`idexchange`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_fee_type1` FOREIGN KEY (`type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_fee_type2` FOREIGN KEY (`fee_type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_log`
--

DROP TABLE IF EXISTS `trade_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade_log` (
  `idtrade_log` int(11) NOT NULL AUTO_INCREMENT,
  `value_type` int(11) NOT NULL COMMENT 'buy; sell',
  `value` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `price_insert` decimal(10,0) NOT NULL,
  `price_traded` decimal(10,0) NOT NULL,
  `amount` double NOT NULL,
  `exchange` int(11) NOT NULL,
  `state` int(11) NOT NULL COMMENT 'successful; error; added; pending',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idtrade_log`),
  KEY `fk_trade_log_type1_idx` (`value_type`),
  KEY `fk_trade_log_type2_idx` (`state`),
  KEY `fk_trade_log_exchange1_idx` (`exchange`),
  CONSTRAINT `fk_trade_log_exchange1` FOREIGN KEY (`exchange`) REFERENCES `exchange` (`idexchange`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_log_type1` FOREIGN KEY (`value_type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_log_type2` FOREIGN KEY (`state`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='logging of trading';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_queue`
--

DROP TABLE IF EXISTS `trade_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade_queue` (
  `idtrade_queue` int(11) NOT NULL AUTO_INCREMENT,
  `portfolio_pos` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtrade_queue`),
  KEY `fk_trade_queue_portfolio_pos1_idx` (`portfolio_pos`),
  CONSTRAINT `fk_trade_queue_portfolio_pos1` FOREIGN KEY (`portfolio_pos`) REFERENCES `portfolio_pos` (`portfolio_pos_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='queue for trading';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trend`
--

DROP TABLE IF EXISTS `trend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trend` (
  `idtrend` int(11) NOT NULL AUTO_INCREMENT,
  `portfolio_head` int(11) NOT NULL,
  `portfolio_pos` int(11) NOT NULL,
  `indicator` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trend` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persistance` int(11) DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` int(11) NOT NULL,
  PRIMARY KEY (`idtrend`),
  KEY `fk_trend_portfolio_head1_idx` (`portfolio_head`),
  KEY `fk_trend_portfolio_pos1_idx` (`portfolio_pos`),
  CONSTRAINT `fk_trend_portfolio_head1` FOREIGN KEY (`portfolio_head`) REFERENCES `portfolio_head` (`portfolio_head_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trend_portfolio_pos1` FOREIGN KEY (`portfolio_pos`) REFERENCES `portfolio_pos` (`portfolio_pos_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `idtype` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtype`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_action`
--

DROP TABLE IF EXISTS `user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_action` (
  `user_action_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) DEFAULT NULL,
  `user_ip` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_state` int(11) NOT NULL COMMENT '0 --> success\n1 --> false username\n2 --> false password',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_action_id`),
  KEY `fk_user_id_idx` (`id_user`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`id_user`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_activation`
--

DROP TABLE IF EXISTS `user_activation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_activation` (
  `user_activation_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `activation_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `approved` int(11) DEFAULT '0' COMMENT '0 --> disabled',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_activation_id`),
  KEY `fk_user_id_idx` (`id_user`),
  CONSTRAINT `fk_user_id1` FOREIGN KEY (`id_user`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(220) COLLATE utf8_unicode_ci NOT NULL,
  `user_level` tinyint(4) DEFAULT '2' COMMENT '0 --> admin\n1 --> worker user\n2 --> web user\n',
  `password` varchar(220) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `state` int(11) DEFAULT '3' COMMENT '0 --> enabled\n1 --> disabled\n2 --> banned\n3 --> waiting for activation',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_AINS` AFTER INSERT ON `users` FOR EACH ROW
begin
set @activation_code = (select left(uuid(), 10));
insert into 
user_activation (id_user, activation_code, insert_timestamp, insert_user, modify_timestamp, modify_user) 
values (NEW.user_id, @activation_code, now(), 'registration', now(), 'registration');
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `v_advice_jq`
--

DROP TABLE IF EXISTS `v_advice_jq`;
/*!50001 DROP VIEW IF EXISTS `v_advice_jq`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_advice_jq` AS SELECT 
 1 AS `portfolio_pos`,
 1 AS `pos_value`,
 1 AS `setting_name`,
 1 AS `setting_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_downloader_jq`
--

DROP TABLE IF EXISTS `v_downloader_jq`;
/*!50001 DROP VIEW IF EXISTS `v_downloader_jq`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_downloader_jq` AS SELECT 
 1 AS `action`,
 1 AS `yahoo_name`,
 1 AS `timestamp`,
 1 AS `open_exchange`,
 1 AS `close_exchange`,
 1 AS `stock_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_indicator_jq`
--

DROP TABLE IF EXISTS `v_indicator_jq`;
/*!50001 DROP VIEW IF EXISTS `v_indicator_jq`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_indicator_jq` AS SELECT 
 1 AS `action`,
 1 AS `value`,
 1 AS `timestamp`,
 1 AS `state`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_stock_daily`
--

DROP TABLE IF EXISTS `v_stock_daily`;
/*!50001 DROP VIEW IF EXISTS `v_stock_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_stock_daily` AS SELECT 
 1 AS `stock_daily_id`,
 1 AS `date`,
 1 AS `open`,
 1 AS `high`,
 1 AS `low`,
 1 AS `close`,
 1 AS `volume`,
 1 AS `adj_close`,
 1 AS `id_stock`,
 1 AS `insert_timestamp`,
 1 AS `stock_id`,
 1 AS `name`,
 1 AS `yahoo_name`,
 1 AS `isin`,
 1 AS `id_index_world`,
 1 AS `id_exchange_time`,
 1 AS `historical_data`,
 1 AS `state`,
 1 AS `st_insert_timestamp`,
 1 AS `insert_user`,
 1 AS `modify_timestamp`,
 1 AS `modify_user`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_trade_queue`
--

DROP TABLE IF EXISTS `v_trade_queue`;
/*!50001 DROP VIEW IF EXISTS `v_trade_queue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_trade_queue` AS SELECT 
 1 AS `value`,
 1 AS `quantity`,
 1 AS `price`,
 1 AS `exchange`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'stockanalyses_v2'
--

--
-- Dumping routines for database 'stockanalyses_v2'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_advice_queue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `sp_insert_advice_queue`(IN `portfolio_head` INT, IN `portfolio_pos` INT, IN `portfolio_setting_name` INT, IN `insert_user` INT)
    NO SQL
BEGIN

	set @state = (select type.idtype from type where type.type_name = 'pending');



	insert into adivce_queue (timestamp, portfolio_head, portfolio_pos, portfolio_setting_name, state, insert_timestamp, insert_user, modify_timestamp, modify_user)

    values (now(), @portfolio_head, @portfolio_pos, @portfolio_setting_name, @state, now(), @insert_user, now(), @insert_user);

    

    set @portfolioname = (select portfolio_head.portfolioname from portfolio_head where portfolio_head.portfolio_head_id = portfolio_head);

    set @log_message = (select concat('Portfolio ', @portfolioname, ' mit der Position ', portfolio_pos.portfolio_pos_id, '. Setting-Name ', @portfolio_setting_name));

    call sp_insert_log('adv_jq10001', @log_message, @insert_user);



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_log`(IN kennung varchar(45), IN log_message text, IN insert_user varchar(200))
BEGIN
	insert into
	log (kennung, log_message, insert_timestamp, insert_user)
	values (kennung, log_message, now(), insert_user);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_trade_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_trade_log`(IN value_type int, IN value varchar(45), IN price_insert decimal(10,0), IN price_traded decimal(10,0), IN amount double, IN exchange int, IN state int, IN insert_user int)
BEGIN
	insert into trade_log
	(value_type, value, price_insert, price_traded, amount, exchange, state, insert_timestamp, insert_user)
	values
	(value_type, value, price_insert, price_traded, amount, exchange, state, now(), insert_user);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_advice_jq`
--

/*!50001 DROP VIEW IF EXISTS `v_advice_jq`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_advice_jq` AS select `advice_queue`.`portfolio_pos` AS `portfolio_pos`,`portfolio_pos`.`value` AS `pos_value`,`portfolio_setting`.`setting_name` AS `setting_name`,`portfolio_setting`.`value` AS `setting_value` from (((`advice_queue` join `portfolio_pos` on((`advice_queue`.`portfolio_pos` = `portfolio_pos`.`portfolio_pos_id`))) join `portfolio_setting` on((`portfolio_pos`.`portfolio_pos_id` = `portfolio_setting`.`portfolio_pos`))) join `type` on((`advice_queue`.`state` = `type`.`idtype`))) where ((1 = 1) and (`type`.`type_name` <> 'error') and (`advice_queue`.`timestamp` < now()) and (`portfolio_setting`.`setting_name` in ('dema','macd','rsi'))) order by `advice_queue`.`timestamp`,`portfolio_pos`.`value` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_downloader_jq`
--

/*!50001 DROP VIEW IF EXISTS `v_downloader_jq`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`aws_stock`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_downloader_jq` AS select `djq`.`action` AS `action`,`stock`.`yahoo_name` AS `yahoo_name`,`djq`.`timestamp` AS `timestamp`,`ext`.`open_exchange` AS `open_exchange`,`ext`.`close_exchange` AS `close_exchange`,`stock`.`stock_id` AS `stock_id` from ((`stock` join `downloader_jq` `djq` on((`djq`.`value` = `stock`.`stock_id`))) join `exchange_time` `ext` on((`ext`.`exchange_time_id` = `stock`.`id_exchange_time`))) where (`djq`.`state` = 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_indicator_jq`
--

/*!50001 DROP VIEW IF EXISTS `v_indicator_jq`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_indicator_jq` AS select `ijq`.`action` AS `action`,`ijq`.`value` AS `value`,`ijq`.`timestamp` AS `timestamp`,`ijq`.`state` AS `state` from `indicator_jq` `ijq` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_stock_daily`
--

/*!50001 DROP VIEW IF EXISTS `v_stock_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_stock_daily` AS select `stock_daily`.`stock_daily_id` AS `stock_daily_id`,`stock_daily`.`date` AS `date`,`stock_daily`.`open` AS `open`,`stock_daily`.`high` AS `high`,`stock_daily`.`low` AS `low`,`stock_daily`.`close` AS `close`,`stock_daily`.`volume` AS `volume`,`stock_daily`.`adj_close` AS `adj_close`,`stock_daily`.`id_stock` AS `id_stock`,`stock_daily`.`insert_timestamp` AS `insert_timestamp`,`stock`.`stock_id` AS `stock_id`,`stock`.`name` AS `name`,`stock`.`yahoo_name` AS `yahoo_name`,`stock`.`isin` AS `isin`,`stock`.`id_index_world` AS `id_index_world`,`stock`.`id_exchange_time` AS `id_exchange_time`,`stock`.`historical_data` AS `historical_data`,`stock`.`state` AS `state`,`stock`.`insert_timestamp` AS `st_insert_timestamp`,`stock`.`insert_user` AS `insert_user`,`stock`.`modify_timestamp` AS `modify_timestamp`,`stock`.`modify_user` AS `modify_user` from (`stock_daily` join `stock` on((`stock_daily`.`id_stock` = `stock`.`stock_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_trade_queue`
--

/*!50001 DROP VIEW IF EXISTS `v_trade_queue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_trade_queue` AS select `pp`.`value` AS `value`,`pp`.`quantity` AS `quantity`,`pp`.`price` AS `price`,`pp`.`exchange` AS `exchange` from (`trade_queue` `tq` join `portfolio_pos` `pp` on((`tq`.`portfolio_pos` = `pp`.`portfolio_pos_id`))) where ((1 = 1) and (`tq`.`timestamp` <= now())) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-28  9:23:18
