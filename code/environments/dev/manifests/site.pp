node default {        
	include chrony
	include ctrl_alt_delete
        include goferd
        include katello_ssl_update
	include libselinux_python
	include loginsight_restart
        include ntp
        include patchinglog
        include postfix
        include resolv
	include rhinsights
	include rsyslog
	include scap_remediate
        include sshkey
}

