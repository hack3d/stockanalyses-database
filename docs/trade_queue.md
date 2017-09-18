# trade_queue
In this table all orders(buy,sell) wil be queued. A trading job will place the
order at an ordersystem. All actions will be reported in 'trade_log' table.

## table schema

| column | datatype | description | possible values |
| ------ | -------- | ----------- | --------------- |
| idtrade_queue | int (pk, ai) | This field will be filled automatically. |  |
| action | int | A state which reported the current situation of the job. | 1000 --> init; 1100 --> trade in processing; 1200 --> trade placed in ordersystem; 1300 --> order executed from ordersystem; 1400 --> job finished; 1900 --> error on Job |
| trade_type | varchar(45) | Tells us if we want to buy or sell the bond. | buy; sell |
| portfolio_pos | int | The position of the portfolio which we want to trade. |  |
| timestamp | datetime | The timestamp on which the trade should executed. |  |
| insert_timestamp | datetime | timestamp on which the row was inserted. |  |
| insert_user | varchar(45) | the user which inserted the row. |  |
| modify_timestamp | datetime | the timestamp on which the row was updated. |  |
| modify_user | varchar(45) | the user which updated the row. |  |


Trigger has to be added to automatically report all the action.
