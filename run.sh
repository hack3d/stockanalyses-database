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

# check if we set all information (hostname, username, password)
if [ ! -z "$hostname" ] && [ ! -z "$username" ] && [ ! -z "$password" ] ; then

    # import database at first
    ${MYSQL} -h ${hostname} -u ${username} -p${password} < /opt/stockanalyses-database/stockanalyses_prod.sql
    ${MYSQL} -h ${hostname} -u ${username} -p${password} < /opt/stockanalyses-database/data.sql

fi
