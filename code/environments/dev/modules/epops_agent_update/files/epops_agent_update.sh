#!/bin/bash

epops_agent=$(/bin/rpm -qa | grep 'epops-agent')

if [ "$epops_agent" != "epops-agent-7.0.0-9957520.x86_64" ];
then
	rpm -e "$epops_agent"
	rpm -Uhv '/root/agents/vRealize-Endpoint-Operations-Management-Agent-x86-64-linux-7.0.0-9957520.rpm'
	cp -f /root/scripts/vmware/epops_agent.properties /opt/vmware/epops-agent/conf/agent.properties
	chown epops:epops /opt/vmware/epops-agent/conf/agent.properties
	chmod 600 /opt/vmware/epops-agent/conf/agent.properties
fi

/bin/rpm -qa | grep 'VMware-Log-Insight-Agent-4.7.0-9602262.noarch'

if [ $? -eq 1 ];
then
        rpm -Uhv '/root/agents/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm'
fi

if [ ! -f /root/scripts/vmware/.updatedepops ];
then
	touch /root/scripts/vmware/.updatedepops
fi
