class lastmodified {
        file { '/root/scripts/lastmodified.sh':
                ensure => file,
                source => 'puppet:///modules/lastmodified/lastmodified.sh',
                mode   => '0744',
                owner  => 'root',
                group  => 'root',
        }
}

