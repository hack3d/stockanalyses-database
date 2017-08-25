ALTER TABLE `stockanalyses_prod`.`currency_now`
ADD COLUMN `last` DECIMAL(15,5) NULL DEFAULT NULL AFTER `exchange_idexchange`;
