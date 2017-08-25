USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_insert_portfolio_head`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_insert_portfolio_head` (OUT sp_result int, IN sp_portfolioname varchar(200), IN sp_capital_start int, IN sp_portfolio_type varchar(200), IN sp_portfolio_username varchar(200), IN sp_user varchar(200))
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

END$$

DELIMITER ;
