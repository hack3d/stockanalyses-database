USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_update_indicator_jq`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_update_indicator_jq` (OUT sp_result int, IN sp_jobid int, IN sp_state varchar(20), IN sp_user varchar(255))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 09.10.2017
    --  Last change : 09.10.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, update indicator job
    --
    --  09.10.2017  : Created
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

	update indicator_jq set `state` = sp_state, `modify_timestamp` = now(), `modify_user` = sp_user
    where idindicator_jq = sp_jobid;

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Update indicator job with id ', sp_jobid, ' to state ', sp_state));
        call sp_insert_log('ID1002', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Error in updating state for job id ', sp_jobid, ' # Error-Code: ', code, '#', msg));
        call sp_insert_log('E1010', v_message, sp_user);

    end if;

END$$

DELIMITER ;
