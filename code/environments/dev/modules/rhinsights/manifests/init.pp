class rhinsights {
        if $facts['os']['name'] == 'RedHat' {
                if $facts['os']['release']['major'] == '8' {

                        notify { 'rhel8insights':
                                message => 'OS is RHEL 8',
                        }

						package { 'insights-client':
								ensure => present,
						}

						exec { 'register' :
								command => '/usr/bin/insights-client --register',
								unless => '/usr/bin/rpm -qa|/usr/bin/grep insights-client',
						}

		}
	}
}


