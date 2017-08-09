ALTER TABLE `stockanalyses_prod`.`downloader_jq` 
ADD COLUMN `downloader_jq_id` INT NOT NULL AUTO_INCREMENT FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`downloader_jq_id`);

