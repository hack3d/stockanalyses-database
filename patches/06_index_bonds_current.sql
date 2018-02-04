use `stockanalyses_prod`;
set @x := (select count(*) from information_schema.statistics where table_name = 'bonds_current' and index_name = 'aggregated_idx' and table_schema = database());
set @sql_1 := if( @x > 0, 'select ''Index exists.''', 'Alter Table bonds_current ADD Index `aggregated_idx` (`aggregated`);');
PREPARE stmt FROM @sql_1;
EXECUTE stmt;

set @y := (select count(*) from information_schema.statistics where table_name = 'bonds_current' and index_name = 'bonds_exchange_aggregated_idx' and table_schema = database());
set @sql_2 := if( @y > 0, 'select ''Index exists.''', 'Alter Table bonds_current ADD Index `bonds_exchange_aggregated_idx` (`aggregated`, `bonds_idbonds`, `exchanges_idexchanges`);');
PREPARE stmt FROM @sql_2;
EXECUTE stmt;
