USE `stockanalyses_prod`;

DELIMITER $$

DROP TRIGGER IF EXISTS stockanalyses_prod.exchange_to_trade_AFTER_INSERT$$
USE `stockanalyses_prod`$$
CREATE DEFINER = CURRENT_USER TRIGGER `stockanalyses_prod`.`exchange_to_trade_AFTER_INSERT` AFTER INSERT ON `exchange_to_trade` FOR EACH ROW
BEGIN
	# at first we try to find the exchange symbol
  set @exchange_symbol = (SELECT `exchange_symbol` from `exchange` where `idexchange` = NEW.exchange_idexchange);

	# now we check if the job already exists
  set @job_value = (SELECT CONCAT(@exchange_symbol, '#', NEW.base, '#', NEW.quote));
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

END$$
DELIMITER ;
