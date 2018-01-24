USE `stockanalyses_prod`;

DELIMITER $$

DROP TRIGGER IF EXISTS stockanalyses_prod.currency_now_AFTER_INSERT$$
USE `stockanalyses_prod`$$
CREATE DEFINER=`root`@`localhost` TRIGGER stockanalyses_prod.currency_now_AFTER_INSERT
	AFTER INSERT
	ON stockanalyses_prod.currency_now
	FOR EACH ROW
BEGIN
	declare v_base varchar(4);
    declare v_quote varchar(4);
    declare v_message varchar(255);
    declare v_indicator varchar(255);
    declare v_indicator_setting varchar(255);
    declare v_bondid int;
    declare done int default false;
    DECLARE cursor1 CURSOR FOR
    select trading_strategy_pos_value1, settings from v_pre_indicator_currency
	where 1=1
    and `trading_strategy_pos_key1` = 'indicator'
	and `base` = new.base_currency
	and `quote` = new.quote_currency
    and `exchange` = new.exchange_idexchange;

    DECLARE CONTINUE HANDLER FOR NOT FOUND set done = true;


    set v_base = (select symbol_currency from currency where currency_id = new.base_currency);
    set v_quote = (select symbol_currency from currency where currency_id = new.quote_currency);
    set v_bondid = LAST_INSERT_ID();

    -- Do some standard logging
    set v_message = (select concat('Insert new dataset for base ', v_base, ' and quote ', v_quote, ' with the id ', v_bondid));
    call sp_insert_log('I1002', v_message, 'currency_now_TRIGGER');

		-- Get all portfolios with a trading strategy for the incoming currency pair
    OPEN cursor1;

    cursor_loop: loop

		fetch cursor1 into v_indicator, v_indicator_setting;

		if done then
		 leave cursor_loop;
		end if;


			insert into `indicator_jq` (`indicator_name`, `value`, `timestamp`, `bond_id`, `currency_flag`, `stock_flag`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
      values (v_indicator, v_indicator_setting, now(), v_bondid, 1, 0, now(), 'currency_now_TRIGGER_AI', now(), 'currency_now_TRIGGER_AI');

      set v_message = (select concat('New Job for for indicator: ', v_indicator, ' for bond ', v_base, '/', v_quote));
      call sp_insert_log('ID1001', v_message, 'currency_now_TRIGGER');


	end loop cursor_loop;

    close cursor1;

END$$
DELIMITER ;
