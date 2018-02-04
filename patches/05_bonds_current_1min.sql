CREATE TABLE IF NOT EXISTS `stockanalyses_prod`.`bonds_current_1minute` (
  `idbonds_current_1minute` int(11) NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`idbonds_current_1minute`),
  KEY `fk_bonds_current_1minute_1_idx` (`bonds_idbonds`),
  KEY `fk_bonds_current_1minute_2_idx` (`exchanges_idexchanges`),
  CONSTRAINT `fk_bonds_current_1minute_1` FOREIGN KEY (`bonds_idbonds`) REFERENCES `bonds` (`bonds_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bonds_current_1minute_2` FOREIGN KEY (`exchanges_idexchanges`) REFERENCES `exchanges` (`idexchanges`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DELIMITER ;;
/*!50003 CREATE*/ /*!50003 TRIGGER `stockanalyses_prod`.`bonds_current_1minute_AFTER_INSERT` AFTER INSERT ON `bonds_current_1minute` FOR EACH ROW
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
    set v_bondid = (select new.idbonds_current_1minute);

    -- Do some standard logging
    set v_message = (select concat('Insert new dataset for isin ', v_isin, ' and exchange ', v_exchange, ' with the id ', v_bondid));
    call sp_insert_log('I1002', v_message, 'bonds_current_1minute_TRIGGER');

    -- Get all portfolios with a trading strategy for the incoming currency pair
    OPEN cursor1;

    cursor_loop: loop
		  fetch cursor1 into v_indicator, v_indicator_setting, v_time_horizon;

      if done then
		    leave cursor_loop;
		  end if;

      -- select previous tickdata and compare
      select `open`, `close`, `high`, `low`, `volume`, `utctime` into v_stock_open, v_stock_close, v_stock_high, v_stock_low, v_stock_volume, v_stock_utctime
      from bonds_current_1minute
		  where 1=1
		  and bonds_idbonds = new.bonds_idbonds
		  and exchanges_idexchanges = new.exchanges_idexchanges
		  order by insert_timestamp desc
		  limit 1,1;

      IF (v_stock_open != new.`open` OR v_stock_close != new.`close` OR v_stock_high != new.`high` OR v_stock_low != new.`low` OR v_stock_volume != new.`volume` OR v_stock_utctime != new.`utctime`) THEN
			   insert into `indicator_jq` (`indicator_name`, `value`, `timestamp`, `aggregated_time_horizon`, `bond_id`,`insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
			   values (v_indicator, v_indicator_setting, now(), v_time_horizon, v_bondid, now(), 'bonds_current_1minute_TRIGGER_AI', now(), 'bonds_current_1minute_TRIGGER_AI');

         set v_message = (select concat('New Job for for indicator: ', v_indicator, ' for bond ', v_isin, ' and exchange ', v_exchange));
			   call sp_insert_log('ID1001', v_message, 'bonds_current_1minute_TRIGGER');
		  ELSE
			   set v_message = (select concat('No new Job for for indicator: ', v_indicator, ' for bond ', v_isin, ' and exchange ', v_exchange));
			   call sp_insert_log('ID1003', v_message, 'bonds_current_1minute_TRIGGER');
      END IF;

    end loop cursor_loop;
    close cursor1;
END */;;
