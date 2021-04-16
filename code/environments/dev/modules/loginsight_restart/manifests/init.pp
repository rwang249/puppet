class loginsight_restart {

        file { '/root/agents':
                ensure => 'directory',
                owner => 'root',
                group => 'root',
                mode => '0644',
        }

        file { '/var/lib/loginsight-agent':
                ensure => 'directory',
                owner => 'root',
                group => 'root',
                mode => '0644',
        }


        file { '/root/agents/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm':
                ensure => 'file',
                source => 'puppet:///modules/loginsight_restart/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm',
                owner => 'root',
                group => 'root',
                mode  => '0644',
        }


        file { '/root/scripts/.loginsight_agent_update.sh':
                ensure => 'file',
                source => 'puppet:///modules/loginsight_restart/loginsight.sh',
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


    case $::virtual {
        'vmware' : {

          notify { 'apply on-prem vrli for on-premise':
            message => "${::virtual} is currently supported."
          }

          file { '/var/lib/loginsight-agent/liagent.ini':
                  ensure => 'file',
                  source => 'puppet:///modules/loginsight_restart/liagent.ini',
                  owner => 'root',
                  group => 'root',
                  mode  => '0644',
                  notify => Exec['loginsight_agent_update'],
          }

          exec { 'loginsight_agent_update':
                  command => "/bin/bash -c '/root/scripts/.loginsight_agent_update.sh'",
                  require => [
                    File['/root/agents/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm'],
                    File['/var/lib/loginsight-agent/liagent.ini'],
                  ],
                  notify  => Exec['restart loginsight'],
          }


          exec { 'restart loginsight' :
                  command => '/etc/init.d/liagentd restart',
          }


          if $facts['os']['release']['major'] == '6' {
          	exec { 'rhel6 world writable liagent':
                	command => '/bin/chmod 774 /var/run/liagent',
          	}

          }
          elsif $facts['os']['release']['major'] == '7' {
          	exec { 'rhel7 world writable liagent':
                  	command => '/usr/bin/chmod 774 /run/liagent',
       	  	}

          }

         }
         default : { 

          notify { 'apply saas vrli for cloud vms':
            message => "${::virtual} is currently supported."
          } 

          file { '/var/lib/loginsight-agent/liagent.ini':
                  ensure => 'file',
                  source => 'puppet:///modules/loginsight_restart/liagent.ini',
                  owner => 'root',
                  group => 'root',
                  mode  => '0644',
                  notify => Exec['loginsight_agent_update'],
          }

          exec { 'loginsight_agent_update':
                  command => "/bin/bash -c '/root/scripts/.loginsight_agent_update.sh'",
                  require => [
                    File['/root/agents/VMware-Log-Insight-Agent-4.7.0-9602262.noarch_10.132.140.21.rpm'],
                    File['/var/lib/loginsight-agent/liagent.ini'],
                  ],
                  notify  => Exec['restart loginsight'],
          }


          exec { 'restart loginsight' :
                  command => '/etc/init.d/liagentd restart',
          }

          exec { 'world writable liagent' :
                  command => '/usr/bin/chmod 774 /run/liagent',
          }


        }

    }

        
}




