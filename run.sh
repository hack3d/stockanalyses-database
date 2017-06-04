#!/bin/bash

# check if there is a valid mysql-client available
if [ ! -z "$(which mysql)" ]; then
	MYSQL="$(which mysql)"
else
	MYSQL="$(which mysqlaccess)"
fi

hostname=""
username=""
password=""

hostname=$(dialog --backtitle "Configure database" --inputbox "Enter hostname of the database" 8 52 3>&1 1>&2 2>&3 3>&-)
username=$(dialog --backtitle "Configure database" --inputbox "Enter username of the database" 8 52 3>&1 1>&2 2>&3 3>&-)
password=$(dialog --backtitle "Configure database" --inputbox "Enter password of the database" 8 52 3>&1 1>&2 2>&3 3>&-)


# import database at first
${MYSQL} -h ${hostname} -u ${username} -p${password} < /opt/stockanalyses-database/stockanalyses_prod.sql
${MYSQL} -h ${hostname} -u ${username} -p${password} < /opt/stockanalyses-database/data.sql

# create mysql user for every daemon
${MYSQL} -h ${hostname} -u ${username} -p${password} < /opt/stockanalyses-database/create_user_stock-downloader.sql
${MYSQL} -h ${hostname} -u ${username} -p${password} < /opt/stockanalyses-database/create_user_stock-importer.sql


# customize config files
# stockanalyses-downloader
if [ -f "/opt/stockanalyses-downloader/lib/python3.5/site-packages/downloader/config" ]; then
	sed -i "s/^servername=localhost/servername=${hostname}/" "/opt/stockanalyses-downloader/lib/python3.5/site-packages/downloader/config"
	sed -i "s/^username=sql-user/username=stock-downloader/" "/opt/stockanalyses-downloader/lib/python3.5/site-packages/downloader/config"
	sed -i "s/^password=123456/password=Stock-2017!/" "/opt/stockanalyses-downloader/lib/python3.5/site-packages/downloader/config"
	sed -i "s/^database=stockanalyses_v2/database=stockanalyses_prod/" "/opt/stockanalyses-downloader/lib/python3.5/site-packages/downloader/config"
fi

# stockanalyses-importer
if [ -f "/opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config" ]; then
	sed -i "s/^servername=localhost/servername=${hostname}/" "/opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config"
	sed -i "s/^username=sql-user/username=stock-importer/" "/opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config"
	sed -i "s/^password=123456/password=Stock-2017!/" "/opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config"
	sed -i "s/^database=stockanalyses_v2/database=stockanalyses_prod/" "/opt/stockanalyses-importer/lib/python3.5/site-packages/importer/config"
fi