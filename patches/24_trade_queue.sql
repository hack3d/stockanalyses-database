ALTER TABLE `stockanalyses_prod`.`trade_queue`
ADD COLUMN `action` INT(11) NOT NULL DEFAULT 1000 COMMENT '1000 --> init\n1100 --> trade in processing\n1200 --> trade placed in ordersystem\n1300 --> order executed from ordersystem\n1400 --> job finished\n1900 --> error on Job' AFTER `idtrade_queue`;
