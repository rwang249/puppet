# Copy patchinglog script files, ensure that it is created as a service and make sure that it runs on shutdown/startup

class patchinglog {

        if $facts['os']['name'] == 'RedHat' {
                if $facts['os']['release']['major'] == '6' {

                        notify { 'rhel6patchinglog':
                                message => 'OS is RHEL 6',
                        }
        		file { '/root/scripts/patchinglog.sh':
                		ensure => file,
                		source => 'puppet:///modules/patchinglog/rhel6/patchinglog.sh',
                		mode   => '0744',
                		owner  => 'root',
                		group  => 'root',
       		 	}

			exec { 'run patchinglogrh6' :
				command => '/bin/sh /root/scripts/patchinglog.sh', 
			}
		}
                elsif $facts['os']['release']['major'] == '7' {
                        notify { 'rhel7patchinglog':
                                message => 'OS is RHEL 7',
                        }
                        file { '/root/scripts/patchinglog.sh':
                                ensure => file,
                                source => 'puppet:///modules/patchinglog/rhel7/patchinglog.sh',
                                mode   => '0744',
                                owner  => 'root',
                                group  => 'root',
                        }

                        exec { 'run patchinglogrh7' :
                                command => '/bin/sh /root/scripts/patchinglog.sh',
                        }
                }



	}
}

