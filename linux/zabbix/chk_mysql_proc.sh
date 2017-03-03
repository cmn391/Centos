#!/bin/bash

case $1 in
	UNAUTH)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep "unauthenticated user" | wc -l
	;;
	LOCKED1)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep "Locked" | wc -l
	;;
	LOCKED2)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep "Waiting for .* lock" | wc -l
	;;
	LOCKED3)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep "Table lock" | wc -l
	;;
	LOCKED4)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep "Waiting for table flush" | wc -l
	;;
	LOCKED5)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep "Waiting for tables" | wc -l
	;;
	COPYIN)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep ".*opy.* to.* table.*" | wc -l
	;;
	STAT)
	echo "show processlist;" | HOME=/var/lib/zabbix mysql -N  | grep "statistics" | wc -l
	;;
	*)
	echo "Sorry. We don't support this option"
	;;
esac
