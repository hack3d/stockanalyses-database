USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_insert_currency_now`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_insert_currency_now` (OUT sp_result int, IN sp_base varchar(20), IN sp_quote varchar(20), IN sp_high decimal(8,2), IN sp_volume decimal(12,8), IN sp_datetime datetime, IN sp_bid decimal(8,2), IN sp_ask decimal(8,2), IN sp_vwap decimal(8,2), IN sp_low decimal(8,2), IN sp_exchange int, IN sp_last decimal(8,2), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 08.08.2017
    --  Last change : 08.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, after insert some tickdata for currencies
    --
    --  08.08.2017  : Created
    --  16.08.2017  : Add paramter 'sp_last' for latest price.
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


	insert into currency_now(`base_currency`, `quote_currency`, `high`, `volume`, `latest_trade`, `bid`, `ask`, `currency_volume`, `low`, `exchange_idexchange`, `last`, `insert_timestamp`, `insert_user`)
    values (sp_base, sp_quote, sp_high, sp_volume, sp_datetime, sp_bid, sp_ask, sp_vwap, sp_low, sp_exchange, sp_last, now(), sp_user);

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Insert base: ', sp_base, ' and quote: ', sp_quote, ' for exchange ', sp_exchange ));
        call sp_insert_log('I1002', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Base ', sp_base, ' and quote ', sp_quote, ' on exchange ', sp_exchnage, '# Error-Code: ', code, '#', msg));
        call sp_insert_log('E1003', v_message, sp_user);

    end if;

END$$

DELIMITER ;
