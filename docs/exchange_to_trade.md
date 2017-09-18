# exchange_to_trade
Here we define the value pairs which are possible to trade. If we create a new
pair of tradable values then it will be add it to the table 'downloader_jq'.

## table schema

| column | datatype | description | possible values |
| ------ | -------- | ----------- | --------------- |
| idexchange_to_trade | int (pk, ai) | This field will be filled automatically. |  |
| base | varchar(45) | base value for trading from table 'currency' or 'stock'. |  |
| quote | varchar(45) | quote value for trading from table 'currency'. |  |
| exchange_idexchange | int | the id from the table 'exchange' which we want to trade on. |  |
| state | int | with this we define if the row is enabled or disabled. if the value changed we have to change the job on table 'downloader_jq'. | 0 --> enabeld; 1 --> disabled |
| insert_timestamp | datetime | timestamp on which the row was inserted. |  |
| insert_user | varchar(45) | the user which inserted the row. |  |
| modify_timestamp | datetime | the timestamp on which the row was updated. |  |
| modify_user | varchar(45) | the user which updated the row. |  |


## Trigger: exchange_to_trade_AFTER_INSERT
With this trigger we insert or update the table 'downloader_jq'. We insert a
new job if there is no one yet. Update of a job will happen if it's disabled. So
we enable it.

## Trigger: exchange_to_trade_AFTER_UPDATE
This trigger update the table 'downloader_jq'. This happens if the state
changed, base, quote or exchange.
