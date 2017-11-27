# encoding: utf-8
# copyright: 2017, The Authors

title '4.1 Configure System Accounting (auditd)'

control 'cis-ubuntu-14.04-4.1.1.1' do
  impact  1.0
  title   '4.1.1.1 Ensure audit log storage size is configured (Not Scored)'
  desc    'Configure the maximum size of the audit log file. Once the log reaches the maximum size, it will be rotated and a new log file will be started.'

  tag cis: 'ubuntu-14.04:4.1.1.1'

  describe auditd_conf do
    its('max_log_file') { should match '\d' }
  end
end

control 'cis-ubuntu-14.04-4.1.1.2' do
  impact  1.0
  title   '4.1.1.2 Ensure system is disabled when audit logs are full (Scored)'
  desc    'The auditd daemon can be configured to halt the system when the audit logs are full.'

  tag cis: 'ubuntu-14.04:4.1.1.2'

  describe auditd_conf do
    its('space_left_action') { should cmp 'email' }
    its('action_mail_acct')  { should cmp 'root' }
    its('admin_space_left_action') { should cmp 'halt' }
  end
end

control 'cis-ubuntu-14.04-4.1.1.3' do
  impact  1.0
  title   '4.1.1.3 Ensure audit logs are not automatically deleted (Scored)'
  desc    'The max_log_file_action setting determines how to handle the audit log file reaching the max file size. A value of keep_logs will rotate the logs but never delete old logs.'

  tag cis: 'ubuntu-14.04:4.1.1.3'

  describe auditd_conf do
    its('max_log_file_action') { should cmp 'keep_logs' }
  end
end

control 'cis-ubuntu-14.04-4.1.2' do
  impact  1.0
  title   '4.1.2 Ensure auditd service is enabled (Scored)'
  desc    'Turn on the auditd daemon to record system events.'

  tag cis: 'ubuntu-14.04:4.1.2'

  describe service('auditd') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'cis-ubuntu-14.04-4.1.3' do
  impact  1.0
  title   '4.1.3 Ensure auditing for processes that start prior to auditd is enabled (Scored)'
  desc    'Configure grub so that processes that are capable of being audited can be audited even if they start up prior to auditd startup.'

  tag cis: 'ubuntu-14.04:4.1.3'

  only_if do
    command('grep "^\s*linux" /boot/grub/grub.cfg | grep "audit=1"').exit_status != 0
  end

  describe file('/etc/default/grub') do
    its(:content) { should match %r{^GRUB_CMDLINE_LINUX=.*audit=1.*} }
  end
end

control 'cis-ubuntu-14.04-4.1.4' do
  impact  1.0
  title   '4.1.4 Ensure events that modify date and time information are collected (Scored)'
  desc    'Capture events where the system date and/or time has been modified. The parameters in this section are set to determine if the adjtimex (tune kernel clock), settimeofday (Set time, using timeval and timezone structures) stime (using seconds since 1/1/1970) or clock_settime (allows for the setting of several internal clocks and timers) system calls have been executed and always write an audit record to the /var/log/audit.log file upon exit, tagging the records with the identifier "time-change"'

  tag cis: 'ubuntu-14.04:4.1.4'

  # Why not use "auditd" resource?
  # Note: "auditd" resource does not work for any auditd installation that its  
  #       listed rules (output of "auditctl -l") start with "LIST_RULES:". 
  #       Unfortunately, there is a wrong assumption made in the resource code 
  #       that kind of assumes output of "auditctl -l" for audit >= 2.3 does
  #       not start with "LIST_RULES:". On a ubuntu 14.04 host with auditd 2.3.2
  #       listed rules do indeed start with "LIST_RULES:"
  # 
  #       Issue raised on Inspec github repo: https://github.com/chef/inspec/issues/2334
  #       Pull request for fix raised: https://github.com/chef/inspec/pull/2336
  # 
  #       Using "file" resource as workaround.
  #if os[:arch] == 'x86_64'
  #  describe auditd do
  #    its('lines') { should include %r{-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change} }
  #    its('lines') { should include %r{-a always,exit -F arch=b64 -S clock_settime -k time-change} }
  #  end
  #end
  #describe auditd do
  #  its('lines') { should include %r{-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change} }
  #  its('lines') { should include %r{-a always,exit -F arch=b32 -S clock_settime -k time-change} }
  #  its('lines') { should include %r{-w /etc/localtime -p wa -k time-change} }
  #end
  if os[:arch] == 'x86_64'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change} }
      its(:content) { should match %r{-a always,exit -F arch=b64 -S clock_settime -k time-change} }
    end
  end
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change} }
    its(:content) { should match %r{-a always,exit -F arch=b32 -S clock_settime -k time-change} }
    its(:content) { should match %r{-w /etc/localtime -p wa -k time-change} }
  end
