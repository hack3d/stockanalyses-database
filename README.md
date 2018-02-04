# Stockanalyses database
Here is the base database schema for stockanalyses and all the patches.
We have to run the command as follow: `sudo ./run.sh <mysql-user> <mysql-password> <mysql-host>`


## Events
For stock data aggregation we use the mysql events. So we have to enable them `SET GLOBAL event_scheduler = ON;`


## Logging
General: Every recognition starts with a letter. This letter specify a job.

| Letter | Job |
| ------ | --- |
| D | Downloader for several stock and currency data. |
| I | Is responsible to import all the downloaded data correctly. |
| ID | Indicator |
| E | All errors in database log will start with this letter. |
| W | Warnings for the application. |
| M | Mail |
| T | Trend |
| TS | Trading Strategy |
| U | Users |
| P | Portfoliomanagement |
| V | MySQL Eventscheduler / Cron |
| X | Exchange |


Possible codes at the logging table 'log':

| Recoginition | Description |
| ------------ | ----------- |
| I1000 | Reset the downloader job |
| I1001 | The exchange has no interval. So we didn't create a new job. |
| I1002 | Insert new dataset to table 'currency_now'. |
| I1003 | New Job for Importer added. |
| I1004 | Set action to a specific valie for a job. |
| ID1001 | New entry for indicator_jq. |
| ID1002 | Update indicator job state. |
| ID1003 | No new entry for indicator_jq because we import the same stockdata. |
| D1000 | Update downloader job with id xxx successfull. |
| D1300 | Set action to a specific value for a job. |
| E1000 | Downloader job with id xxx couldn't updated. |
| E1001 | Insert into import_jq didn't work. |
| E1002 | Update of job for import_jq didn't work. |
| E1003 | Insert of new dataset into table 'currency_now' didn't work. |
| E1004 | Something went wrong to insert a new user. |
| E1005 | Update of job for email_queue didn't work. |
| E1006 | User could not approved. |
| E1007 | Email for successfully activation could not generated. |
| E1008 | It's not possible to add a portfolio. |
| E1009 | It's not possible to add a position to the portfolio. |
| E1010 | State for indicator job could not be updated. |
| E1011 | Could not insert trend for indicator. |
| E1012 | Could not insert one minute aggregated data. |
| E1013 | Something went wrong with the transaction. |
| T1000 | Add trend for specific indicator. |
| TS1000 | Add new result from indicator to trading strategy. |
| U1000 | Insert a new user. |
| U1001 | Approve user. |
| U1002 | Approved user get a mail. |
| M1000 | Update email_queue job. |
| P1000 | Add a portfolio for an user. |
| P1001 | Add a portfolio position. |
| W1000 | The downloader job already exists and is disabled. |
| W1001 | The downloader job already exists and is enabled. No further action. |
| D1400 | New downloader created. |
| D1401 | Downloader job will be updated from old to new value. |
| D1402 | Downloader job will be enabled. |
| D1403 | Downloader job will be disabled.
| V1000 | Update n rows of aggregated data for bond and exchange. |
| V1001 | Insert aggregated data for one minute. |
| V1002 | Start event tracking. |
| V1003 | End event tracking. |

## Versioning
I can't find a solution that fits our needs for database migration and versioning we will do it by hand.
