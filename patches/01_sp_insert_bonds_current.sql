USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_insert_bonds_current`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_insert_bonds_current`(OUT sp_result int, IN sp_isin varchar(13), IN sp_high decimal(18,8), IN sp_volume decimal(18,8), IN sp_datetime datetime, IN sp_bid decimal(18,8), IN sp_ask decimal(18,8), IN sp_low decimal(18,8), IN sp_exchange varchar(5), IN sp_last decimal(18,8), IN sp_user varchar(200))
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
    --  27.01.2018	: Change datatype length from decimal(8,2) to decimal(18,8)
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

END$$

DELIMITER ;
