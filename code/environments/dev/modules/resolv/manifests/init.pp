class resolv {
        file { '/etc/resolv.conf':
                ensure => file,
                source => 'puppet:///modules/resolv/resolv.conf',
        }

        file_line { 'DNS2':
                ensure  => 'absent',
                path    => "/etc/sysconfig/network-scripts/ifcfg-${facts['networking']['primary']}",
                line    => 'DNS2=x.x.x.x',
        }

        file_line { 'DNS1' :
                ensure  => 'absent',
                path    => "/etc/sysconfig/network-scripts/ifcfg-${facts['networking']['primary']}",
                line    => 'DNS1=x.x.x.x',
        }


        file_line { 'DNS3' :
                ensure  => 'absent',
                path    => "/etc/sysconfig/network-scripts/ifcfg-${facts['networking']['primary']}",
                line    => 'DNS3=x.x.x.x',
        }



        file_line { 'New DNS1' :
                ensure  => 'present',
                path    => "/etc/sysconfig/network-scripts/ifcfg-${facts['networking']['primary']}",
                line    => 'DNS1=x.x.x.x',
        }

        file_line { 'New DNS2' :
                ensure  => 'present',
                path    => "/etc/sysconfig/network-scripts/ifcfg-${facts['networking']['primary']}",
                line    => 'DNS2=x.x.x.x',
        }

        file_line { 'New DNS3' :
                ensure  => 'present',
                path    => "/etc/sysconfig/network-scripts/ifcfg-${facts['networking']['primary']}",
                line    => 'DNS3=x.x.x.x',
        }


}

