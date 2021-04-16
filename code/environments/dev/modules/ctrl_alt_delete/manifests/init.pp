class ctrl_alt_delete {

        if $facts['os']['name'] == 'RedHat' {
                if $facts['os']['release']['major'] == '6' {

		        file { '/etc/init/control-alt-delete.override':
	                	ensure => file,
	                	source => 'puppet:///modules/ctrl_alt_delete/control-alt-delete.override',
		        }
                }
                elsif $facts['os']['release']['major'] == '7' {
			
			service { 'ctrl-alt-del.target':
				enable => mask,
			}
                }
        }

}
