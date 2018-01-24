USE `stockanalyses_prod`;
CREATE  OR REPLACE VIEW `v_pre_indicator_currency` AS
select
`c1`.`currency_id` as `base`,
`c2`.`currency_id` as `quote`,
`pp`.`exchange` as `exchange`,
`tsp`.`key1` as `trading_strategy_pos_key1`,
`tsp`.`value1` as `trading_strategy_pos_value1`,
group_concat(concat(`tsps`.`key1`, '#',`tsps`.`value1`) SEPARATOR ';') as `settings`
from portfolio_pos_to_trading_strategy_head pp2tsh
inner join portfolio_pos pp on pp2tsh.portfolio_pos_idportfolio_pos = pp.portfolio_pos_id
inner join trading_strategy_head tsh on pp2tsh.trading_strategy_head_idtrading_strategy_head = tsh.idtrading_strategy_head
inner join trading_strategy_pos tsp on tsh.idtrading_strategy_head = tsp.trading_strategy_head_idtrading_strategy_head
inner join trading_strategy_pos_setting tsps on tsp.idtrading_strategy_pos = tsps.trading_strategy_pos_idtrading_strategy_pos
inner join currency c1 on pp.value1 = c1.symbol_currency
inner join currency c2 on pp.value2 = c2.symbol_currency
group by `c1`.`currency_id`, `c2`.`currency_id`, `pp`.`exchange`, `tsp`.`key1`, `tsp`.`value1`;;
