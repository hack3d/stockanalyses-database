ALTER TABLE `stockanalyses_prod`.`portfolio_pos`
CHANGE COLUMN `value` `value1` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL COMMENT 'stock or currency' ,
ADD COLUMN `key1` VARCHAR(45) NOT NULL COMMENT 'Possible keys:\nstock; currency' AFTER `id_portfolio_head`,
ADD COLUMN `key2` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Possible keys:\ncurrency' AFTER `value1`,
ADD COLUMN `value2` VARCHAR(45) NULL DEFAULT NULL AFTER `key2`;
