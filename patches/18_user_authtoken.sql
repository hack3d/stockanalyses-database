CREATE TABLE `stockanalyses_prod`.`user_authtoken` (
  `iduser_authtoken` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `insert_timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `insert_user` VARCHAR(45) NOT NULL,
  `modify_timestamp` DATETIME NOT NULL,
  `modify_user` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iduser_authtoken`),
  INDEX `fk_user_authtoken_user_id_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_authtoken_user_id1`
    FOREIGN KEY (`user_id`)
    REFERENCES `stockanalyses_prod`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
