USE `stockanalyses_prod`;

DELIMITER $$

DROP TRIGGER IF EXISTS stockanalyses_prod.exchange_to_trade_AFTER_UPDATE$$
USE `stockanalyses_prod`$$
CREATE DEFINER = CURRENT_USER TRIGGER `stockanalyses_prod`.`exchange_to_trade_AFTER_UPDATE` AFTER UPDATE ON `exchange_to_trade` FOR EACH ROW
BEGIN

	# set variable to track if something changed so we have to update the table
  # 'downloader_jq'
  set @changed = 0;

	# at first we check if new and old exchange is the same
  if OLD.exchange_idexchange <> NEW.exchange_idexchange then
		set @exchange_symbol = (SELECT `exchange_symbol` from `exchange` where `idexchange` = NEW.exchange_idexchange);
    set @changed = (SELECT @changed + 1);
	else
		set @exchange_symbol = (SELECT `exchange_symbol` from `exchange` where `idexchange` = OLD.exchange_idexchange);
  end if;

	# now we can check if something changed on the base and quote values
  if OLD.base <> NEW.base then
		set @base_value = (SELECT NEW.base);
    set @changed = (SELECT @changed + 1);
	else
		set @base_value = (SELECT OLD.base);
  end if;

  if OLD.quote <> NEW.quote then
		set @quote_value = (SELECT NEW.quote);
    set @changed = (SELECT @changed + 1);
	else
		set @quote_value = (SELECT OLD.quote);
  end if;

	# build value for job
    set @job_value = (SELECT CONCAT(@exchange_symbol, '#', @base_value, '#', @quote_value));

    if @changed > 0 then
		# update on table 'downloader_jq' is needed.
        set @exchange_old = (SELECT `exchange_symbol` from `exchange` where `idexchange` = OLD.exchange_idexchange);
        set @job_value_old = (SELECT CONCAT(@exchange_old, '#', @base_value, '#', @quote_value));
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
END$$
DELIMITER ;
