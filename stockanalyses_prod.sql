CREATE DATABASE  IF NOT EXISTS `stockanalyses_prod` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `stockanalyses_prod`;
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
-- Table structure for table `advice_queue`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `advice_queue` (
  `idadvice_queue` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `portfolio_pos` int(11) NOT NULL,
  `indicator` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT 'possible values are: sma, macd, rsi',
  `settings` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT 'all values stored values will be seperated by ''#''.',
  `bond_id` int(11) NOT NULL,
  `currency_flag` tinyint(4) NOT NULL COMMENT 'set this flag if the ''bond_id'' is a currency',
  `stock_flag` tinyint(4) NOT NULL COMMENT 'set this flag if the ''bond_id'' is a stock',
  `state` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idadvice_queue`),
  KEY `fk_advice_queue_portfolio_setting1_idx` (`portfolio_pos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bonds`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `bonds` (
  `bonds_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isin` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '2' COMMENT 'state:\n0 --> enabled\n1 --> disabled\n2 --> waiting for activation',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`bonds_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bonds_current`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `bonds_current` (
  `stock_current_id` int(11) NOT NULL AUTO_INCREMENT,
  `last` decimal(18,8) DEFAULT NULL,
  `bid` decimal(18,8) DEFAULT NULL,
  `ask` decimal(18,8) DEFAULT NULL,
  `high` decimal(18,8) DEFAULT NULL,
  `low` decimal(18,8) DEFAULT NULL,
  `volume` decimal(18,8) DEFAULT NULL,
  `utctime` datetime DEFAULT NULL,
  `bonds_idbonds` int(11) NOT NULL,
  `exchanges_idexchanges` int(11) NOT NULL,
  `aggregated` tinyint(4) DEFAULT '0' COMMENT '0 --> not aggregated\n1 --> aggregated',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) CHARACTER SET utf8 NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`stock_current_id`),
  KEY `fk_stock_id_idx` (`bonds_idbonds`),
  KEY `fk_stock_current_1_idx` (`exchanges_idexchanges`),
  CONSTRAINT `fk_stock_current_1` FOREIGN KEY (`exchanges_idexchanges`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_stock_id` FOREIGN KEY (`bonds_idbonds`) REFERENCES `bonds` (`bonds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1610 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bonds_current_one_minute`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `bonds_current_one_minute` (
  `idbonds_current_one_minute` int(11) NOT NULL AUTO_INCREMENT,
  `open` decimal(18,8) NOT NULL,
  `close` decimal(18,8) NOT NULL,
  `high` decimal(18,8) NOT NULL,
  `low` decimal(18,8) NOT NULL,
  `volume` decimal(18,8) NOT NULL,
  `utctime` datetime NOT NULL,
  `num_records` int(11) NOT NULL COMMENT 'number of aggregated records',
  `error_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'flag to decide if data has an error.',
  `aggregated` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'flag to see if data already aggregated.',
  `bonds_idbonds` int(11) NOT NULL,
  `exchanges_idexchanges` int(11) NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) CHARACTER SET utf8 NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idbonds_current_one_minute`),
  KEY `fk_bonds_current_one_minute_1_idx` (`bonds_idbonds`),
  KEY `fk_bonds_current_one_minute_2_idx` (`exchanges_idexchanges`),
  CONSTRAINT `fk_bonds_current_one_minute_1` FOREIGN KEY (`bonds_idbonds`) REFERENCES `bonds` (`bonds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bonds_current_one_minute_2` FOREIGN KEY (`exchanges_idexchanges`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`bonds_current_one_minute_AFTER_INSERT` AFTER INSERT ON `bonds_current_one_minute` FOR EACH ROW
BEGIN
	declare v_isin varchar(13);
    declare v_exchange varchar(45);
    declare v_message varchar(255);
    declare v_indicator varchar(255);
    declare v_indicator_setting varchar(255);
    declare v_time_horizon varchar(45);
    declare v_bondid int;
    declare v_stock_open decimal(18,8);
    declare v_stock_close decimal(18,8);
    declare v_stock_high decimal(18,8);
    declare v_stock_low decimal(18,8);
    declare v_stock_volume decimal(18,8);
    declare v_stock_utctime datetime;
    declare done int default false;
    DECLARE cursor1 CURSOR FOR
    select indicator_symbol, settings, time_horizon from v_pre_indicator_currency
	where 1=1
	and `bonds_idbonds` = NEW.bonds_idbonds
    and `exchanges_idexchanges` = NEW.exchanges_idexchanges
    and `time_horizon` = '1minute';

    DECLARE CONTINUE HANDLER FOR NOT FOUND set done = true;


    set v_isin = (select `isin` from bonds where `bonds_id` = new.bonds_idbonds);
    set v_exchange = (select `exchange_name` from exchanges where idexchanges = new.exchanges_idexchanges);
    set v_bondid = (select new.idbonds_current_one_minute);

    -- Do some standard logging
    set v_message = (select concat('Insert new dataset for isin ', v_isin, ' and exchange ', v_exchange, ' with the id ', v_bondid));
    call sp_insert_log('I1002', v_message, 'bonds_current_one_minute_TRIGGER');

	-- Get all portfolios with a trading strategy for the incoming currency pair
    OPEN cursor1;

    cursor_loop: loop

		fetch cursor1 into v_indicator, v_indicator_setting, v_time_horizon;

		if done then
		 leave cursor_loop;
		end if;

        -- select previous tickdata and compare
        select `open`, `close`, `high`, `low`, `volume`, `utctime` into v_stock_open, v_stock_close, v_stock_high, v_stock_low, v_stock_volume, v_stock_utctime
        from bonds_current_one_minute
		where 1=1
		and bonds_idbonds = new.bonds_idbonds
		and exchanges_idexchanges = new.exchanges_idexchanges
		order by insert_timestamp desc
		limit 1,1;

        IF (v_stock_open != new.`open` OR v_stock_close != new.`close` OR v_stock_high != new.`high` OR v_stock_low != new.`low` OR v_stock_volume != new.`volume` OR v_stock_utctime != new.`utctime`) THEN

			insert into `indicator_jq` (`indicator_name`, `value`, `timestamp`, `aggregated_time_horizon`, `bond_id`,`insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
			values (v_indicator, v_indicator_setting, now(), v_time_horizon, v_bondid, now(), 'bonds_current_one_minute_TRIGGER_AI', now(), 'bonds_current_one_minute_TRIGGER_AI');

			set v_message = (select concat('New Job for for indicator: ', v_indicator, ' for bond ', v_isin, ' and exchange ', v_exchange));
			call sp_insert_log('ID1001', v_message, 'bonds_current_one_minute_TRIGGER');
		ELSE
			set v_message = (select concat('No new Job for for indicator: ', v_indicator, ' for bond ', v_isin, ' and exchange ', v_exchange));
			call sp_insert_log('ID1003', v_message, 'bonds_current_one_minute_TRIGGER');
        END IF;

	end loop cursor_loop;

    close cursor1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `countries`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `countries` (
  `idcountries` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idcountries`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `downloader_jq`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `downloader_jq` (
  `downloader_jq_id` int(11) NOT NULL AUTO_INCREMENT,
  `action` int(11) NOT NULL COMMENT '1000 --> current data',
  `value` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `type_idtype` int(11) NOT NULL,
  `state` int(11) DEFAULT '0' COMMENT '0 --> active',
  `timestamp` datetime NOT NULL,
  `insert_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`downloader_jq_id`),
  KEY `fk_downloader_jq_type1_idx` (`type_idtype`),
  CONSTRAINT `fk_downloader_jq_type1` FOREIGN KEY (`type_idtype`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`downloader_jq_AFTER_UPDATE` AFTER UPDATE ON `downloader_jq` FOR EACH ROW
BEGIN
	declare v_message varchar(255);
	declare v_exchange varchar(45);
    declare v_base varchar(45);
    declare v_quote varchar(45);


	IF new.action = 1300 THEN


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

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `email_queue` (
  `idemail_queue` int(11) NOT NULL AUTO_INCREMENT,
  `action` int(11) NOT NULL DEFAULT '1000',
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_holidays`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `exchange_holidays` (
  `idexchange_holidays` int(11) NOT NULL AUTO_INCREMENT,
  `exchanges_idexchanges` int(11) NOT NULL,
  `date` date NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idexchange_holidays`),
  KEY `fk_exchange_holidays_exchange1_idx` (`exchanges_idexchanges`),
  CONSTRAINT `fk_exchange_holidays_exchange1` FOREIGN KEY (`exchanges_idexchanges`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_time`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `exchange_time` (
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
  CONSTRAINT `fk_exchange_time_exchange1` FOREIGN KEY (`id_exchange`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_to_trade`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `exchange_to_trade` (
  `idexchange_to_trade` int(11) NOT NULL AUTO_INCREMENT,
  `isin` int(11) NOT NULL,
  `exchange_idexchange` int(11) NOT NULL,
  `state` int(11) NOT NULL COMMENT '0 --> enabled\n1 --> disabled',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idexchange_to_trade`),
  KEY `fk_exchange_to_trade_exchange1_idx` (`exchange_idexchange`),
  KEY `fk_exchange_to_trade_1_idx` (`isin`),
  CONSTRAINT `fk_exchange_to_trade_1` FOREIGN KEY (`isin`) REFERENCES `bonds` (`bonds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_exchange_to_trade_exchange1` FOREIGN KEY (`exchange_idexchange`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`exchange_to_trade_AFTER_INSERT` AFTER INSERT ON `exchange_to_trade` FOR EACH ROW
BEGIN
	# at first we try to find the exchange symbol
    set @exchange_symbol = (SELECT `exchange_symbol` from `exchanges` where `idexchanges` = NEW.exchange_idexchange);

	# now we check if the job already exists
    set @isin = (SELECT `isin` from `bonds` where `bonds_id` = NEW.isin);
    set @job_value = (SELECT CONCAT(@exchange_symbol, '#', @isin));
	set @check_job = (SELECT `state` from `downloader_jq` where `value` = @job_value);

    if @check_job = 1 then
		set @v_message = (SELECT CONCAT('Job for ', @job_value, ' was disabled. Now it\'s enabled'));
		call sp_insert_log('W1000', @v_message, 'TRIGGER_exchange_to_trade_AI');
        update `downloader_jq` set `state` = 0, `modify_timestamp` = now(), `modify_user` = 'TRIGGER_exchange_to_trade' where `value` = @job_value;
	elseif @check_job = 0 then
		set @v_message = (SELECT CONCAT('Job for ', @job_value, ' exists already.'));
        call sp_insert_log('W1001', @v_message, 'TRIGGER_exchange_to_trade_AI');
	else
		insert into `downloader_jq` (`action`, `value`, `type_idtype`, `state`, `timestamp`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`) values ('1000', @job_value, 2, 0, now(), now(), 'TRIGGER_exchange_to_trade_AI', now(), 'TRIGGER_exchange_to_trade_AI');
		set @v_message = (SELECT CONCAT('Job for ', @job_value, ' doesn\'t exists. It will be created.'));
		call sp_insert_log('D1400', @v_message, 'TRIGGER_exchange_to_trade_AI');
    end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`exchange_to_trade_AFTER_UPDATE` AFTER UPDATE ON `exchange_to_trade` FOR EACH ROW
BEGIN

	# set variable to track if something changed so we have to update the table
    # 'downloader_jq'
    set @changed = 0;

	# at first we check if new and old exchange is the same
    if OLD.exchange_idexchange <> NEW.exchange_idexchange then
		set @exchange_symbol = (SELECT `exchange_symbol` from `exchanges` where `idexchanges` = NEW.exchange_idexchange);
        set @changed = (SELECT @changed + 1);
	else
		set @exchange_symbol = (SELECT `exchange_symbol` from `exchanges` where `idexchanges` = OLD.exchange_idexchange);
    end if;

	# now we can check if something changed on the isin value
    if OLD.isin <> NEW.isin then
		set @isin_value = (SELECT `isin` from `bonds` where `bonds_id` = NEW.isin);
        set @changed = (SELECT @changed + 1);
	else
		set @isin_value = (SELECT `isin` from `bonds` where `bonds_id` = OLD.isin);
    end if;

	# build value for job
    set @job_value = (SELECT CONCAT(@exchange_symbol, '#', @isin_value));

    if @changed > 0 then
		# update on table 'downloader_jq' is needed.
        set @exchange_old = (SELECT `exchange_symbol` from `exchanges` where `idexchanges` = OLD.exchange_idexchange);
        set @job_value_old = (SELECT CONCAT(@exchange_old, '#', @isin_value));
        update `downloader_jq` set `value` = @job_value, modify_timestamp = now(), modify_user = 'TRIGGER_exchange_to_trade_AU' where `value` = @job_value_old;

        set @v_message = (SELECT CONCAT('Downloader-Job will be updated from value ', @job_value_old, ' to ', @job_value));
        call sp_insert_log('D1401', @v_message, 'TRIGGER_exchange_to_trade_AU');
	end if;

    # check if we disable or enable the pair of trading value
    # job will be enabled
    if NEW.state = 0 then
		update `downloader_jq` set `state` = 0, `modify_timestamp` = now(), `modify_user` = 'TRIGGER_exchange_to_trade_AU' where `value` = @job_value;

        set @v_message = (SELECT CONCAT('Downloader-Job will be enabled.'));
        call sp_insert_log('D1402', @v_message, 'TRIGGER_exchange_to_trade_AU');
    end if;

    # job will be disabled
    if NEW.state = 1 then
		update `downloader_jq` set `state` = 1, `modify_timestamp` = now(), `modify_user` = 'TRIGGER_exchange_to_trade_AU' where `value` = @job_value;

		set @v_message = (SELECT CONCAT('Downloader-Job will be disabled.'));
        call sp_insert_log('D1403', @v_message, 'TRIGGER_exchange_to_trade_AU');
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `exchanges`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `exchanges` (
  `idexchanges` int(11) NOT NULL AUTO_INCREMENT,
  `exchange_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exchange_symbol` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(3) CHARACTER SET utf8 NOT NULL,
  `interval` int(11) DEFAULT '0' COMMENT 'interval in seconds',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idexchanges`),
  KEY `fk_exchanges_1_idx` (`country_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import_jq`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `import_jq` (
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

--
-- Table structure for table `indicator`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `indicator` (
  `idindicator` int(11) NOT NULL AUTO_INCREMENT,
  `indicator_symbol` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `indicator_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idindicator`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indicator_jq`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `indicator_jq` (
  `idindicator_jq` int(11) NOT NULL AUTO_INCREMENT,
  `indicator_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'action --> indicator\n1000 --> SMA',
  `value` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `bond_id` int(11) NOT NULL COMMENT 'id from the stock table',
  `aggregated_time_horizon` varchar(45) CHARACTER SET utf8 NOT NULL COMMENT '1minute; 5minute; 15minute; hour; day',
  `state` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open' COMMENT 'open;pending;succesful;error',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idindicator_jq`),
  KEY `idx_value` (`value`),
  KEY `idx_bond` (`bond_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `log` (
  `idlog` int(11) NOT NULL AUTO_INCREMENT,
  `kennung` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `log_message` text COLLATE utf8_unicode_ci,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idlog`),
  KEY `idx_kennung` (`kennung`)
) ENGINE=InnoDB AUTO_INCREMENT=29683 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio_head`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `portfolio_head` (
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `portfolio_log` (
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
  CONSTRAINT `fk_portfolio_log_type1` FOREIGN KEY (`type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='log all actions on the portfolio';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio_pos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `portfolio_pos` (
  `portfolio_pos_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_portfolio_head` int(11) NOT NULL,
  `key1` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Possible keys:\nstock; currency',
  `value1` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key2` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Possible keys:\ncurrency',
  `value2` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(15,5) DEFAULT NULL,
  `exchange` int(11) NOT NULL,
  `sell` int(1) NOT NULL COMMENT '0 --> no sell\n1 --> sell it, if the position is selled we can delete it.',
  `buy` int(1) DEFAULT NULL COMMENT '0 --> no buy\n1 --> buy it',
  `delete` int(1) DEFAULT NULL COMMENT '0 --> no delete\n1 --> deleted (sold)',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `sell_price` decimal(15,5) DEFAULT '0.00000',
  `buy_price` decimal(15,5) DEFAULT '0.00000',
  PRIMARY KEY (`portfolio_pos_id`),
  KEY `fk_portfolio_head_id_idx` (`id_portfolio_head`),
  KEY `fk_portfolio_pos_exchange1_idx` (`exchange`),
  CONSTRAINT `fk_portfolio_pos_exchange1` FOREIGN KEY (`exchange`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`portfolio_pos_AFTER_INSERT`
AFTER INSERT ON `stockanalyses_prod`.`portfolio_pos`
FOR EACH ROW
BEGIN

	set @type = (select type.idtype from type where type.type_name = 'add');
	set @portfolioname = (select portfolioname from portfolio_head where portfolio_head.portfolio_head_id = new.id_portfolio_head);
	set @portfolio_type = (select `type_name` from `type` where `idtype`= (select `type` from portfolio_head where `portfolio_head_id` = NEW.id_portfolio_head));


	-- We want to buy a bond
	if new.buy = 1 then
		set @value = (select concat('Portfolio ', @portfolioname, ' has been added the bond ', new.value1, ' with a quantity of ', new.quantity, ' and price ', new.price, ' for buying.'));

		insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)
		values (NEW.id_portfolio_head, new.portfolio_pos_id, @type, @value, New.insert_user, now());

		-- Add new position to trade_queue if type of head is head
		if @portfolio_type = 'portfolio' then
			insert into `trade_queue` (`portfolio_pos`, `timestamp`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
			values (new.portfolio_pos_id, now(), now(), new.insert_user, now(), new.modify_user);
		end if;
	end if;

    -- We want to sell a bond
    if new.sell = 1 then
		set @value = (select concat('Portfolio ', @portfolioname, ' has been added the bond ', new.value1, ' with a quantity of ', new.quantity, ' and price ', new.price, ' for selling.'));

		insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)
		values (NEW.id_portfolio_head, new.portfolio_pos_id, @type, @value, New.insert_user, now());

		-- Add new position to trade_queue if type of head is head
		if @portfolio_type = 'portfolio' then
			insert into `trade_queue` (`portfolio_pos`, `timestamp`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
			values (new.portfolio_pos_id, now(), now(), new.insert_user, now(), new.modify_user);
		end if;
    end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_prod`.`portfolio_pos_AFTER_UPDATE` AFTER UPDATE ON `portfolio_pos` FOR EACH ROW
BEGIN
	if NEW.`delete` = 1 then
		set @type = (select type.idtype from type where type.type_name = 'delete');
		set @portfolioname = (select portfolioname from portfolio_head where portfolio_head.portfolio_head_id = OLD.id_portfolio_head);
		set @portfolio_type = (select `type_name` from `type` where `idtype`= (select `type` from portfolio_head where `portfolio_head_id` = OLD.id_portfolio_head));

		set @value = (select concat('Portfolio ', @portfolioname, ' has been deleted the bond ', OLD.value1, ' with a quantity of ', OLD.quantity, ' because it\'s sold.'));

		insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)
		values (OLD.id_portfolio_head, OLD.portfolio_pos_id, @type, @value, OLD.insert_user, now());
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `portfolio_pos_to_trading_strategy_head`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `portfolio_pos_to_trading_strategy_head` (
  `idportflio_pos_to_trading_strategy_head` int(11) NOT NULL AUTO_INCREMENT,
  `portfolio_pos_idportfolio_pos` int(11) NOT NULL,
  `trading_strategy_idtrading_strategy` int(11) NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idportflio_pos_to_trading_strategy_head`),
  KEY `fk_portflio_pos_to_trading_strategy_head_1_idx` (`portfolio_pos_idportfolio_pos`),
  KEY `fk_portflio_pos_to_trading_strategy_head_2_idx` (`trading_strategy_idtrading_strategy`),
  CONSTRAINT `fk_portflio_pos_to_trading_strategy_head_1` FOREIGN KEY (`portfolio_pos_idportfolio_pos`) REFERENCES `portfolio_pos` (`portfolio_pos_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portflio_pos_to_trading_strategy_head_2` FOREIGN KEY (`trading_strategy_idtrading_strategy`) REFERENCES `signals_head` (`idsignals_head`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio_setting`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `portfolio_setting` (
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
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`portfolio_setting_AFTER_INSERT`
AFTER INSERT ON `stockanalyses_prod`.`portfolio_setting`
FOR EACH ROW
BEGIN



	set @type = (select type.idtype from type where type.type_name = 'add');



    set @portfolioname = (select portfolioname from portfolio_head where portfolio_head.portfolio_head_id = new.portfolio_head);



    set @portfolio_pos_value = (select portfolio_pos.value from portfolio_pos where portfolio_pos.portfolio_pos_id = portfolio_pos);



    set @value = (select concat('Portfolio ', @portfolioname, 'mit der Position ', @portfolio_pos_value, ' hat das Attribut ', new.setting_name, ' mit dem Wert ', new.value, 'hinzugefuegt'));



	insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)

    values (NEW.portfolio_head, new.portfolio_pos, @type, @value, New.insert_user, now());





	CASE new.setting_name



    	WHEN 'dema' then call sp_insert_advice_queue(new.portfolio_head, new.portfolio_pos, new.setting_name, new.insert_user);

    END CASE;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `result_trading_strategy_head`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `result_trading_strategy_head` (
  `idresult_trading_strategy_head` int(11) NOT NULL AUTO_INCREMENT,
  `trading_strategy_head_idtrading_strategy_head` int(11) NOT NULL,
  `result` tinyint(4) NOT NULL COMMENT '0 --> false\n1 --> true',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idresult_trading_strategy_head`),
  KEY `fk_result_trading_strategy_head_1_idx` (`trading_strategy_head_idtrading_strategy_head`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `result_trading_strategy_terms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `result_trading_strategy_terms` (
  `idresult_trading_strategy_terms` int(11) NOT NULL AUTO_INCREMENT,
  `trading_strategy_terms_idtrading_strategy_terms` int(11) NOT NULL,
  `result_value` decimal(19,10) NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  PRIMARY KEY (`idresult_trading_strategy_terms`),
  KEY `fk_result_trading_strategy_terms_1_idx` (`trading_strategy_terms_idtrading_strategy_terms`),
  CONSTRAINT `fk_result_trading_strategy_terms_1` FOREIGN KEY (`trading_strategy_terms_idtrading_strategy_terms`) REFERENCES `trading_strategy_terms` (`idtrading_strategy_terms`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signals_binding`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `signals_binding` (
  `idsignals_binding` int(11) NOT NULL AUTO_INCREMENT,
  `signals_head_idsignals_head` int(11) NOT NULL,
  `trading_strategy_terms_idtrading_strategy_terms` int(11) NOT NULL,
  `order_no` int(11) NOT NULL DEFAULT '0' COMMENT 'a number to order the terms in the right way.',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idsignals_binding`),
  KEY `fk_signals_binding_1_idx` (`signals_head_idsignals_head`),
  KEY `fk_signals_binding_2_idx` (`trading_strategy_terms_idtrading_strategy_terms`),
  CONSTRAINT `fk_signals_binding_1` FOREIGN KEY (`signals_head_idsignals_head`) REFERENCES `signals_head` (`idsignals_head`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_signals_binding_2` FOREIGN KEY (`trading_strategy_terms_idtrading_strategy_terms`) REFERENCES `trading_strategy_terms` (`idtrading_strategy_terms`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `signals_head`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `signals_head` (
  `idsignals_head` int(11) NOT NULL AUTO_INCREMENT,
  `users_idusers` int(11) NOT NULL,
  `name` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `signal_type` varchar(5) CHARACTER SET utf8 NOT NULL COMMENT 'buy;sell',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0 --> disabled\n1 --> enabled',
  `bonds_idbonds` int(11) NOT NULL COMMENT 'isin\n',
  `exchanges_idexchanges` int(11) NOT NULL COMMENT 'mic',
  `signal_risk` double NOT NULL,
  `signal_risk_period` int(11) NOT NULL,
  `signal_risk_period_unit` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) CHARACTER SET utf8 NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idsignals_head`),
  KEY `fk_signals_head_1_idx` (`bonds_idbonds`),
  KEY `fk_signals_head_2_idx` (`exchanges_idexchanges`),
  KEY `fk_signals_head_3_idx` (`users_idusers`),
  CONSTRAINT `fk_signals_head_1` FOREIGN KEY (`bonds_idbonds`) REFERENCES `bonds` (`bonds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_signals_head_2` FOREIGN KEY (`exchanges_idexchanges`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_signals_head_3` FOREIGN KEY (`users_idusers`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_fee`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `trade_fee` (
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
  CONSTRAINT `fk_trade_fee_exchange1` FOREIGN KEY (`exchange`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_fee_type1` FOREIGN KEY (`type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_fee_type2` FOREIGN KEY (`fee_type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `trade_log` (
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
  CONSTRAINT `fk_trade_log_exchange1` FOREIGN KEY (`exchange`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_log_type1` FOREIGN KEY (`value_type`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_log_type2` FOREIGN KEY (`state`) REFERENCES `type` (`idtype`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='logging of trading';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade_queue`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `trade_queue` (
  `idtrade_queue` int(11) NOT NULL AUTO_INCREMENT,
  `action` int(11) NOT NULL DEFAULT '1000' COMMENT '1000 --> init\n1100 --> trade in processing\n1200 --> trade placed in ordersystem\n1300 --> order executed from ordersystem\n1400 --> job finished\n1900 --> error on Job',
  `portfolio_pos` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtrade_queue`),
  KEY `fk_trade_queue_portfolio_pos1_idx` (`portfolio_pos`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='queue for trading';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_strategy_parameters`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `trading_strategy_parameters` (
  `idtrading_strategy_parameters` int(11) NOT NULL AUTO_INCREMENT,
  `parameter_name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `parameter_value` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `trading_strategy_terms_idtrading_strategy_terms` int(11) NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtrading_strategy_parameters`),
  KEY `fk_trading_strategy_parameters_1_idx` (`trading_strategy_terms_idtrading_strategy_terms`),
  CONSTRAINT `fk_trading_strategy_parameters_1` FOREIGN KEY (`trading_strategy_terms_idtrading_strategy_terms`) REFERENCES `trading_strategy_terms` (`idtrading_strategy_terms`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_strategy_terms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `trading_strategy_terms` (
  `idtrading_strategy_terms` int(11) NOT NULL AUTO_INCREMENT,
  `indicator_idindicator` int(11) DEFAULT NULL COMMENT 'empty if ''trading_strategy_parameters_idtrading_strategy_parameters'' is an operator.',
  `tsui_idtrading_strategy_underlying_instrument` int(11) DEFAULT NULL COMMENT 'empty if ''trading_strategy_parameters_idtrading_strategy_parameters'' is an operator.',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtrading_strategy_terms`),
  KEY `fk_trading_strategy_terms_1_idx` (`indicator_idindicator`),
  KEY `fk_trading_strategy_terms_2_idx` (`tsui_idtrading_strategy_underlying_instrument`),
  CONSTRAINT `fk_trading_strategy_terms_1` FOREIGN KEY (`indicator_idindicator`) REFERENCES `indicator` (`idindicator`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trading_strategy_terms_2` FOREIGN KEY (`tsui_idtrading_strategy_underlying_instrument`) REFERENCES `trading_strategy_underlying_instrument` (`idtrading_strategy_underlying_instrument`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_strategy_underlying_instrument`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `trading_strategy_underlying_instrument` (
  `idtrading_strategy_underlying_instrument` int(11) NOT NULL AUTO_INCREMENT,
  `bonds_idbonds` int(11) NOT NULL,
  `exchanges_idexchanges` int(11) NOT NULL,
  `time_horizon` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtrading_strategy_underlying_instrument`),
  KEY `fk_trading_strategy_underlying_instrument_1_idx` (`bonds_idbonds`),
  KEY `fk_trading_strategy_underlying_instrument_2_idx` (`exchanges_idexchanges`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trend`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `trend` (
  `idtrend` int(11) NOT NULL AUTO_INCREMENT,
  `indicator` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `indicator_value` decimal(19,9) NOT NULL COMMENT 'calculated value for that indicator',
  `bond_id` int(11) NOT NULL,
  `currency_flag` tinyint(4) DEFAULT '0' COMMENT '0 --> false\n1 --> true\n',
  `stock_flag` tinyint(4) DEFAULT '0' COMMENT '0 --> false\n1 --> true',
  `delete_flag` tinyint(4) DEFAULT '0' COMMENT '0 --> false\n1 --> true',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtrend`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`trend_AFTER_INSERT` AFTER INSERT ON `trend` FOR EACH ROW
BEGIN
	-- declare variables
    declare v_base varchar(45);
    declare v_quote varchar(45);
    declare v_exchange int;
    declare v_message varchar(255);

	-- At first we need to get base, quote and exchange if it's a currency
    if new.currency_flag = 1 then
		set v_base = (select symbol_currency from currency where currency_id = (select base_currency from currency_now where currency_now_id = new.bond_id));
        set v_quote = (select symbol_currency from currency where currency_id = (select quote_currency from currency_now where currency_now_id = new.bond_id));
        set v_exchange = (select exchange_idexchange from currency_now where currency_now_id = new.bond_id);

        set @underlying_instrument_name = (select concat(v_base, '#', v_quote, '#', v_exchange));

        BEGIN
			declare done int default false;
            declare v_trendid int;
            declare v_termsid int;

			declare c1 cursor for
            select idtrading_strategy_terms from v_trading_strategy_terms_underlying_instrument
            where 1=1
            and underlying_instrument_name = @underlying_instrument_name
            and indicator_symbol = new.indicator;

            DECLARE CONTINUE HANDLER FOR NOT FOUND set done = true;

            set v_trendid = LAST_INSERT_ID();

            open c1;

            cursor_loop: loop

				fetch c1 into v_termsid;

				if done then
					leave cursor_loop;
				end if;


				insert into `result_trading_strategy_terms` (`trading_strategy_terms_idtrading_strategy_terms`, `result_value`, `insert_user`, `insert_timestamp`, `modify_user`, `modify_timestamp`)
                values (v_termsid, new.indicator_value, 'TRIGGER_trend_AI', now(), 'TRIGGER_trend_AI', now());

				set v_message = (select concat('Add value ', new.indicator_value, ' for term ', v_termsid));
                call sp_insert_log('TS1000', v_message, 'trend_TRIGGER');

			end loop cursor_loop;

			close c1;
        END;
    end if;



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `type`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `type` (
  `idtype` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`idtype`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_action`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_action` (
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

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_activation` (
  `user_activation_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `activation_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `approved` int(11) DEFAULT '0' COMMENT '0 --> disabled\n1 --> enabled (approved)',
  `insert_timestamp` datetime NOT NULL,
  `insert_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_activation_id`),
  KEY `fk_user_id_idx` (`id_user`),
  CONSTRAINT `fk_user_id1` FOREIGN KEY (`id_user`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stockanalyses_prod`.`user_activation_AFTER_INSERT` AFTER INSERT ON `user_activation` FOR EACH ROW
BEGIN
	-- generate a new email for the new user to activate his account.action
    set @email = (select email from users where user_id = NEW.id_user);
    set @username = (select username from users where user_id = NEW.id_user);
    set @activation_code = (select activation_code from user_activation where id_user = NEW.id_user);

    -- build message
    set @message = (select concat('Dear ', @username, ',\n you have to activate your account. To do this please click on the link above:\n', 'http://localhost/stockanalyses-web/users/activate/', @activation_code, '\n\n With kind regards\n', 'Stockanalyses-Team'));

    insert into email_queue (`timestamp`, `emailaddress`, `subject`, `message`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values(now(), @email, 'Activate Account', @message, now(), 'trigger_user_activation', now(), 'trigger_user_activation');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`user_activation_AFTER_UPDATE` AFTER UPDATE ON `user_activation` FOR EACH ROW
BEGIN
	set @email = (select email from users where user_id = OLD.id_user);
	set @username = (select username from users where user_id = OLD.id_user);


	if NEW.approved = 1 then
		-- generate a new email for the new user to activate his account.action
		-- build message
		set @message = (select concat('Dear ', @username, ',\n your activation was successfull.\n\n With kind regards\n', 'Stockanalyses-Team'));

		insert into email_queue (`timestamp`, `emailaddress`, `subject`, `message`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
		values(now(), @email, 'Activation successfull', @message, now(), 'trigger_user_activation', now(), 'trigger_user_activation');

        set @v_message = (SELECT CONCAT('For user ', @username, ' is a mail sent with successfull account activation.'));
        call sp_insert_log('U1002', @v_message, 'trigger_user_activation_AUPD');

        update users set state = 0, modify_timestamp = now(), modify_user = 'trigger_user_activation_AUPD' where user_id = OLD.id_user;
	else
		set @v_message = (SELECT CONCAT('The user ', @username, 'could not approved'));
		call sp_insert_log('E1007', @v_message, 'trigger_user_activation_AUPD');
    end if;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_authtoken`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `user_authtoken` (
  `iduser_authtoken` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `insert_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `insert_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `modify_timestamp` datetime NOT NULL,
  `modify_user` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`iduser_authtoken`),
  KEY `fk_user_authtoken_user_id_idx` (`user_id`),
  CONSTRAINT `fk_user_authtoken_user_id1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS `users` (
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
/*!50003 CREATE*/ /*!50003 TRIGGER `users_AINS` AFTER INSERT ON `users` FOR EACH ROW
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
-- Temporary table structure for view `v_pre_indicator_currency`
--

DROP TABLE IF EXISTS `v_pre_indicator_currency`;
/*!50001 DROP VIEW IF EXISTS `v_pre_indicator_currency`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_pre_indicator_currency` AS SELECT
 1 AS `bonds_idbonds`,
 1 AS `exchanges_idexchanges`,
 1 AS `time_horizon`,
 1 AS `indicator_symbol`,
 1 AS `settings`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'stockanalyses_prod'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `stockdata_aggregate_one_minute` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50106 EVENT `stockdata_aggregate_one_minute` ON SCHEDULE EVERY 1 MINUTE STARTS '2017-12-26 10:24:39' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
		-- declare variables
        declare v_start_date datetime;
        declare v_utctime datetime;
		declare v_close decimal(18,8);
        declare v_open decimal(18,8);
        declare v_high decimal(18,8);
        declare v_low decimal(18,8);
        declare v_volume decimal(18,8);
        DECLARE no_more_rows BOOLEAN;
        declare v_num_rows int;
        declare v_affected_rows int;
        declare v_bond int;
        declare v_exchange int;
        declare v_message text;


        declare bonds_cursor cursor for
        select `bonds_idbonds`, `exchanges_idexchanges` from `bonds_current` where `aggregated` = 0 group by `bonds_idbonds`, `exchanges_idexchanges`;

        -- Declate 'handlers' for exceptions
        DECLARE CONTINUE HANDLER FOR NOT FOUND
        set no_more_rows = TRUE;

        -- start tracking runtime of event
        set v_message = (SELECT CONCAT('Start event `stockdata_one_minute` at ', now()));
        call sp_insert_log('V1002', v_message, 'EVENT_stockdata_one_minute');


		open bonds_cursor;

        get_bonds: LOOP
			FETCH bonds_cursor INTO v_bond, v_exchange;

            IF no_more_rows THEN
				LEAVE get_bonds;
			END IF;

			-- get start date for bond and exchange pair
			set v_start_date = (select `insert_timestamp` from `bonds_current` where `aggregated` = 0 and `bonds_idbonds` = v_bond and `exchanges_idexchanges` = v_exchange limit 1);

            -- get high, low and volume data
            select max(`high`), min(`low`), max(`volume`) into v_high, v_low, v_volume
            from `bonds_current`
            where 1=1
            and `bonds_idbonds` = v_bond
            and `exchanges_idexchanges` = v_exchange
            and `aggregated` = 0
            and `insert_timestamp` between v_start_date and DATE_ADD(v_start_date, INTERVAL 1 MINUTE);

            -- get open data
            select `last` into v_open from `bonds_current`
            where 1=1
            and `bonds_idbonds` = v_bond
            and `exchanges_idexchanges` = v_exchange
            and `aggregated` = 0
            and `insert_timestamp` between v_start_date and DATE_ADD(v_start_date, INTERVAL 1 MINUTE)
            order by `insert_timestamp`
            LIMIT 1;

            -- get close and utctime data
            select `last`, `utctime` into v_close, v_utctime from `bonds_current`
            where 1=1
            and `bonds_idbonds` = v_bond
            and `exchanges_idexchanges` = v_exchange
            and `aggregated` = 0
            and `insert_timestamp` between v_start_date and DATE_ADD(v_start_date, INTERVAL 1 MINUTE)
            order by `insert_timestamp` desc
            limit 1;

            -- get num rows
            select count(`stock_current_id`) into v_num_rows from `bonds_current`
            where 1=1
            and `bonds_idbonds` = v_bond
            and `exchanges_idexchanges` = v_exchange
            and `aggregated` = 0
            and `insert_timestamp` between v_start_date and DATE_ADD(v_start_date, INTERVAL 1 MINUTE);

			-- all data collected
            update `bonds_current` set `aggregated` = 1, `modify_timestamp` = now(), `modify_user` = 'EVENT_stockdata_one_minute'
            where 1=1
            and `bonds_idbonds` = v_bond
            and `exchanges_idexchanges` = v_exchange
            and `aggregated` = 0
            and `insert_timestamp` between v_start_date and DATE_ADD(v_start_date, INTERVAL 1 MINUTE);

            set v_affected_rows = (SELECT ROW_COUNT());
            set v_message = (SELECT CONCAT('Update ', v_affected_rows, ' for aggregate one minute data on bond ', v_bond, ' and exchange ', v_exchange));
            call sp_insert_log('V1000', v_message, 'EVENT_stockdata_one_minute');

            -- insert aggregated data if we updated the same values as we found before
            IF v_num_rows = v_affected_rows THEN
				insert into `bonds_current_one_minute` (`open`, `close`, `high`, `low`, `volume`, `num_records`, `utctime`, `bonds_idbonds`, `exchanges_idexchanges`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
                values (v_open, v_close, v_high, v_low, v_volume, v_num_rows, v_utctime, v_bond, v_exchange, now(), 'EVENT_stockdata_one_minute', now(), 'EVENT_stockdata_one_minute');

                set v_message = (SELECT CONCAT('Insert aggregated data for bond ', v_bond, ' and exchange ', v_exchange, ' on utctime ', v_utctime));
                call sp_insert_log('V1001', v_message, 'EVENT_stockdata_one_minute');
			ELSE
				set v_message = (SELECT CONCAT('Aggregated data for bond ', v_bond, ' and exchange ', v_exchange, ' could not be inserted.'));
                call sp_insert_log('E1012', v_message, 'EVENT_stockdata_one_minute');
            END IF;


		END LOOP get_bonds;
        close bonds_cursor;

		set v_message = (SELECT CONCAT('End event `stockdata_one_minute` at ', now()));
        call sp_insert_log('V1003', v_message, 'EVENT_stockdata_one_minute');
    END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'stockanalyses_prod'
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
CREATE PROCEDURE `sp_insert_advice_queue`(IN `portfolio_head` INT, IN `portfolio_pos` INT, IN `portfolio_setting_name` INT, IN `insert_user` INT)
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_bonds_current` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_insert_bonds_current`(OUT sp_result int, IN sp_isin varchar(13), IN sp_high decimal(8,2), IN sp_volume decimal(18,8), IN sp_datetime datetime, IN sp_bid decimal(8,2), IN sp_ask decimal(8,2), IN sp_low decimal(8,2), IN sp_exchange varchar(5), IN sp_last decimal(8,2), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 08.08.2017
    --  Last change : 08.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, after insert some tickdata for bonds
    --
    --  08.08.2017  : Created
    --  16.08.2017  : Add paramter 'sp_last' for latest price.
    --  10.12.2017	: Change from sp_insert_currency_now to sp_insert_bonds_current
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_isin int;
    declare v_exchange int;
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;

	set v_isin = (SELECT `bonds_id` from `bonds` where `isin` = sp_isin);
    set v_exchange = (SELECT `idexchanges` from `exchanges` where `exchange_symbol` = sp_exchange);

	insert into `bonds_current`(`last`, `bid`, `ask`, `high`, `low`, `volume`, `utctime`, `bonds_idbonds`, `exchanges_idexchanges`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values (sp_last, sp_bid, sp_ask, sp_high, sp_low, sp_volume, sp_datetime, v_isin, v_exchange, now(), sp_user, now(), sp_user);

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Insert isin: ', sp_isin, ' for exchange: ', sp_exchange));
        call sp_insert_log('I1002', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('ISIN ', sp_isin, ' on exchange ', sp_exchange, '# Error-Code: ', code, '#', msg));
        call sp_insert_log('E1003', v_message, sp_user);

    end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_import_jq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_insert_import_jq`(OUT sp_result int, IN sp_action int, IN sp_id_stock varchar(200), IN sp_filename varchar(200), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 31.07.2017
    --  Last change : 31.07.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer insert data into import_jq
    --
    --  31.07.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;


	insert into import_jq(`action`, `id_stock`, `filename`, `timestamp`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values (sp_action, sp_id_stock, sp_filename, now(), now(), sp_user, now(), sp_user);

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Insert stock: ', sp_id_stock, ' with filename ', sp_filename, ' and action ', sp_action ));
        call sp_insert_log('I1003', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Stock id ', sp_id_stock, '# Error-Code: ', code, '#', msg));
        call sp_insert_log('E1001', v_message, sp_user);

    end if;

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
CREATE PROCEDURE `sp_insert_log`(IN kennung varchar(45), IN log_message text, IN insert_user varchar(200))
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_portfolio_head` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_portfolio_head`(OUT sp_result int, IN sp_portfolioname varchar(200), IN sp_capital_start int, IN sp_portfolio_type varchar(200), IN sp_portfolio_username varchar(200), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 21.08.2017
    --  Last change : 21.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, after insert a portfolio head
    --
    --  21.08.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_portfolio_type int;
    declare v_user int;
    declare v_state int;
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;

  set v_portfolio_type = (SELECT `idtype` from `type` where `type_name` = sp_portfolio_type);
  set v_user = (SELECT `user_id` from `users` where `username` = sp_portfolio_username);
  set v_state = (SELECT `idtype` from `type` where `type_name` = 'enabled');

	insert into portfolio_head (`user`, `portfolioname`, `capital_start`, `capital_current`, `type`, `state`, `insert_user`, `insert_timestamp`, `modify_user`, `modify_timestamp`)
  values(v_user, sp_portfolioname, sp_capital_start, DEFAULT, v_portfolio_type, v_state, sp_user, now(), sp_user, now());


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Add portfolio with the name ', sp_portfolioname, ' for the user ', sp_portfolio_username));
        call sp_insert_log('P1000', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Add portfolio with the name: ', sp_portfolioname, ', for the user ', sp_portfolio_username,' # Error-Code: ', code, '#', msg));
        call sp_insert_log('E1008', v_message, sp_user);

    end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_portfolio_pos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_insert_portfolio_pos`(OUT sp_result int, IN sp_portfolio_head_id int, IN sp_base varchar(4), IN sp_quote varchar(4), IN sp_unit_price decimal(15,5), IN sp_quantity int, IN sp_exchange int, IN sp_sell int, IN sp_buy int, IN sp_sell_price decimal(15,5), IN sp_buy_price decimal(15,5), IN sp_user varchar(255))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 17.09.2017
    --  Last change : 17.09.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, after insert a portfolio pos
    --
    --  17.09.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_user int;
    declare v_state int;
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;

	insert into portfolio_pos (`id_portfolio_head`, `key1`, `value1`, `key2`, `value2`, `quantity`, `price`, `exchange`, `sell`, `buy`, `sell_price`, `sp_buy_price`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
  values (sp_portfolio_head_id, 'base', sp_base, 'quote', sp_quote, sp_quantity, sp_unit_price, sp_exchange, sp_sell, sp_buy, sp_sell_price, sp_buy_price, now(), sp_user, now(), sp_user);

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Add portfolio position for base ', sp_base, ' and quote ', sp_quote, ' with unit price ', sp_unit_price, ' and quantity ', sp_quantity, ' for portfolio id ', sp_portfolio_head_id));
        call sp_insert_log('P1001', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Error in adding a portfolio position for id ', sp_portfolio_head_id, ' # Error-Code: ', code, '#', msg));
        call sp_insert_log('E1009', v_message, sp_user);

    end if;
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
CREATE PROCEDURE `sp_insert_trade_log`(IN value_type int, IN value varchar(45), IN price_insert decimal(10,0), IN price_traded decimal(10,0), IN amount double, IN exchange int, IN state int, IN insert_user int)
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_trend` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_insert_trend`(OUT sp_result int, IN sp_bond_id int, IN sp_currency_flag int, IN sp_stock_flag int, IN sp_indicator varchar(45), IN sp_value decimal(19,9), IN sp_user varchar(255))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 31.10.2017
    --  Last change : 31.10.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, after insert indicator tren
    --
    --  31.10.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

        -- declare variable
    declare v_user int;
    declare v_state int;
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;

    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;

	insert into `trend`(`indicator`, `indicator_value`, `bond_id`, `currency_flag`, `stock_flag`, `delete_flag`,`insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values (sp_indicator, sp_value, sp_bond_id, sp_currency_flag, sp_stock_flag, DEFAULT, now(), sp_user, now(), sp_user);

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Add trend for indicator ', sp_indicator, ' with value ', sp_value));
        call sp_insert_log('T1000', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Error in adding trend for indicator ', sp_indicator, ' with value ', sp_value, ' # Error-Code: ', code, '#', msg));
        call sp_insert_log('E1011', v_message, sp_user);

    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_insert_user`(OUT sp_result int, IN sp_username varchar(200), IN sp_email varchar(220), IN sp_password varchar(220), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 18.08.2017
    --  Last change : 18.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, after insert a user
    --
    --  18.08.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;


	insert into users (`username`, `email`, `password`, `country`, `insert_user`, `insert_timestamp`, `modify_user`, `modify_timestamp`)
  values(sp_username, sp_email, sp_password, 'XXX', sp_user, now(), sp_user, now());


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Insert user: ', sp_user, 'with mail: ', sp_email));
        call sp_insert_log('U1000', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('User: ', sp_username, ', email:', sp_email,' # Error-Code: ', code, '#', msg));
        call sp_insert_log('E1004', v_message, sp_user);

    end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_downloader_jq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_update_downloader_jq`(OUT sp_result int, IN sp_dj_id int, IN sp_action int, IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 04.07.2017
    --  Last change : 04.07.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer update the downloader_jq
    --
    --  04.07.2017  : Created
    --  19.12.2017	: Change from base, quote to isin handling
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_message text;
    declare v_exchange varchar(5);
    declare v_isin varchar(14);
    declare v_interval int;
    declare v_action int;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;

	-- preset action
	set v_action = 1000;

	IF sp_action = 1300 THEN
		select substring_index(`value`, '#', 1), substring_index(substring_index(`value`, '#', 2), '#', -1)
        into v_exchange, v_isin
        from downloader_jq
        where `downloader_jq_id` = sp_dj_id;

        -- get interval
        set v_interval = (select `interval` from `exchanges` where `exchange_symbol` = v_exchange);

        IF v_interval > 0 THEN
			update downloader_jq set `action` = v_action, `timestamp` = DATE_ADD(now(), INTERVAL v_interval SECOND), `modify_user` = 'sp_update_downloader_jq', `modify_timestamp` = now()
            where `downloader_jq_id` = sp_dj_id;

            set v_message = (SELECT CONCAT('Reset downloader job to action: ', v_action, '. Exchange: ', v_exchange));
            call sp_insert_log('I1000', v_message, 'sp_update_downloader_jq');
		ELSE
			set v_message = (SELECT CONCAT('No interval for the exchange: ', v_exchange));
			call sp_insert_log('I1001', v_message, 'sp_update_downloader_jq');
        END IF;
	ELSE
		update `downloader_jq` set `action` = sp_action, `modify_timestamp` = now(), `modify_user` = sp_user
        where `downloader_jq_id` = sp_dj_id;
	END IF;


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Set action to ', sp_action, ' for job with id ', sp_dj_id));
        call sp_insert_log('D1000', v_message, sp_user);

    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Job with id ', sp_dj_id, '#', code, '#', msg));
        call sp_insert_log_entry('E1000', v_message, sp_user);
    end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_email_queue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_update_email_queue`(OUT sp_result int, IN sp_new_action int, IN sp_job_id int, IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 19.08.2017
    --  Last change : 19.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer update the email_queue
    --
    --  19.08.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;


	update email_queue set `action` = sp_new_action, `modify_timestamp` = now(), `modify_user` = sp_user where `idemail_queue` = sp_job_id;


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Set action to ', sp_new_action, ' for job with id ', sp_job_id));
        call sp_insert_log('M1000', v_message, sp_user);

    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('MAil job with id ', sp_job_id, '#', code, '#', msg));
        call sp_insert_log_entry('E1005', v_message, sp_user);
    end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_import_jq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_update_import_jq`(OUT sp_result int, IN sp_current_action int, IN sp_new_action int, IN sp_filename varchar(200), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 08.08.2017
    --  Last change : 08.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer update the import_jq
    --
    --  08.08.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;


	update import_jq set `action` = sp_new_action, `modify_timestamp` = now(), `modify_user` = sp_user where `action` = sp_current_action and `filename` = sp_filename;


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Set action to ', sp_new_action, ' for job with filename ', sp_filename));
        call sp_insert_log('I1004', v_message, sp_user);

    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Job with filename ', sp_filename, '#', code, '#', msg));
        call sp_insert_log_entry('E1002', v_message, sp_user);
    end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_indicator_jq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_update_indicator_jq`(OUT sp_result int, IN sp_jobid int, IN sp_state varchar(20), IN sp_user varchar(255))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 09.10.2017
    --  Last change : 09.10.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, update indicator job
    --
    --  09.10.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;

	update indicator_jq set `state` = sp_state, `modify_timestamp` = now(), `modify_user` = sp_user
    where idindicator_jq = sp_jobid;

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Update indicator job with id ', sp_jobid, ' to state ', sp_state));
        call sp_insert_log('ID1002', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Error in updating state for job id ', sp_jobid, ' # Error-Code: ', code, '#', msg));
        call sp_insert_log('E1010', v_message, sp_user);

    end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_update_user_activation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_update_user_activation`(OUT sp_result int, IN sp_activation_code varchar(10), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 20.08.2017
    --  Last change : 20.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer update the email_queue
    --
    --  20.08.2017  : Created
    --
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------

    -- declare variable
    declare v_message text;
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;
    DECLARE rows INT;
    DECLARE result TEXT;
    -- Declare exception handler for failed insert
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
        END;


	update user_activation set `approved` = 1, `modify_timestamp` = now(), `modify_user` = sp_user where `activation_code` = sp_activation_code;


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Approve user with activation code: ', sp_activation_code));
        call sp_insert_log('U1001', v_message, sp_user);

    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('User with activation code ', sp_activation_code, ' could not approved ', '#', code, '#', msg));
        call sp_insert_log_entry('E1006', v_message, sp_user);
    end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_pre_indicator_currency`
--

/*!50001 DROP VIEW IF EXISTS `v_pre_indicator_currency`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_pre_indicator_currency` AS select `tsui`.`bonds_idbonds` AS `bonds_idbonds`,`tsui`.`exchanges_idexchanges` AS `exchanges_idexchanges`,`tsui`.`time_horizon` AS `time_horizon`,`ind`.`indicator_symbol` AS `indicator_symbol`,group_concat(concat(`tsp`.`parameter_name`,'#',`tsp`.`parameter_value`) separator ';') AS `settings` from (((((`signals_head` `tsh` join `signals_binding` `tsb` on((`tsh`.`idsignals_head` = `tsb`.`signals_head_idsignals_head`))) join `trading_strategy_terms` `tst` on((`tsb`.`trading_strategy_terms_idtrading_strategy_terms` = `tst`.`idtrading_strategy_terms`))) join `indicator` `ind` on((`tst`.`indicator_idindicator` = `ind`.`idindicator`))) join `trading_strategy_underlying_instrument` `tsui` on((`tst`.`tsui_idtrading_strategy_underlying_instrument` = `tsui`.`idtrading_strategy_underlying_instrument`))) join `trading_strategy_parameters` `tsp` on((`tst`.`idtrading_strategy_terms` = `tsp`.`trading_strategy_terms_idtrading_strategy_terms`))) group by `ind`.`indicator_symbol`,`tsui`.`bonds_idbonds`,`tsui`.`exchanges_idexchanges`,`tsui`.`time_horizon` */;
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

-- Dump completed on 2018-01-19  8:20:54
