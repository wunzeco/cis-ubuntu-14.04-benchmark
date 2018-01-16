# encoding: utf-8
# copyright: 2017, The Authors

title '5.2 SSH Server Configuration'

control 'cis-ubuntu-14.04-5.2.1' do
  impact  1.0
  title   '5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured (Scored)'
  desc    'The /etc/ssh/sshd_config file contains configuration specifications for sshd. The command below sets the owner and group of the file to root.'

  tag cis: 'ubuntu-14.04:5.2.1'

  describe file('/etc/ssh/sshd_config') do
    its('type') { should cmp 'file' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end
end

control 'cis-ubuntu-14.04-5.2.2' do
  impact  1.0
  title   '5.2.2 Ensure SSH Protocol is set to 2 (Scored)'
  desc    'SSH supports two different and incompatible protocols: SSH1 and SSH2. SSH1 was the original protocol and was subject to security issues. SSH2 is more advanced and secure.'

  tag cis: 'ubuntu-14.04:5.2.2'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^Protocol 2' }
  end
end

control 'cis-ubuntu-14.04-5.2.3' do
  impact  1.0
  title   '5.2.3 Ensure SSH LogLevel is set to INFO (Scored)'
  desc    'The INFO parameter specifies that login and logout activity will be logged.'

  tag cis: 'ubuntu-14.04:5.2.3'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^LogLevel INFO' }
  end
end

control 'cis-ubuntu-14.04-5.2.4' do
  impact  1.0
  title   '5.2.4 Ensure SSH X11 forwarding is disabled (Scored)'
  desc    'The X11Forwarding parameter provides the ability to tunnel X11 traffic through the connection to enable remote graphic connections.'

  tag cis: 'ubuntu-14.04:5.2.4'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^X11Forwarding no' }
  end
end

control 'cis-ubuntu-14.04-5.2.5' do
  impact  1.0
  title   '5.2.5 Ensure SSH MaxAuthTries is set to 4 or less (Scored)'
  desc    'The MaxAuthTries parameter specifies the maximum number of authentication attempts permitted per connection. When the login failure count reaches half the number, error messages will be written to the syslog file detailing the login failure.'

  tag cis: 'ubuntu-14.04:5.2.5'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match %r{^MaxAuthTries [1234]} }
  end
end

control 'cis-ubuntu-14.04-5.2.6' do
  impact  1.0
  title   '5.2.6 Ensure SSH IgnoreRhosts is enabled (Scored)'
  desc    'The IgnoreRhosts parameter specifies that .rhosts and .shosts files will not be used in RhostsRSAAuthentication orHostbasedAuthentication.'

  tag cis: 'ubuntu-14.04:5.2.6'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^IgnoreRhosts yes' }
  end
end

control 'cis-ubuntu-14.04-5.2.7' do
  impact  1.0
  title   '5.2.7 Ensure SSH HostbasedAuthentication is disabled (Scored)'
  desc    'The HostbasedAuthentication parameter specifies if authentication is allowed through trusted hosts via the user of .rhosts, or /etc/hosts.equiv, along with successful public key client host authentication. This option only applies to SSH Protocol Version 2.'

  tag cis: 'ubuntu-14.04:5.2.7'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^HostbasedAuthentication no' }
  end
end

control 'cis-ubuntu-14.04-5.2.8' do
  impact  1.0
  title   '5.2.8 Ensure SSH root login is disabled (Scored)'
  desc    'The PermitRootLogin parameter specifies if the root user can log in using ssh(1). The default is no.'

  tag cis: 'ubuntu-14.04:5.2.8'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^PermitRootLogin no' }
  end
end

control 'cis-ubuntu-14.04-5.2.9' do
  impact  1.0
  title   '5.2.9 Ensure SSH PermitEmptyPasswords is disabled (Scored)'
  desc    'The PermitEmptyPasswords parameter specifies if the SSH server allows login to accounts with empty password strings.'

  tag cis: 'ubuntu-14.04:5.2.9'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^PermitEmptyPasswords no' }
  end
end

