ALTER TABLE `stockanalyses_prod`.`email_queue`
ADD COLUMN `action` INT NOT NULL DEFAULT 1000 AFTER `idemail_queue`;
