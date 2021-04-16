class rsyslog {

        file { '/etc/rsyslog.conf':
                ensure  => file,
                owner   => 'root',
                group   => 'root',
                mode    => '0640',
                source  => 'puppet:///modules/rsyslog/rsyslog.conf',
        }

        service { 'rsyslog':
                enable  => true,
                ensure  => running,
        }

        exec { 'Restart rsyslog':
                command => '/sbin/service rsyslog restart',
                subscribe => File['/etc/rsyslog.conf'],
        }

}

