#1/bin/bash


case $1 in
	total)
	echo "SELECT (PagesTotal*PageSize) DataMB FROM (SELECT variable_value PagesTotal FROM information_schema.global_status WHERE variable_name='INNODB_BUFFER_POOL_PAGES_TOTAL') A, (SELECT variable_value PageSize FROM information_schema.global_status WHERE variable_name='Innodb_page_size') B;" | HOME=/var/lib/zabbix mysql -N 
	;;
	used)
	echo "SELECT (PagesData*PageSize) DataMB FROM (SELECT variable_value PagesData FROM information_schema.global_status WHERE variable_name='INNODB_BUFFER_POOL_PAGES_DATA') A, (SELECT variable_value PageSize FROM information_schema.global_status WHERE variable_name='Innodb_page_size') B;" | HOME=/var/lib/zabbix mysql -N
	;;
	%used)
	echo "SELECT (PagesData*100)/PagesTotal FROM (SELECT variable_value PagesData FROM information_schema.global_status WHERE variable_name='Innodb_buffer_pool_pages_data') A, (SELECT variable_value PagesTotal FROM information_schema.global_status WHERE variable_name='Innodb_buffer_pool_pages_total') B;" | HOME=/var/lib/zabbix mysql -N
	;;
	hitrate)
	x=`echo "show engine innodb status\G;" | HOME=/var/lib/zabbix mysql -N | grep "Buffer pool hit rate" | awk '{print $5}'`
	hit=$(echo $x/10 | bc)
	echo $hit
esac
