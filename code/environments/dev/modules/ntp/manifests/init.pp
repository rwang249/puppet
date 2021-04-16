# Make sure the ntp package is installed, provide the configuration file to the nodes and make sure the service is running

class ntp {
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
