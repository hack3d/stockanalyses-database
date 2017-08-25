USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_update_email_queue`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_update_email_queue` (OUT sp_result int, IN sp_new_action int, IN sp_job_id int, IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 19.08.2017
    --  Last change : 19.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer update the email_queue
    --
    --  19.08.2017  : Created
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


	update email_queue set `action` = sp_new_action, `modify_timestamp` = now(), `modify_user` = sp_user where `idemail_queue` = sp_job_id;


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Set action to ', sp_new_action, ' for job with id ', sp_job_id));
        call sp_insert_log('M1000', v_message, sp_user);

    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('MAil job with id ', sp_job_id, '#', code, '#', msg));
        call sp_insert_log_entry('E1005', v_message, sp_user);
    end if;


END$$

DELIMITER ;
