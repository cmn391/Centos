#!/bin/bash

case $1 in 
	status)
	Slave_SQL_Running=`echo "show slave status\G;" | HOME=/var/lib/zabbix mysql -N | head -13 | tail -1`
	Slave_IO_Running=`echo "show slave status\G;" | HOME=/var/lib/zabbix mysql -N | head -12 | tail -1`

	if [ "$Slave_SQL_Running" != "Yes" ] || [ "$Slave_IO_Running" != "Yes" ] ; then
		echo 0
	else 
		echo 1
	fi
	;;
	delay)
	echo "show slave status\G;" | HOME=/var/lib/zabbix mysql -N | tail -8  | head -1
	;;
	*)
	echo "Sorry, we don't have this option"
	;;
esac
