USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_insert_import_jq`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_insert_import_jq` (OUT sp_result int, IN sp_action int, IN sp_id_stock varchar(200), IN sp_filename varchar(200), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 31.07.2017
    --  Last change : 31.07.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, atfer insert data into import_jq
    --
    --  31.07.2017  : Created
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


	insert into import_jq(`action`, `id_stock`, `filename`, `timestamp`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values (sp_action, sp_id_stock, sp_filename, now(), now(), sp_user, now(), sp_user);

	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Insert stock: ', sp_id_stock, ' with filename ', sp_filename, ' and action ', sp_action ));
        call sp_insert_log('I1003', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('Stock id ', sp_id_stock, '# Error-Code: ', code, '#', msg));
        call sp_insert_log('E1001', v_message, sp_user);

    end if;

END$$

DELIMITER ;
