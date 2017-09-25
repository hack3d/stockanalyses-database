DELIMITER $$

DROP TRIGGER IF EXISTS stockanalyses_prod.portfolio_pos_AFTER_UPDATE$$
USE `stockanalyses_prod`$$
CREATE DEFINER = CURRENT_USER TRIGGER `stockanalyses_prod`.`portfolio_pos_AFTER_UPDATE` AFTER UPDATE ON `portfolio_pos` FOR EACH ROW
BEGIN
	if NEW.`delete` = 1 then
		set @type = (select type.idtype from type where type.type_name = 'delete');
		set @portfolioname = (select portfolioname from portfolio_head where portfolio_head.portfolio_head_id = OLD.id_portfolio_head);
		set @portfolio_type = (select `type_name` from `type` where `idtype`= (select `type` from portfolio_head where `portfolio_head_id` = OLD.id_portfolio_head));

		set @value = (select concat('Portfolio ', @portfolioname, ' has been deleted the bond ', OLD.value1, ' with a quantity of ', OLD.quantity, ' because it\'s sold.'));

		insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)
		values (OLD.id_portfolio_head, OLD.portfolio_pos_id, @type, @value, OLD.insert_user, now());
	end if;
END$$
DELIMITER ;
