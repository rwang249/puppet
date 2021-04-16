#!/bin/bash

/bin/rpm -qa | grep -E 'katello-ca-consumer-satellite.blah.com-1.0-1.noarch|katello-ca-consumer-satellite.blah.com-1.0-2.noarch|katello-ca-consumer-satellite.blah.com-1.0-3.noarch|katello-ca-consumer-satellite.blah.com-1.0-4.noarch'

if [ $? -eq 0 ];
then
        yum remove -y 'katello-ca-consumer*'
        yum localinstall -y 'http://satellite.blah.com/pub/katello-ca-consumer-latest.noarch.rpm'
fi

/bin/rpm -qa | grep -E 'katello-ca-consumer-satellite.blah.com-*.*-*.noarch'

if [ $? -eq 1 ];
then
	rpm -Uvh http://satellite.blah.com/pub/katello-ca-consumer-latest.noarch.rpm
		
fi

