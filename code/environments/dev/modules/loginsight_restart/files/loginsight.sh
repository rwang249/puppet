#!/bin/bash


/bin/rpm -qa | grep 'VMware-Log-Insight-Agent-4.7.0-9602262.noarch'

if [ $? -eq 1 ];
then
        rpm -Uhv '/root/agents/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm'
fi

if [ ! -f /root/scripts/vmware/.updatedepops ];
then
	touch /root/scripts/vmware/.updatedepops
fi
