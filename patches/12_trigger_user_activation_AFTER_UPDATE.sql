CREATE DEFINER = CURRENT_USER TRIGGER `stockanalyses_prod`.`user_activation_AFTER_UPDATE` AFTER UPDATE ON `user_activation` FOR EACH ROW
BEGIN
  set @email = (select email from users where user_id = OLD.id_user);
  set @username = (select username from users where user_id = OLD.id_user);


  if NEW.approved = 1 then
    -- generate a new email for the new user to activate his account.action
    -- build message
    set @message = (select concat('Dear ', @username, ',\n your activation was successfull.\n\n With kind regards\n', 'Stockanalyses-Team'));

    insert into email_queue (`timestamp`, `emailaddress`, `subject`, `message`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values(now(), @email, 'Activation successfull', @message, now(), 'trigger_user_activation', now(), 'trigger_user_activation');

    set @v_message = (SELECT CONCAT('For user ', @username, ' is a mail sent with successfull account activation.'));
    call sp_insert_log('U1002', @v_message, 'trigger_user_activation_AUPD');

    update users set state = 0, modify_timestamp = now(), modify_user = 'trigger_user_activation_AUPD' where user_id = OLD.id_user;
  else
    set @v_message = (SELECT CONCAT('The user ', @username, 'could not approved'));
    call sp_insert_log('E1007', @v_message, 'trigger_user_activation_AUPD');
  end if;
END
