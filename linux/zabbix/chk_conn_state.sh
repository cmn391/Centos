#!/bin/bash

case $1 in
	EST)
	netstat -an | grep EST | wc -l
	;;
	SYN_SENT)
	netstat -an | grep SYN_SE | wc -l
	;;
	SYN_RECV)
	netstat -an | grep SYN_RE | wc -l
	;;
	FIN_WAIT1)
	netstat -an | grep FIN_WAIT1 | wc -l
	;;
	FIN_WAIT2)
	netstat -an | grep FIN_WAIT2 | wc -l
	;;
	TIME_WAIT)
	netstat -an | grep TIME_WAIT | wc -l
	;;
	CLOSED)
	netstat -an | grep CLOSED | wc -l
	;;
	CLOSE_WAIT)
	netstat -an | grep CLOSE_WAIT | wc -l
	;;
	LAST_ACK)
	netstat -an | grep LAST_ACK | wc -l
	;;
	CLOSING)
	netstat -an | grep CLOSING | wc -l
	;;
	UNKNOWN)
	netstat -an | grep UNKNOWN | wc -l
	;;
	*)
	echo "we don't have this option"
	;;
esac