end

control 'cis-ubuntu-14.04-4.1.5' do
  impact  1.0
  title   '4.1.5 Ensure events that modify user/group information are collected (Scored)'
  desc    'Record events affecting the group, passwd (user IDs), shadow and gshadow (passwords) or /etc/security/opasswd (old passwords, based on remember parameter in the PAM configuration) files. The parameters in this section will watch the files to see if they have been opened for write or have had attribute changes (e.g. permissions) and tag them with the identifier "identity" in the audit log file.'

  tag cis: 'ubuntu-14.04:4.1.5'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-w /etc/group -p wa -k identity} }
    its(:content) { should match %r{-w /etc/passwd -p wa -k identity} }
    its(:content) { should match %r{-w /etc/gshadow -p wa -k identity} }
    its(:content) { should match %r{-w /etc/shadow -p wa -k identity} }
    its(:content) { should match %r{-w /etc/security/opasswd -p wa -k identity} }
  end
end

control 'cis-ubuntu-14.04-4.1.6' do
  impact  1.0
  title   "4.1.6 Ensure events that modify the system's network environment are collected (Scored)"
  desc    'Record changes to network environment files or system calls. The below parameters monitor the sethostname (set the systems host name) or setdomainname (set the systems domainname) system calls, and write an audit event on system call exit. The other parameters monitor the /etc/issue and /etc/issue.net files (messages displayed pre- login), /etc/hosts (file containing host names and associated IP addresses) and /etc/sysconfig/network (directory containing network interface scripts and configurations) files.'

  tag cis: 'ubuntu-14.04:4.1.6'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  if os[:arch] == 'x86_64'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale} }
    end
  end
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale} }
    its(:content) { should match %r{-w /etc/issue -p wa -k system-locale} }
    its(:content) { should match %r{-w /etc/issue.net -p wa -k system-locale} }
    its(:content) { should match %r{-w /etc/hosts -p wa -k system-locale} }
    its(:content) { should match %r{-w /etc/network -p wa -k system-locale} }
    its(:content) { should match %r{-w /etc/networks -p wa -k system-locale} }
  end
end

control 'cis-ubuntu-14.04-4.1.7' do
  impact  1.0
  title   "4.1.7 Ensure events that modify the system's Mandatory Access Controls are collected (Scored)"
  desc    'Monitor SELinux/AppArmor mandatory access controls. The parameters below monitor any write access (potential additional, deletion or modification of files in the directory) or attribute changes to the /etc/selinux or /etc/apparmor and /etc/apparmor.d directories.'

  tag cis: 'ubuntu-14.04:4.1.7'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  if package('selinux').installed?
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-w /etc/selinux/ -p wa -k MAC-policy} }
    end
  end
  if package('apparmor').installed?
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-w /etc/apparmor/ -p wa -k MAC-policy} }
      its(:content) { should match %r{-w /etc/apparmor.d/ -p wa -k MAC-policy} }
    end
  end
end

control 'cis-ubuntu-14.04-4.1.8' do
  impact  1.0
  title   '4.1.8 Ensure login and logout events are collected (Scored)'
  desc    'Monitor login and logout events. The parameters below track changes to files associated with login/logout events. The file /var/log/faillog tracks failed events from login. The file /var/log/lastlog maintain records of the last time a user successfully logged in. The file /var/log/tallylog maintains records of failures via the pam_tally2 module'

  tag cis: 'ubuntu-14.04:4.1.8'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-w /var/log/faillog -p wa -k logins} }
    its(:content) { should match %r{-w /var/log/lastlog -p wa -k logins} }
    its(:content) { should match %r{-w /var/log/tallylog -p wa -k logins} }
  end
