ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
DROP FOREIGN KEY `fk_portfolio_pos_type1`;
ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
DROP COLUMN `state`,
DROP INDEX `fk_portfolio_pos_type1_idx` ;

ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
CHANGE COLUMN `price` `price` DECIMAL(15,5) NULL DEFAULT NULL ;
