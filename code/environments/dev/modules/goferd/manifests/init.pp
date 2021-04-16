class goferd {
        service { 'goferd':
                ensure => running,
                enable => true,
        }
}
