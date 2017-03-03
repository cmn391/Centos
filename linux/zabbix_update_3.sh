#!/bin/bash
function Update
{
  rm -rf /etc/zabbix/zabbix_agentd.conf ; rm -rf /etc/zabbix/zabbix_agent.conf
  sed -i 's:123.31.21.5:123.31.21.4:g' /etc/zabbix_agentd.conf
  
  #/sbin/iptables -D INPUT -p tcp --dport 10050 -s 123.31.21.5 -j ACCEPT -m comment --comment "This rule is monitor zabbix";
  #add rule new
  #/sbin/iptables -nL --line-numbers;
  #/sbin/iptables -I INPUT 7 -p tcp --dport 10050 -s 123.31.21.4 -j ACCEPT -m comment --comment "This rule is monitor zabbix";
  /sbin/iptables -nL --line-numbers |egrep 123.31.21.5 |egrep "tcp dpt:10050"
  if [[ $? == 0 ]];then
      /sbin/iptables -D INPUT -p tcp --dport 10050 -s 123.31.21.5 -j ACCEPT -m comment --comment "This rule is monitor zabbix";
  fi
  #add rule new
  /sbin/iptables -nL --line-numbers;
  #/sbin/iptables -I INPUT 7 -p tcp --dport 10050 -s 123.31.21.4 -j ACCEPT -m comment --comment "This rule is monitor zabbix";
  /sbin/iptables -nL --line-numbers |egrep 123.31.21.4 |egrep "tcp dpt:10050"
  if [[ $? != 0 ]];then
      /sbin/iptables -I INPUT  -p tcp --dport 10050 -s 123.31.21.4 -j ACCEPT -m comment --comment "This rule is monitor zabbix";
  fi
  ln -s /etc/zabbix_* /etc/zabbix/ 
  #Restart service
  /etc/init.d/iptables save; /etc/init.d/iptables restart; /etc/init.d/zabbix-agent restart
}
  #call function
  Update
