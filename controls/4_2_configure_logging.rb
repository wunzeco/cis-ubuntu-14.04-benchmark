# encoding: utf-8
# copyright: 2017, The Authors

title '4.2 Configure Logging'

is_loghost = attribute('is_loghost', default: false, description: 'Is target a loghost?')

# 4.2.1 Configure rsyslog

control 'cis-ubuntu-14.04-4.2.1.1' do
  impact  1.0
  title   '4.2.1.1 Ensure rsyslog Service is enabled (Scored)'
  desc    'Once the rsyslog package is installed it needs to be activated.'

  tag cis: 'ubuntu-14.04:4.2.1.1'

  only_if do
    package('rsyslog').installed?
  end

  describe service('rsyslog') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'cis-ubuntu-14.04-4.2.1.2' do
  impact  0.0
  title   '4.2.1.2 Ensure logging is configured (Not Scored)'
  desc    'The /etc/rsyslog.conf file specifies rules for logging and which files are to be used to log certain classes of messages.'

  tag cis: 'ubuntu-14.04:4.2.1.2'

  only_if do
    package('rsyslog').installed?
  end

  # Advice is to review the contents of the /etc/rsyslog.conf file to ensure
  # appropriate logging is set. Depends on site policy.
  describe file('/etc/rsyslog.conf') do
    it { should be_file }
  end
end

control 'cis-ubuntu-14.04-4.2.1.3' do
  impact  1.0
  title   '4.2.1.3 Ensure rsyslog default file permissions configured (Scored)'
  desc    'rsyslog will create logfiles that do not already exist on the system. This setting controls what permissions will be applied to these newly created files.'

  tag cis: 'ubuntu-14.04:4.2.1.3'

  only_if do
    package('rsyslog').installed?
  end

  describe file('/etc/rsyslog.conf') do
    its(:content) { should match '^\\$FileCreateMode 0640' }
  end
end

control 'cis-ubuntu-14.04-4.2.1.4' do
  impact  1.0
  title   '4.2.1.4 Ensure rsyslog is configured to send logs to a remote log host (Scored)'
  desc    'The rsyslog utility supports the ability to send logs it gathers to a remote log host running syslogd(8) or to receive messages from remote hosts, reducing administrative overhead.'

  tag cis: 'ubuntu-14.04:4.2.1.4'

  only_if do
    package('rsyslog').installed?
  end

  # should match config like 
  # *.* @@loghost.example.com
  describe file('/etc/rsyslog.conf') do
    its(:content) { should match '^*.*[^I][^I]*@' }
  end
end

control 'cis-ubuntu-14.04-4.2.1.5' do
  impact  0.0
  title   '4.2.1.5 Ensure remote rsyslog messages are only accepted on designated log hosts. (Not Scored)'
  desc    'By default, rsyslog does not listen for log messages coming in from remote systems. The ModLoad tells rsyslog to load the imtcp.so module so it can listen over a network via TCP. The InputTCPServerRun option instructs rsyslogd to listen on the specified TCP port.'

  tag cis: 'ubuntu-14.04:4.2.1.5'

  only_if do
    package('rsyslog').installed? and is_loghost == true
  end

  # Only applies to targets intended to be log hosts
  describe file('/etc/rsyslog.conf') do
    its(:content) { should match '^\\$ModLoad imtcp.so' }
    its(:content) { should match '^\\$InputTCPServerRun' }
  end
end


# 4.2.2 Configure syslog-ng

control 'cis-ubuntu-14.04-4.2.2.1' do
  impact  1.0
  title   '4.2.2.1 Ensure syslog-ng service is enabled (Scored)'
  desc    'Once the syslog-ng package is installed it needs to be activated.'

  tag cis: 'ubuntu-14.04:4.2.2.1'

  only_if do
    package('syslog-ng').installed?
  end

  describe service('syslog-ng') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'cis-ubuntu-14.04-4.2.2.2' do
  impact  0.0
  title   '4.2.2.2 Ensure logging is configured (Not Scored)'
  desc    'The /etc/syslog-ng/syslog-ng.conf file specifies rules for logging and which files are to be used to log certain classes of messages.'

  tag cis: 'ubuntu-14.04:4.2.2.2'

  only_if do
    package('syslog-ng').installed?
  end

  # Advice is to review the contents of the /etc/syslog-ng/syslog-ng.conf file to ensure
  # appropriate logging is set. Depends on site policy.
  describe file('/etc/syslog-ng/syslog-ng.conf') do
    it { should be_file }
  end