end

control 'cis-ubuntu-14.04-4.1.9' do
  impact  1.0
  title   '4.1.9 Ensure session initiation information is collected (Scored)'
  desc    'Monitor session initiation events. The parameters in this section track changes to the files associated with session events. The file /var/run/utmp file tracks all currently logged in users. The /var/log/wtmp file tracks logins, logouts, shutdown, and reboot events. All audit records will be tagged with the identifier "session." The file /var/log/btmp keeps track of failed login attempts and can be read by entering the command /usr/bin/last -f /var/log/btmp. All audit records will be tagged with the identifier "logins."'

  tag cis: 'ubuntu-14.04:4.1.9'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-w /var/run/utmp -p wa -k session} }
    its(:content) { should match %r{-w /var/log/wtmp -p wa -k session} }
    its(:content) { should match %r{-w /var/log/btmp -p wa -k session} }
  end
end

control 'cis-ubuntu-14.04-4.1.10' do
  impact  1.0
  title   '4.1.10 Ensure discretionary access control permission modification events are collected (Scored)'
  desc    'Monitor changes to file permissions, attributes, ownership and group. The parameters in this section track changes for system calls that affect file permissions and attributes. The chmod, fchmod and fchmodat system calls affect the permissions associated with a file. The chown, fchown, fchownat and lchown system calls affect owner and group attributes on a file. The setxattr, lsetxattr, fsetxattr (set extended file attributes) and removexattr, lremovexattr, fremovexattr (remove extended file attributes) control extended file attributes. In all cases, an audit record will only be written for non-system user ids (auid >= 1000) and will ignore Daemon events (auid = 4294967295). All audit records will be tagged with the identifier "perm_mod."'

  tag cis: 'ubuntu-14.04:4.1.10'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod} }
    its(:content) { should match %r{-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod} }
    its(:content) { should match %r{-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod} }
  end

  if os[:arch] == 'x86_64'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod} }
      its(:content) { should match %r{-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod} }
      its(:content) { should match %r{-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod} }
    end
  end
end

control 'cis-ubuntu-14.04-4.1.11' do
  impact  1.0
  title   '4.1.11 Ensure unsuccessful unauthorized file access attempts are collected (Scored)'
  desc    'Monitor for unsuccessful attempts to access files. The parameters below are associated with system calls that control creation (creat), opening (open, openat) and truncation (truncate, ftruncate) of files. An audit log record will only be written if the user is a non- privileged user (auid > = 1000), is not a Daemon event (auid=4294967295) and if the system call returned EACCES (permission denied to the file) or EPERM (some other permanent error associated with the specific system call). All audit records will be tagged with the identifier "access."'

  tag cis: 'ubuntu-14.04:4.1.11'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access} }
    its(:content) { should match %r{-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access} }
  end

  if os[:arch] == 'x86_64'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access} }
      its(:content) { should match %r{-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access} }
    end
  end
end

control 'cis-ubuntu-14.04-4.1.12' do
  impact  1.0
  title   '4.1.12 Ensure use of privileged commands is collected (Scored)'
  desc    'Monitor privileged programs (those that have the setuid and/or setgid bit set on execution) to determine if unprivileged users are running these commands.'

  tag cis: 'ubuntu-14.04:4.1.12'

  privileged_cmds = command("find $(echo $PATH | tr ':' ' ') -xdev \\( -perm -4000 -o -perm -2000 \\) -type f").stdout

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    privileged_cmds.split().each do |cmd|
      its(:content) { should match %r{-a always,exit -F path=#{cmd} -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged} }
    end
  end
end

control 'cis-ubuntu-14.04-4.1.13' do
  impact  1.0
  title   '4.1.13 Ensure successful file system mounts are collected (Scored)'
  desc    'Monitor the use of the mount system call. The mount (and umount) system call controls the mounting and unmounting of file systems. The parameters below configure the system to create an audit record when the mount system call is used by a non-privileged user'

  tag cis: 'ubuntu-14.04:4.1.13'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts} }
  end

  if os[:arch] == 'x86_64'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts} }
    end
  end
