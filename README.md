# Stockanalyses database
Here is the base database schema for stockanalyses and all the patches.
We have to run the command as follow: `sudo ./run.sh <mysql-user> <mysql-password> <mysql-host>`

## Logging
General: Every recognition starts with a letter. This letter specify a job.
| Letter | Job |
----------------
| D | Downloader for several stock and currency data. |
| I | Is responsible to import all the downloaded data correctly. |
| E | All errors in database log will start with this letter. |


| Recoginition | Description |
-------------------------------
| I1000 | Reset the downloader job |
| I1001 | The exchange has no interval. So we didn't create a new job. |
| I1002 | Insert new dataset to table 'currency_now'. |
| I1003 | New Job for Importer added. |
| I1004 | Set action to a specific valie for a job. |
| D1000 | Update downloader job with id xxx successfull. |
| D1300 | Set action to a specific value for a job. |
| E1000 | Downloader job with id xxx couldn't updated. |
| E1001 | Insert into import_jq didn't work. |
| E1002 | Update of job for import_jq didn't work. |
| E1003 | Insert of new dataset into table 'currency_now' didn't work. |
