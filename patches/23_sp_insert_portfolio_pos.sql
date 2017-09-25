USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_insert_portfolio_pos`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_portfolio_pos`(OUT sp_result int, IN sp_portfolio_head_id int, IN sp_base varchar(4), IN sp_quote varchar(4), IN sp_unit_price decimal(15,5), IN sp_quantity int, IN sp_exchange int, IN sp_sell int, IN sp_buy int, IN sp_sell_price decimal(15,5), IN sp_buy_price decimal(15,5), IN sp_user varchar(255))
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
END$$

DELIMITER ;
