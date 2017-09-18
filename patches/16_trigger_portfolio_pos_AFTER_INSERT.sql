USE `stockanalyses_prod`;

DELIMITER $$

DROP TRIGGER IF EXISTS stockanalyses_prod.portfolio_pos_AFTER_INSERT$$
USE `stockanalyses_prod`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `stockanalyses_prod`.`portfolio_pos_AFTER_INSERT`
AFTER INSERT ON `stockanalyses_prod`.`portfolio_pos`
FOR EACH ROW
BEGIN

	set @type = (select type.idtype from type where type.type_name = 'add');

  set @portfolioname = (select portfolioname from portfolio_head where portfolio_head.portfolio_head_id = new.id_portfolio_head);
	set @portfolio_type = (select `type_name` from `type` where `idtype`= (select `type` from portfolio_head where `portfolio_head_id` = NEW.id_portfolio_head));

  set @value = (select concat('Portfolio ', @portfolioname, ' has been added the bond ', new.value1, ' with a quantity of ', new.quantity, ' and price ', new.price));

	insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)
  values (NEW.id_portfolio_head, new.portfolio_pos_id, @type, @value, New.insert_user, now());

  -- Add new position to trade_queue if type of head is head
  if @portfolio_type = 'portfolio' then
		insert into `trade_queue` (`portfolio_pos`, `trade_type`, `timestamp`, `insert_timestamp`, `insert_user`, `modify_timestamp`, `modify_user`)
    values (new.portfolio_pos_id, 'buy', now(), now(), new.insert_user, now(), new.modify_user);
  end if;
	
END$$
DELIMITER ;