control 'cis-ubuntu-14.04-5.2.10' do
  impact  1.0
  title   '5.2.10 Ensure SSH PermitUserEnvironment is disabled (Scored)'
  desc    'The PermitUserEnvironment option allows users to present environment options to the ssh daemon.'

  tag cis: 'ubuntu-14.04:5.2.10'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match '^PermitUserEnvironment no' }
  end
end

control 'cis-ubuntu-14.04-5.2.11' do
  impact  1.0
  title   '5.2.11 Ensure only approved MAC algorithms are used (Scored)'
  desc    'This variable limits the types of MAC algorithms that SSH can use during communication. MD5 and 96-bit MAC algorithms are considered weak and have been shown to increase exploitability in SSH downgrade attacks. Weak algorithms continue to have a great deal of attention as a weak spot that can be exploited with expanded computing power. An attacker that breaks the algorithm could take advantage of a MiTM position to decrypt the SSH tunnel and capture credentials and information'

  tag cis: 'ubuntu-14.04:5.2.11'

  #macs = ["hmac-sha2-512-etm@openssh.com", "hmac-sha2-256-etm@openssh.com",
  #        "umac-128-etm@openssh.com", "hmac-sha2-512", "hmac-sha2-256",
  #        "umac-128@openssh.com" ]

  describe file('/etc/ssh/sshd_config') do
    # Site policy might not require all MACs specified in the list above so
    # checking for weak MAC algorithms that should not be present instead
    #its('content') { should match %r{^MACs #{macs.join(',')}} }
    its('content') { should match %r{^MACs .*} }
    its('content') { should_not match %r{^MACs .*curve25519-sha256@libssh.org.*} }
    its('content') { should_not match %r{^MACs .*diffie-hellman-group-exchange-sha25.*} }
  end
end

control 'cis-ubuntu-14.04-5.2.12' do
  impact  1.0
  title   '5.2.12 Ensure SSH Idle Timeout Interval is configured (Scored)'
  desc    'The two options ClientAliveInterval and ClientAliveCountMax control the timeout of ssh sessions. When the ClientAliveInterval variable is set, ssh sessions that have no activity for the specified length of time are terminated. When the ClientAliveCountMax variable is set, sshd will send client alive messages at every ClientAliveInterval interval. When the number of consecutive client alive messages are sent with no response from the client, the ssh session is terminated. For example, if the ClientAliveInterval is set to 15 seconds and the ClientAliveCountMax is set to 3, the client ssh session will be terminated after 45 seconds of idle time.'

  tag cis: 'ubuntu-14.04:5.2.12'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match %r{^ClientAliveInterval\s+300} }
    its('content') { should match %r{^ClientAliveCountMax\s+0} }
  end
end

control 'cis-ubuntu-14.04-5.2.13' do
  impact  1.0
  title   '5.2.13 Ensure SSH LoginGraceTime is set to one minute or less (Scored)'
  desc    'The LoginGraceTime parameter specifies the time allowed for successful authentication to the SSH server. The longer the Grace period is the more open unauthenticated connections can exist. Like other session controls in this session the Grace Period should be limited to appropriate organizational limits to ensure the service is available for needed access.'

  tag cis: 'ubuntu-14.04:5.2.13'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match %r{^LoginGraceTime ([1-5]\d|60)} }
  end
end

control 'cis-ubuntu-14.04-5.2.14' do
  impact  1.0
  title   '5.2.14 Ensure SSH access is limited (Scored)'
  desc    'There are several options available to limit which users and group can access the system via SSH. It is recommended that at least one of the following options be leveraged: AllowUsers, AllowGroups, DenyUsers, DenyGroups. Restricting which users can remotely access the system via SSH will help ensure that only authorized users access the system.'

  tag cis: 'ubuntu-14.04:5.2.14'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match %r{^(AllowUsers|AllowGroups|DenyUsers|DenyGroups) .*} }
  end
end

control 'cis-ubuntu-14.04-5.2.15' do
  impact  1.0
  title   '5.2.15 Ensure SSH warning banner is configured (Scored)'
  desc    'The Banner parameter specifies a file whose contents must be sent to the remote user before authentication is permitted. By default, no banner is displayed.'

  tag cis: 'ubuntu-14.04:5.2.15'

  describe file('/etc/ssh/sshd_config') do
    its('content') { should match %r{^Banner .*} }
  end
end
