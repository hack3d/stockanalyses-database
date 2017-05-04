#!/bin/bash

# import database at first
mysql -h $3 -u $1 -p$2 < /opt/stockanalyses-database/stockanalyses_prod.sql 

# create mysql user for every daemon
mysql -h $3 -u $1 -p$2 < /opt/stockanalyses-database/create_user_stock-downloader.sql
mysql -h $3 -u $1 -p$2 < /opt/stockanalyses-database/create_user_stock-importer.sql

# customize config files
# stockanalyses-downloader
if [ -f "/opt/stockanalyses-downloader/lib/python3.5/site-packages/downloader/config" ]; then
	sed -i "s/^servername=localhost/servername=$3/" /opt/stockanalyses-downloader/lib/pyhton3.5/site-packages/downloader/config
	sed -i "s/^username=sql-user/username=stock-downloader/" /opt/stockanalyses-downloader/lib/pyhton3.5/site-packages/downloader/config
	sed -i "s/^password=123456/password=Stock-2017!/" /opt/stockanalyses-downloader/lib/pyhton3.5/site-packages/downloader/config
	sed -i "s/^database=stockanalyses_v2/database=stockanalyses_prod/" /opt/stockanalyses-downloader/lib/pyhton3.5/site-packages/downloader/config
fi

# stockanalyses-importer
if [ -f "/opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config" ]; then
	sed -i "s/^servername=localhost/servername=$3/" /opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config
	sed -i "s/^username=sql-user/username=stock-importer/" /opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config
	sed -i "s/^password=123456/password=Stock-2017!/" /opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config
	sed -i "s/^database=stockanalyses_v2/database=stockanalyses_prod/" /opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config
fi