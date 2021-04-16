#used to restart epops-agent service every puppet run due to a bug with the agent

class epops_restart {

        service { 'epops-agent':
                ensure => running,
                enable => true,
        }

	exec { 'restart epops' :
                command => '/sbin/service epops-agent restart',
	}

        exec { 'restart liagentd' :
                command => '/sbin/service liagentd restart',
	}

}
