class appd_agents {
	
	file { '/opt/appdynamics':
		ensure => directory,
	}	

	file { '/opt/appdynamics/appdynamics-machine-agent-4.4.3.1214.x86_64.rpm': 
		ensure	=> file,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0755',
		source	=> 'puppet:///modules/appd_agents/appdynamics-machine-agent-4.4.3.1214.x86_64.rpm',	
	}

	exec { 'Install machine-agent':
		command	=> "/bin/rpm -i /opt/appdynamics/appdynamics-machine-agent-4.4.3.1214.x86_64.rpm",
		creates => '/opt/appdynamics/machine-agent/readme.txt',
		subscribe => File['/opt/appdynamics/appdynamics-machine-agent-4.4.3.1214.x86_64.rpm'],
	} 

	file { '/opt/appdynamics/machine-agent/conf/controller-info.xml':
 		ensure  => present,
  		owner   => 'root',
  		group   => 'root',
  		mode    => '0600',
  		source  => 'puppet:///modules/appd_agents/controller-info.xml',
	}

        service { 'appdynamics-machine-agent':
                enable  => true,
                ensure  => running,
        }

	file { '/opt/appdynamics/appdynamics-sdk-native-nativeWebServer-64bit-linux-4.4.0.29501.tar.gz':
                ensure => file,
		owner   => 'root',
		group  => 'root',
		mode   => '0755',
                source => 'puppet:///modules/appd_agents/appdynamics-sdk-native-nativeWebServer-64bit-linux-4.4.0.29501.tar.gz',
        }

        file { '/opt/appdynamics/AppServerAgent-4.4.3.23079.zip':
                ensure => file,
                owner   => 'root',
                group  => 'root',
                mode   => '0755',
                source => 'puppet:///modules/appd_agents/AppServerAgent-4.4.3.23079.zip',
        }

	file { '/opt/appdynamics/appd-netviz-x64-linux-4.4.3.728.rpm':
		ensure => file,
		owner => 'root',
		group => 'root',
		mode  => '0755',
		source => 'puppet:///modules/appd_agents/appd-netviz-x64-linux-4.4.3.728.rpm',
	}

        file { '/opt/appdynamics/tuxedomonitor-1.1.3.zip':
                ensure => file,
                owner => 'root',
                group => 'root',
                mode  => '0755',
                source => 'puppet:///modules/appd_agents/tuxedomonitor-1.1.3.zip',
        }

        file { '/opt/appdynamics/datapowermonitor-1.3.7.zip':
                ensure => file,
                owner => 'root',
                group => 'root',
                mode  => '0755',
                source => 'puppet:///modules/appd_agents/datapowermonitor-1.3.7.zip',
        }

        file { '/opt/appdynamics/AppServerAgent-ibm-4.4.3.23079.zip':
                ensure => file,
                owner   => 'root',
                group  => 'root',
                mode   => '0755',
                source => 'puppet:///modules/appd_agents/AppServerAgent-ibm-4.4.3.23079.zip',
        }

}
