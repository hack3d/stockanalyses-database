ALTER TABLE `stockanalyses_prod`.`indicator_jq`
CHANGE COLUMN `action` `indicator_name` VARCHAR(45) NOT NULL COMMENT 'action --> indicator\n1000 --> SMA' ,
CHANGE COLUMN `value` `value` VARCHAR(200) CHARACTER SET 'utf8' NOT NULL ,
CHANGE COLUMN `state` `state` INT(11) NOT NULL COMMENT '0 --> active\n1 --> inactive' ,
ADD COLUMN `bond_id` INT NOT NULL COMMENT 'id from the currency or stock table' AFTER `timestamp`,
ADD COLUMN `currency_flag` TINYINT NOT NULL DEFAULT 0 COMMENT '0 --> false\n1 --> true' AFTER `bond_id`,
ADD COLUMN `stock_flag` TINYINT NOT NULL DEFAULT 0 COMMENT '0 --> false\n1 --> true' AFTER `currency_flag`;


ALTER TABLE `stockanalyses_prod`.`indicator_jq`
CHANGE COLUMN `state` `state` INT(11) NOT NULL DEFAULT 0 COMMENT '0 --> active\n1 --> inactive' ;

ALTER TABLE `stockanalyses_prod`.`indicator_jq`
CHANGE COLUMN `state` `state` VARCHAR(20) NOT NULL DEFAULT 'open' COMMENT 'open;pending;succesful;error' ;
