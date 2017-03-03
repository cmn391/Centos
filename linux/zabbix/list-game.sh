#!/bin/bash

IP=$(ifconfig | grep "inet addr" | awk {'print $2'} | head -2 | awk -F: {'print $2'})
tmp=$(netstat -vantp | grep GatewayServer)

if [ $? == 0 ]; then
                tmp1=$(netstat -vantp | grep EST | awk {'print$5'} | grep -vw 203.162.121.* | grep -vw 203.162.171.* | grep -vw 222.73.33.130)
                        if [ $? == 0 ]; then
                                echo "$IP is Game Server"
                        else
                                echo "$IP No Client Connect"
                        fi
else
                echo "$IP is Free Server"
fi

