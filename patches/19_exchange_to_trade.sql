CREATE TABLE `stockanalyses_prod`.`exchange_to_trade` (
  `idexchange_to_trade` INT NOT NULL AUTO_INCREMENT,
  `base` VARCHAR(45) NOT NULL,
  `quote` VARCHAR(45) NOT NULL,
  `exchange_idexchange` INT NOT NULL,
  `state` INT NOT NULL COMMENT '0 --> enabled\n1 --> disabled',
  `insert_timestamp` DATETIME NOT NULL,
  `insert_user` VARCHAR(45) NOT NULL,
  `modify_timestamp` DATETIME NOT NULL,
  `modify_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idexchange_to_trade`),
  INDEX `fk_exchange_to_trade_exchange1_idx` (`exchange_idexchange` ASC),
  CONSTRAINT `fk_exchange_to_trade_exchange1`
    FOREIGN KEY (`exchange_idexchange`)
    REFERENCES `stockanalyses_prod`.`exchange` (`idexchange`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
