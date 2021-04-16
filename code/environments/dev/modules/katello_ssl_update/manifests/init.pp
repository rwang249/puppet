#used to copy and run katello agent upgrade via puppet

class katello_ssl_update {

	file { '/root/scripts/katello_ssl_update.sh':
      		ensure => 'file',
		source => 'puppet:///modules/katello_ssl_update/katello_ssl_update.sh',
      		owner => 'root',
      		group => 'root',
      		mode  => '0700',
      		notify => Exec['update_katello_ssl'],
  	}

	exec { 'update_katello_ssl':
  		command => "/bin/bash -c '/root/scripts/katello_ssl_update.sh'",
	}

}
