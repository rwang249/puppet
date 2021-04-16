#hardening linux servers based off of openscap scanning
class scap_remediate {

        if $facts['os']['name'] == 'RedHat' {
                if $facts['os']['release']['major'] == '6' {

                        notify { 'rhel6':
                                message => 'OS is RHEL 6',
                        }

                        file { '/root/scripts':
                                ensure => directory,
                        }

                        file { '/root/scripts/rpmperms.sh':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/rpmperms.sh',
                                mode => '0700',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/login.defs':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/login.defs',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/bashrc':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/bashrc',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/pam.d/system-auth':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/system-auth',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/pam.d/password-auth':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/password-auth',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/ssh/sshd_config':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/sshd_config',
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                                notify => Service["sshd"],
                        }

                        file { '/etc/profile':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/profile',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/profile.d/tmout.sh':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/tmout.sh',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/sysconfig/init':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/init',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/security/limits.d/90-nproc.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/90-nproc.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/csh.cshrc':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/csh.cshrc',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/audit/audit.rules':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/audit.rules',
                                mode => '0640',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/var/log/boot.log':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/modprobe.d/CIS.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel6/CIS.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        exec { 'set bootloader password':
                                command => "/bin/sed -i '/timeout=5/a password --encrypted xxxxxxx' /boot/grub/grub.conf",
                                unless => "/usr/bin/test -f /root/.bootloader_set",
                                before => File["/root/.bootloader_set"],
                        }

                        #Create file to only run the exec commands once
                        file { "/root/.bootloader_set":
                                ensure => present,
                                content => "File used to set a handler for scap_remediate module",
                        }

                        exec { 'turn off rhnsd':
                                command => "/sbin/chkconfig rhnsd off",
                        }

#                        exec { 'correct rpm file permissions':
#                                command => "/root/scripts/rpmperms.sh",
#                        }

                        service { 'sshd':
                                ensure => 'running',
                                enable => 'true',
                        }

                       file_line { 'disable ipv6 all redirects':
                               ensure => 'present',
                               path   => '/etc/sysctl.conf',
                               line   => 'net.ipv6.conf.all.accept_redirects = 0'
                       }

                        file_line { 'disable ipv6 default redirects':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'net.ipv6.conf.default.accept_redirects = 0'
                        }

                        file_line { 'disable all ipv6 router advertisements':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'net.ipv6.conf.all.accept_ra = 0'
                        }

                        file_line { 'disable default ipv6 router advertisements':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'net.ipv6.conf.default.accept_ra = 0'
                        }

                        file { '/etc/passwd':
                                ensure => file,
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/group':
                                ensure => file,
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }
                }
                elsif $facts['os']['release']['major'] == '7' {
                        notify { 'rhel7':
                                message => 'OS is RHEL 7',
                        }

                        file { '/root/scripts':
                                ensure => directory,
                        }

                        file { '/root/scripts/rpmperms.sh':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_rpmperms.sh',
                                mode => '0700',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/login.defs':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_login.defs',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/bashrc':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_bashrc',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/pam.d/system-auth':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_system-auth',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/securetty':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_securetty',
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/pam.d/password-auth':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_password-auth',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/ssh/sshd_config':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_sshd_config',
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                                notify => Service["sshd"],
                        }

                        file { '/etc/profile':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_profile',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/profile.d/tmout.sh':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_tmout.sh',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/sysconfig/init':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_init',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/csh.cshrc':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_csh.cshrc',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/security/pwquality.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_pwquality.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/boot/grub2/grub.cfg':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/var/log/boot.log':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/boot/grub2/user.cfg':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_user.cfg',
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/modprobe.d/CIS.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel7/rhel7_CIS.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        exec { 'turn off rhnsd':
                                command => "/sbin/chkconfig rhnsd off",
                        }

                        exec { 'correct rpm file permissions':
                                command => "/root/scripts/rpmperms.sh",
                        }

                        service { 'sshd':
                                ensure => 'running',
                                enable => 'true',
                        }

                        file_line { 'disable ipv6 all redirects':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'net.ipv6.conf.all.accept_redirects = 0'
                        }

                        file_line { 'disable ipv6 default redirects':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'net.ipv6.conf.default.accept_redirects = 0'
                        }

                        file_line { 'disable all ipv6 router advertisements':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'net.ipv6.conf.all.accept_ra = 0'
                        }

                        file_line { 'disable default ipv6 router advertisements':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'net.ipv6.conf.default.accept_ra = 0'
                        }

                        file_line { 'disable core dumps':
                                ensure => 'present',
                                path   => '/etc/sysctl.conf',
                                line   => 'fs.suid_dumpable = 0'
                        }

                        file { '/etc/passwd':
                                ensure => file,
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/group':
                                ensure => file,
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }
                }
                elsif $facts['os']['release']['major'] == '8' {

                        notify { 'rhel8':
                                message => 'OS is RHEL 8',
                        }
                        
                        file { '/root/scripts':
                                ensure => directory,
                        }

                        file { '/root/scripts/rpmperms.sh':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/rpmperms.sh',
                                mode => '0700',
                                owner => 'root',
                                group => 'root',
                        }

                        exec { 'correct rpm file permissions':
                                command => "/root/scripts/rpmperms.sh",
                        }

                        file { '/etc/login.defs':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/login.defs',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/bashrc':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/bashrc',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/pam.d/system-auth':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/system-auth',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }


                        file { '/etc/pam.d/password-auth':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/password-auth',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/securetty':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/securetty',
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/ssh/sshd_config':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/sshd_config',
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                                notify => Service["sshd"],
                        }

                        service { 'sshd':
                                ensure => 'running',
                                enable => 'true',
                                }

                        file { '/etc/profile':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/profile',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/profile.d/tmout.sh':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/tmout.sh',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/sysconfig/init':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/init',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/security/limits.d/20-nproc.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/20-nproc.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/csh.cshrc':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/csh.cshrc',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/security/pwquality.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/pwquality.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/sysctl.d/99-sysctl.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/99-sysctl.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/sysctl.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/99-sysctl.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }


                        file { '/etc/audit/rules.d/audit.rules':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/audit.rules',
                                mode => '0640',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/var/log/boot.log':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/modprobe.d/CIS.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/CIS.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        exec { 'turn off rhnsd':
                                command => "/sbin/chkconfig rhnsd off",
                        }

                        exec { '/var/log/ permission':
                                command => "/usr/bin/find /var/log -type f -exec chmod g-wx,o-rwx '{}' + -o -type d -exec chmod g-w,o-rwx '{}' +",
                        }

                        file { '/etc/passwd':
                                ensure => file,
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/group':
                                ensure => file,
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/boot/grub2/grub.cfg':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/boot/grub2/user.cfg':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/user.cfg',
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/crontab':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/cron.d':
                                ensure => directory,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/at.deny':
                                ensure => absent,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/cron.weekly':
                                ensure => directory,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/cron.hourly':
                                ensure => directory,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/cron.daily':
                                ensure => directory,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/cron.allow':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/cron.deny':
                                ensure => absent,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/at.allow':
                                ensure => file,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/cron.monthly':
                                ensure => directory,
                                mode => '0600',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/systemd/journald.conf':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/journald.conf',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/pam.d/su':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/su',
                                mode => '0644',
                                owner => 'root',
                                group => 'root',
                        }

                        file { '/etc/sudoers':
                                ensure => file,
                                source => 'puppet:///modules/scap_remediate/rhel8/sudoers',
                                mode => '0660',
                                owner => 'root',
                                group => 'root',
                        }

                        exec { 'world writable mqueue' :
                                command => '/usr/bin/chmod 774 /dev/mqueue',
                        } 

                        exec { 'world writable tmp' :
                                command => '/usr/bin/chmod 774 /tmp',
                        }

                        exec { 'world writable shm' :
                                command => '/usr/bin/chmod 774 /dev/shm',
                        }

                        exec { 'world writable vartmp' :
                                command => '/usr/bin/chmod 774 /var/tmp',
                        }

                        exec { 'world writable centrify' :
                                command => '/usr/bin/chmod 774 /var/centrifydc/user',
                        }

                        exec { 'world writable chrontmp' :
                                command => '/usr/bin/chmod 774 /tmp/systemd-private-*-chronyd.*/tmp',
                        }

                        exec { 'world writable posftixtmp' :
                                command => '/usr/bin/chmod 774 /tmp/systemd-private-*-postfix.service-*/tmp',
                        }

                        exec { 'world writable chronyd service tmp' :
                                command => '/usr/bin/chmod 774 /var/tmp/systemd-private-*-chronyd.service-*/tmp',
                        }

                        exec { 'world writable postfix service tmp' :
                                command => '/usr/bin/chmod 774 /var/tmp/systemd-private-*-postfix.service-*/tmp',
                        }

                }
        }
}

