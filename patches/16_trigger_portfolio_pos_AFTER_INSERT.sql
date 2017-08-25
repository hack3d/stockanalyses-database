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

    set @value = (select concat('Portfolio ', @portfolioname, ' has been added the bond ', new.value1, ' with a quantity of ', new.quantity, ' and price ', new.price));

	insert into portfolio_log (portfolio_head, portfolio_pos, type, value, insert_user, insert_timestamp)

    values (NEW.id_portfolio_head, new.portfolio_pos_id, @type, @value, New.insert_user, now());

END$$
DELIMITER ;
