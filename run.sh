#!/bin/bash

# import database at first
mysql -h $3 -u $1 -p$2 < /opt/stockanalyses-database/stockanalyses_prod.sql 

# create mysql user for every daemon
mysql -h $3 -u $1 -p$2 < /opt/stockanalyses-database/create_user_stock-downloader.sql
mysql -h $3 -u $1 -p$2 < /opt/stockanalyses-database/create_user_stock-importer.sql