end

control 'cis-ubuntu-14.04-4.1.14' do
  impact  1.0
  title   '4.1.14 Ensure file deletion events by users are collected (Scored)'
  desc    'Monitor the use of system calls associated with the deletion or renaming of files and file attributes. This configuration statement sets up monitoring for the unlink (remove a file), unlinkat (remove a file attribute), rename (rename a file) and renameat (rename a file attribute) system calls and tags them with the identifier "delete".'

  tag cis: 'ubuntu-14.04:4.1.14'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete} }
  end

  if os[:arch] == 'x86_64'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete} }
    end
  end
end

control 'cis-ubuntu-14.04-4.1.15' do
  impact  1.0
  title   '4.1.15 Ensure changes to system administration scope (sudoers) is collected (Scored)'
  desc    'Monitor scope changes for system administrations. If the system has been properly configured to force system administrators to log in as themselves first and then use the sudo command to execute privileged commands, it is possible to monitor changes in scope. The file /etc/sudoers will be written to when the file or its attributes have changed. The audit records will be tagged with the identifier "scope."'

  tag cis: 'ubuntu-14.04:4.1.15'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-w /etc/sudoers -p wa -k scope} }
    its(:content) { should match %r{-w /etc/sudoers.d -p wa -k scope} }
  end
end

control 'cis-ubuntu-14.04-4.1.16' do
  impact  1.0
  title   '4.1.16 Ensure system administrator actions (sudolog) are collected (Scored)'
  desc    'Monitor the sudo log file. If the system has been properly configured to disable the use of the su command and force all administrators to have to log in first and then use sudo to execute privileged commands, then all administrator commands will be logged to /var/log/sudo.log. Any time a command is executed, an audit event will be triggered as the /var/log/sudo.log file will be opened for write and the executed administration command will be written to the log.'

  tag cis: 'ubuntu-14.04:4.1.16'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-w /var/log/sudo.log -p wa -k actions} }
  end
end

control 'cis-ubuntu-14.04-4.1.17' do
  impact  1.0
  title   '4.1.17 Ensure kernel module loading and unloading is collected (Scored)'
  desc    'Monitor the loading and unloading of kernel modules. The programs insmod (install a kernel module), rmmod (remove a kernel module), and modprobe (a more sophisticated program to load and unload modules, as well as some other features) control loading and unloading of modules. The init_module (load a module) and delete_module (delete a module) system calls control loading and unloading of modules. Any execution of the loading and unloading module programs and system calls will trigger an audit record with an identifier of "modules".'

  tag cis: 'ubuntu-14.04:4.1.17'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-w /sbin/insmod -p x -k modules} }
    its(:content) { should match %r{-w /sbin/rmmod -p x -k modules} }
    its(:content) { should match %r{-w /sbin/modprobe -p x -k modules} }
  end

  if os[:arch] == 'x86'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit arch=b32 -S init_module -S delete_module -k modules} }
    end
  elsif os[:arch] == 'x86_64'
    describe file('/etc/audit/audit.rules') do
      its(:content) { should match %r{-a always,exit arch=b64 -S init_module -S delete_module -k modules} }
    end
  end
end

control 'cis-ubuntu-14.04-4.1.18' do
  impact  1.0
  title   '4.1.18 Ensure the audit configuration is immutable (Scored)'
  desc    'Set system audit so that audit rules cannot be modified with auditctl. Setting the flag "-e 2" forces audit to be put in immutable mode. Audit changes can only be made on system reboot.'

  tag cis: 'ubuntu-14.04:4.1.18'

  # Why not use "auditd" resource? See note under cis-ubuntu-14.04-4.1.4
  describe file('/etc/audit/audit.rules') do
    its(:content) { should match %r{-e 2} }
  end
end
