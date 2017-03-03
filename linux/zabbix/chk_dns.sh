#!/bin/sh
if test -z "$1" ; then
    echo "You need to supply a DNS server to check. Quitting"
    exit 0;
fi

DOMAIN=$1
SERVER=$2
OPTION=$3

{ time nslookup $DOMAIN $SERVER 2>&1 > /dev/null; } 2> /tmp/check_dns.log
status=$?

case $OPTION in
	status)
	if [ $status == 0 ]; then
		echo 1;
	else
		echo 0;
	fi
	;;
	perf)
	time_m=`cat /tmp/check_dns.log | grep real | awk '{print $2}' | awk -F"m" '{print $1}'`
	time_s=`cat /tmp/check_dns.log | grep real | awk '{print $2}' | awk -F"m" '{print $2}' | awk -F"s" '{print $1}'`
	if [ $time_m -gt 0 ]; then
		echo $time_m;
	else
		echo $time_s;
	fi
	;;
esac	
#MYTIME=$((time dig $DOMAIN +trace) 2>&1| grep real | cut -dm -f 2 | awk -F"s" '{print $1}')
#if [ $? -eq 0 ]; then
#    echo $MYTIME
#else
#    echo 0
#fi
