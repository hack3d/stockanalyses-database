use stockanalyses_prod;
DROP PROCEDURE IF EXISTS `sp_stockdata_aggregate_1min`;

DELIMITER $$
CREATE PROCEDURE `sp_stockdata_aggregate_1min` (OUT sp_result int)
BEGIN
  -- ------------------------------------------------------------
  -- ------------------------------------------------------------
  --                  Copyright by Raphael Lekies 2018
  -- ------------------------------------------------------------
  --  Created     : 01.02.2018
  --  Last change : 01.02.2018
  --  Version     : 1.0
  --  Author      : Raphael Lekies
  --  Description : Aggregate stockdata for a specific time horizon
  --
  --  01.02.2018  : Created
  --
  -- ------------------------------------------------------------
  -- ------------------------------------------------------------

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
    DECLARE code CHAR(5) DEFAULT '00000';
    DECLARE msg TEXT;


    declare bonds_cursor cursor for
    select `bonds_idbonds`, `exchanges_idexchanges` from `bonds_current` where `aggregated` = 0 group by `bonds_idbonds`, `exchanges_idexchanges`;

    -- Declate 'handlers' for exceptions
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    set no_more_rows = TRUE;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
          GET DIAGNOSTICS CONDITION 1
                code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
          set v_message = (SELECT CONCAT('sp_aggreagte_1min # Error-Code: ', code, '#', msg));
          call sp_insert_log('E1013', v_message, 'sp_stockdata_aggregate_1min');
          set sp_result = 0;
          ROLLBACK;
        END;


    -- start tracking runtime of event
    set v_message = (SELECT CONCAT('Start procedure `stockdata_aggregate` with time horizon 1 minute at ', now()));
    call sp_insert_log('V1002', v_message, 'sp_stockdata_aggregate_1min');

    open bonds_cursor;

    get_bonds: LOOP
      FETCH bonds_cursor INTO v_bond, v_exchange;

      IF no_more_rows THEN
		    LEAVE get_bonds;
	    END IF;

		  -- get start date for bond and exchange pair
      START TRANSACTION;
		  set v_start_date = (select `insert_timestamp` from `bonds_current` where `aggregated` = 0 and `bonds_idbonds` = v_bond and `exchanges_idexchanges` = v_exchange limit 1);

      -- get high, low and volume data
      select max(`last`), min(`last`), max(`volume`) into v_high, v_low, v_volume
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
      call sp_insert_log('V1000', v_message, 'sp_stockdata_aggregate_1min');

      -- insert aggregated data if we updated the same values as we found before
      IF v_num_rows = v_affected_rows THEN
		    insert into `bonds_current_1minute` (`open`, `close`, `high`, `low`, `volume`, `num_records`, `utctime`, `bonds_idbonds`, `exchanges_idexchanges`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
        values (v_open, v_close, v_high, v_low, v_volume, v_num_rows, v_utctime, v_bond, v_exchange, now(), 'sp_stockdata_1minute', now(), 'sp_stockdata_1minute');

        set v_message = (SELECT CONCAT('Insert aggregated data for bond ', v_bond, ' and exchange ', v_exchange, ' on utctime ', v_utctime));
        call sp_insert_log('V1001', v_message, 'sp_stockdata_aggregate_1min');
        set sp_result = 1;
      ELSE
			   set v_message = (SELECT CONCAT('Aggregated data for bond ', v_bond, ' and exchange ', v_exchange, ' could not be inserted.'));
         call sp_insert_log('E1012', v_message, 'sp_stockdata_aggregate_1min');
         set sp_result = 0;
      END IF;
      COMMIT;

    END LOOP get_bonds;
    close bonds_cursor;

		set v_message = (SELECT CONCAT('End procedure `stockdata_aggregate` at ', now()));
    call sp_insert_log('V1003', v_message, 'sp_stockdata_aggregate_1min');
END;
$$
