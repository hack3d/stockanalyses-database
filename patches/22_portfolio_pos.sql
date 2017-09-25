ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
DROP FOREIGN KEY `fk_portfolio_pos_type1`;
ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
DROP COLUMN `state`,
DROP INDEX `fk_portfolio_pos_type1_idx` ;

ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
CHANGE COLUMN `price` `price` DECIMAL(15,5) NULL DEFAULT NULL ;

ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
ADD COLUMN `sell` INT(1) NOT NULL COMMENT '0 --> no sell\n1 --> sell it, if the position is selled we can delete it.' AFTER `modify_user`;

ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
CHANGE COLUMN `sell` `sell` INT(1) NOT NULL COMMENT '0 --> no sell\n1 --> sell it, if the position is selled we can delete it.' AFTER `exchange`,
ADD COLUMN `buy` INT(1) NULL COMMENT '0 --> no buy\n1 --> buy it' AFTER `sell`;

ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
ADD COLUMN `delete` INT(1) NULL COMMENT '0 --> no delete\n1 --> deleted (sold)' AFTER `buy`;
USE `stockanalyses_prod`;

ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
ADD COLUMN `sell_price` DECIMAL(15,5) NULL DEFAULT 0 AFTER `modify_user`,
ADD COLUMN `buy_price` DECIMAL(15,5) NULL DEFAULT 0 AFTER `sell_price`;
