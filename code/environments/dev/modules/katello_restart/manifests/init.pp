class katello_restart {
	exec { 'restart katello agent' :
                command => '/sbin/service goferd restart',
	}
}
