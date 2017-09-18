USE `stockanalyses_prod`;
CREATE VIEW `v_portfolio` AS
    SELECT
        `ph`.`portfolio_head_id` AS `portfolio_head_id`,
        `ph`.`portfolioname` AS `portfolioname`,
        `ph`.`capital_start` AS `capital_start`,
        `ph`.`capital_current` AS `capital_current`,
        `ph`.`type` AS `ph_type`,
        `ph`.`state` AS `ph_state`,
        `ph`.`modify_timestamp` AS `ph_modify_timestamp`,
        `ph`.`modify_user` AS `ph_modify_user`,
        `pp`.`portfolio_pos_id` AS `portfolio_pos_id`,
        `pp`.`key1` as `pp_key1`,
        `pp`.`value1` AS `pp_value1`,
        `pp`.`key2` as `pp_key2`,
        `pp`.`value2` as `pp_value2`,
        `pp`.`quantity` AS `pp_quantity`,
        `pp`.`price` AS `pp_price`,
        (`pp`.`price` * `pp`.`quantity`) AS `pp_investment`,
        `e`.`exchange_name` AS `pp_exchange`,
        `u`.`username` AS `username`
    FROM
        ((`portfolio_head` `ph`
        LEFT JOIN `portfolio_pos` `pp` ON ((`pp`.`id_portfolio_head` = `ph`.`portfolio_head_id`)))
        JOIN `exchange` `e` ON ((`pp`.`exchange` = `e`.`idexchange`)))
        JOIN `users` `u` ON ((`ph`.`user` = `u`.`user_id`)));
