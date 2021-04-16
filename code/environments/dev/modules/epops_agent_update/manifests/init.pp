
#used to install vrealize operations agent for linux
class epops_agent_update {

	file { '/root/agents':
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '0644',
	}

        file { '/root/agents/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm':
                ensure => 'file',
                source => 'puppet:///modules/epops_agent_update/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm',
                owner => 'root',
                group => 'root',
                mode  => '0644',
        }

        file { '/root/agents/vRealize-Endpoint-Operations-Management-Agent-x86-64-linux-7.0.0-9957520.rpm':
                ensure => 'file',
                source => 'puppet:///modules/epops_agent_update/vRealize-Endpoint-Operations-Management-Agent-x86-64-linux-7.0.0-9957520.rpm',
                owner => 'root',
                group => 'root',
                mode  => '0644',
        }

        file { '/root/scripts/.epops_agent_update.sh':
                ensure => 'file',
                source => 'puppet:///modules/epops_agent_update/epops_agent_update.sh',
                owner => 'root',
                group => 'root',
                mode  => '0700',
        }

	file { '/root/scripts/vmware':
		ensure => 'directory',
		owner => 'root',
		group => 'root',
		mode => '0600',
	}

        file { '/root/scripts/vmware/epops_agent.properties':
                ensure => 'file',
                source => 'puppet:///modules/epops_agent_update/agent.properties',
                owner => 'root',
                group => 'root',
                mode => '0600',
        }

        file { '/var/lib/loginsight-agent/liagent.ini':
                ensure => 'file',
                source => 'puppet:///modules/epops_agent_update/liagent.ini',
                owner => 'root',
                group => 'root',
                mode  => '0644',
                notify => Exec['epops_agent_update'],
        }

        exec { 'epops_agent_update':
                command => "/bin/bash -c '/root/scripts/.epops_agent_update.sh'",
                require => [
                  File['/root/agents/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm'],
                  File['/root/agents/vRealize-Endpoint-Operations-Management-Agent-x86-64-linux-7.0.0-9957520.rpm'],
		  File['/var/lib/loginsight-agent/liagent.ini'],
		  File['/root/scripts/vmware/epops_agent.properties'],
                ],
		notify  => Exec['restart epops'],
        }

        service { 'epops-agent':
                ensure => running,
                enable => true,
        }

        exec { 'restart epops' :
                command => '/sbin/service epops-agent restart',
		require => [
		  File['/root/scripts/vmware/epops_agent.properties'],
		  Service['epops-agent'],
		  Exec['epops_agent_update'],
		],
		onlyif => '/usr/bin/test -e /root/scripts/vmware/.updatedepops',
		notify  => Exec['restart liagentd'],
        }

	exec { 'restart liagentd' :
                command => '/sbin/service liagentd restart',
                require => [
                  File['/root/scripts/vmware/epops_agent.properties'],
                  Service['epops-agent'],
                  Exec['epops_agent_update'],
                ],
                onlyif => '/usr/bin/test -e /root/scripts/vmware/.updatedepops',
        }

}