end

control 'cis-ubuntu-14.04-4.2.2.3' do
  impact  1.0
  title   '4.2.2.3 Ensure syslog-ng default file permissions configured (Scored)'
  desc    'syslog-ng will create logfiles that do not already exist on the system. This setting controls what permissions will be applied to these newly created files.'

  tag cis: 'ubuntu-14.04:4.2.2.3'

  only_if do
    package('syslog-ng').installed?
  end

  describe file('/etc/syslog-ng/syslog-ng.conf') do
    its(:content) { should match %r{options.*perm\(0640\).*} }
  end
end

control 'cis-ubuntu-14.04-4.2.2.4' do
  impact  1.0
  title   '4.2.2.4 Ensure syslog-ng is configured to send logs to a remote log host (Scored)'
  desc    'The syslog-ng utility supports the ability to send logs it gathers to a remote log host or to receive messages from remote hosts, reducing administrative overhead.'

  tag cis: 'ubuntu-14.04:4.2.2.4'

  only_if do
    package('syslog-ng').installed?
  end

  describe file('/etc/syslog-ng/syslog-ng.conf') do
    its(:content) { should match %r|destination logserver.*tcp\(".*" port\(\d+\)\).*| }
    its(:content) { should match %r|log { source(src); destination(logserver); };| }
  end
end

control 'cis-ubuntu-14.04-4.2.2.5' do
  impact  0.0
  title   '4.2.2.5 Ensure remote syslog-ng messages are only accepted on designated log hosts (Not Scored)'
  desc    'By default, syslog-ng does not listen for log messages coming in from remote systems. The guidance in the section ensures that remote log hosts are configured to only accept syslog-ng data from hosts within the specified domain and that those systems that are not designed to be log hosts do not accept any remote syslog-ng messages. This provides protection from spoofed log data and ensures that system administrators are reviewing reasonably complete syslog data in a central location.'

  tag cis: 'ubuntu-14.04:4.2.2.5'

  only_if do
    package('syslog-ng').installed? and is_loghost == true
  end

  # Only applies to targets intended to be log hosts
  describe file('/etc/syslog-ng/syslog-ng.conf') do
   its(:content) { should match %r|source net{ tcp(); };| }
   its(:content) { should match %r|destination remote { file("/var/log/remote/${FULLHOST}-log"); };| }
   its(:content) { should match %r|log { source(net); destination(remote); };| }
  end
end

control 'cis-ubuntu-14.04-4.2.3' do
  impact  1.0
  title   '4.2.3 Ensure rsyslog or syslog-ng is installed (Scored)'
  desc    'The rsyslog and syslog-ng software are recommended replacements to the original syslogd daemon which provide improvements over syslogd, such as connection-oriented (i.e. TCP) transmission of logs, the option to log to database formats, and the encryption of log data en route to a central logging server.'

  tag cis: 'ubuntu-14.04:4.2.3'

  if not package('syslog-ng').installed?
    describe package('rsyslog') do
      it { should be_installed }
    end
  end
  if not package('rsyslog').installed?
    describe package('syslog-ng') do
      it { should be_installed }
    end
  end
end

control 'cis-ubuntu-14.04-4.2.4' do
  impact  1.0
  title   '4.2.4 Ensure permissions on all logfiles are configured (Scored)'
  desc    'Log files stored in /var/log/ contain logged information from many services on the system, or on log hosts others as well.'

  tag cis: 'ubuntu-14.04:4.2.4'

  cmd="find /var/log -type f \\( -perm -g=w -o -perm -g=x -o -perm -o=r -o -perm -o=w -o -perm -o=x \\) -ls"

  describe command(cmd) do
    its('stdout') { should eq '' }
  end
end
