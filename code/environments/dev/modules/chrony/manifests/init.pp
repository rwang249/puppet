# Make sure the ntp package is installed, provide the configuration file to the nodes and make sure the service is running
# Please only apply Chrony to RHEL 8 onwards

class chrony {
        if $facts['os']['name'] == 'RedHat' {
                if $facts['os']['release']['major'] == '7' {

                        notify { 'rhel7ntp':
                                message => 'OS is RHEL 7',
                        }
						package {'ntp' :
								ensure => present,
						}
						file { '/etc/ntp.conf':
								ensure => file,
								source => 'puppet:///modules/ntp/ntp.conf',
						}
						exec { 'restart ntpd' :
								command => '/sbin/service ntpd restart',
								subscribe => [
										File['/etc/ntp.conf'],
								],
								refreshonly => true,
						}
						service { 'ntpd':
								ensure => running,
								enable => true,
						}
				}
				elsif $facts['os']['release']['major'] == '8' {
                        notify { 'rhel8chrony':
                                message => 'OS is RHEL 8',
                        }
						package {'chrony' :
								ensure => present,
						}
						file { '/etc/chrony.conf':
								ensure => file,
								source => 'puppet:///modules/chrony/chrony.conf',
						}
						exec { 'restart chronyd' :
								command => '/usr/bin/systemctl restart chronyd',
								subscribe => [
										File['/etc/chrony.conf'],
								],
								refreshonly => true,
						}
						service { 'chronyd':
								ensure => running,
								enable => true,
						}
				}
        }
}



