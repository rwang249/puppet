#ensure satellite public key is added to servers for remote execution
class sshkey {
        exec { 'curl':
		command => '/usr/bin/curl --insecure https://satellite.blah.com:9090/ssh/pubkey >> /root/.ssh/authorized_keys',
		path => '/usr/bin/curl:/bin/',
		unless => 'grep foreman-proxy@satellite.blah.com /root/.ssh/authorized_keys'
	}
}
