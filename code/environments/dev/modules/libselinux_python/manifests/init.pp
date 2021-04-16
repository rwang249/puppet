#used to install a package for RHEL7 which caused an issue running Ansible playbooks via satellite

class libselinux_python {

        if $facts['os']['name'] == 'RedHat' {
                if $facts['os']['release']['major'] == '7' {

        		package { 'libselinux-python':
                		ensure => present,
        		}
		}
	}
}

