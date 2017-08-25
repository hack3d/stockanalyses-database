USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_update_user_activation`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_update_user_activation` (OUT sp_result int, IN sp_activation_code varchar(10), IN sp_user varchar(200))
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


END$$

DELIMITER ;
