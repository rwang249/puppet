class postfix {
        if $facts['os']['name'] == 'RedHat' {
                if $facts['os']['release']['major'] == '8' {

                        notify { 'rhel8postfix':
                                message => 'OS is RHEL 8',
                        }
            package { 'postfix':
                    ensure  =>      'present',
            }

            service { 'postfix':
                    ensure  =>      'running',
                    enable  =>      true,
                    require =>      Package['postfix'],
            }

            file { '/etc/postfix/main.cf':
                    notify  =>      Service['postfix'],
                    mode    =>      '0644',
                    owner   =>      root,
                    group   =>      root,
                    require =>      Package['postfix'],
                    source  =>      'puppet:///modules/postfix/rhel8_main.cf',
            }
         }
         elsif $facts['os']['release']['major'] == '7' {
                        notify { 'rhel7postfix':
                                message => 'OS is RHEL 7',
                        }
            package { 'postfix':
                    ensure  =>      'present',
            }

            service { 'postfix':
                    ensure  =>      'running',
                    enable  =>      true,
                    require =>      Package['postfix'],
            }

            file { '/etc/postfix/main.cf':
                    notify  =>      Service['postfix'],
                    mode    =>      '0644',
                    owner   =>      root,
                    group   =>      root,
                    require =>      Package['postfix'],
                    source  =>      'puppet:///modules/postfix/main.cf',
            }
         }
         elsif $facts['os']['release']['major'] == '6' {
                        notify { 'rhel6postfix':
                                message => 'OS is RHEL 6',
                        }
            package { 'postfix':
                    ensure  =>      'present',
            }

            service { 'postfix':
                    ensure  =>      'running',
                    enable  =>      true,
                    require =>      Package['postfix'],
            }

            file { '/etc/postfix/main.cf':
                    notify  =>      Service['postfix'],
                    mode    =>      '0644',
                    owner   =>      root,
                    group   =>      root,
                    require =>      Package['postfix'],
                    source  =>      'puppet:///modules/postfix/main.cf',
            }
         }

        }        
}
