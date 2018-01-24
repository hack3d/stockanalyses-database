ALTER TABLE `stockanalyses_prod`.`advice_queue`
DROP FOREIGN KEY `fk_advice_queue_portfolio_setting1`;
ALTER TABLE `stockanalyses_prod`.`advice_queue`
DROP COLUMN `portfolio_setting_name`,
DROP COLUMN `portfolio_head`,
DROP INDEX `fk_advice_queue_portfolio_setting1_idx` ,
ADD INDEX `fk_advice_queue_portfolio_setting1_idx` (`portfolio_pos` ASC);
ALTER TABLE `stockanalyses_prod`.`advice_queue`
ADD CONSTRAINT `fk_advice_queue_portfolio_setting1`
  FOREIGN KEY (`portfolio_pos`)
  REFERENCES `stockanalyses_prod`.`portfolio_setting` (`portfolio_pos`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `stockanalyses_prod`.`advice_queue`
DROP FOREIGN KEY `fk_advice_queue_type1`;
ALTER TABLE `stockanalyses_prod`.`advice_queue`
CHANGE COLUMN `state` `state` VARCHAR(20) NOT NULL COMMENT 'pending;succesful;error' ,
DROP INDEX `fk_advice_queue_type1_idx` ;


ALTER TABLE `stockanalyses_prod`.`advice_queue`
CHANGE COLUMN `state` `state` VARCHAR(20) CHARACTER SET 'utf8' NOT NULL DEFAULT 'open' COMMENT 'open;pending;succesful;error' ;


ALTER TABLE `stockanalyses_prod`.`advice_queue`
DROP FOREIGN KEY `fk_advice_queue_portfolio_setting1`;
ALTER TABLE `stockanalyses_prod`.`advice_queue`
ADD INDEX `fk_advice_queue_portfolio_setting1_idx` (`portfolio_pos` ASC),
DROP INDEX `fk_advice_queue_portfolio_setting1_idx` ;
ALTER TABLE `stockanalyses_prod`.`advice_queue`
ADD CONSTRAINT `fk_advice_queue_portfolio_setting1`
  FOREIGN KEY (`portfolio_pos`)
  REFERENCES `stockanalyses_prod`.`portfolio_pos` (`portfolio_pos_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `stockanalyses_prod`.`advice_queue`
ADD COLUMN `indicator` VARCHAR(200) NOT NULL COMMENT 'possible values are: sma, macd, rsi' AFTER `portfolio_pos`,
ADD COLUMN `settings` VARCHAR(200) NOT NULL COMMENT 'all values stored values will be seperated by \'#\'.' AFTER `indicator`,
ADD COLUMN `bond_id` INT NOT NULL AFTER `settings`,
ADD COLUMN `currency_flag` TINYINT NOT NULL COMMENT 'set this flag if the \'bond_id\' is a currency' AFTER `bond_id`,
ADD COLUMN `stock_flag` TINYINT NOT NULL COMMENT 'set this flag if the \'bond_id\' is a stock' AFTER `currency_flag`;
