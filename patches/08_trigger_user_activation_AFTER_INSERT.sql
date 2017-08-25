USE `stockanalyses_prod`;

DELIMITER $$

DROP TRIGGER IF EXISTS stockanalyses_prod.user_activation_AFTER_INSERT$$
USE `stockanalyses_prod`$$
CREATE DEFINER = CURRENT_USER TRIGGER `stockanalyses_prod`.`user_activation_AFTER_INSERT` AFTER INSERT ON `user_activation` FOR EACH ROW
BEGIN
	-- generate a new email for the new user to activate his account.action
    set @email = (select email from users where user_id = NEW.id_user);
    set @username = (select username from users where user_id = NEW.id_user);
    set @activation_code = (select activation_code from user_activation where id_user = NEW.id_user);

    -- build message
    set @message = (select concat('Dear ', @username, ',\n you have to activate your account. To do this please click on the link above:\n', 'http://localhost/stockanalyses-web/users/activate/', @activation_code, '\n\n With kind regards\n', 'Stockanalyses-Team'));

    insert into email_queue (`timestamp`, `emailaddress`, `subject`, `message`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values(now(), @email, 'Activate Account', @message, now(), 'trigger_user_activation', now(), 'trigger_user_activation');
END$$
DELIMITER ;
