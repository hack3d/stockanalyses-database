USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_update_import_jq`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_update_import_jq` (OUT sp_result int, IN sp_current_action int, IN sp_new_action int, IN sp_filename varchar(200), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 08.08.2017
    --  Last change : 08.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer update the import_jq
    --
    --  08.08.2017  : Created
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


	update import_jq set `action` = sp_new_action, `modify_timestamp` = now(), `modify_user` = sp_user where `action` = sp_current_action and `filename` = sp_filename;


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Set action to ', sp_new_action, ' for job with filename ', sp_filename));
        call sp_insert_log('I1004', v_message, sp_user);

    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Job with filename ', sp_filename, '#', code, '#', msg));
        call sp_insert_log_entry('E1002', v_message, sp_user);
    end if;


END$$

DELIMITER ;
