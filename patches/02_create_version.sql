CREATE TABLE IF NOT EXISTS `stockanalyses_prod`.`version` (
  `version_number` INT NOT NULL COMMENT 'version number of the database schema');

INSERT INTO `stockanalyses_prod`.`version` (`version_number`) VALUES (1);
