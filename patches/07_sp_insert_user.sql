USE `stockanalyses_prod`;
DROP procedure IF EXISTS `sp_insert_user`;

DELIMITER $$
USE `stockanalyses_prod`$$
CREATE PROCEDURE `sp_insert_user` (OUT sp_result int, IN sp_username varchar(200), IN sp_email varchar(220), IN sp_password varchar(220), IN sp_user varchar(200))
BEGIN
    -- ------------------------------------------------------------
    -- ------------------------------------------------------------
    --                  Copyright by Raphael Lekies 2017
    -- ------------------------------------------------------------
    --  Created     : 18.08.2017
    --  Last change : 18.08.2017
    --  Version     : 1.0
    --  Author      : Raphael Lekies
    --  Description : We insert log entries, after insert a user
    --
    --  18.08.2017  : Created
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


	insert into users (`username`, `email`, `password`, `country`, `insert_user`, `insert_timestamp`, `modify_user`, `modify_timestamp`)
  values(sp_username, sp_email, sp_password, 'XXX', sp_user, now(), sp_user, now());


	-- check whether the insert was successful
    IF code = '00000' THEN
        -- insert was successfull
        set sp_result = 1;

        -- now we can write a log
        set v_message = (SELECT CONCAT('Insert user: ', sp_user, 'with mail: ', sp_email));
        call sp_insert_log('U1000', v_message, sp_user);


    else
        -- insert failed
        set sp_result = 0;

        -- now we can write a log
        -- debugging
        set v_message = (SELECT CONCAT('User: ', sp_username, ', email:', sp_email,' # Error-Code: ', code, '#', msg));
        call sp_insert_log('E1004', v_message, sp_user);

    end if;

END$$

DELIMITER ;
