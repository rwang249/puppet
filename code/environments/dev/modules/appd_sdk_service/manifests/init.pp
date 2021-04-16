# Copy script files, ensure that it is created as a service and make sure that it runs on shutdown/startup

class appd_sdk_service {

	file { '/etc/init.d/appdynamics-sdk-agent':
		ensure => file,
		source => 'puppet:///modules/appd_sdk_service/appdynamics-sdk-agent',
		mode   => '0744',
		owner  => 'root',
		group  => 'root',
	}

	exec { 'Add service to startup/shutdown':
		command   => '/sbin/chkconfig --add appdynamics-sdk-agent',
		subscribe => [
				File['/etc/init.d/appdynamics-sdk-agent'],
		],
		refreshonly => true,
	}
}

