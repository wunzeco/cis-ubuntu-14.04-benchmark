# encoding: utf-8
# copyright: 2017, The Authors

title '2.1 inetd Services'

control 'cis-ubuntu-14.04-2.1.1' do
  impact  1.0
  title   '2.1.1 Ensure chargen services are not enabled (Scored)'
  desc    'chargen is a network service that responds with 0 to 512 ASCII characters for each connection it receives. This service is intended for debugging and testing purposes. It is recommended that this service be disabled.'

  tag cis: 'ubuntu-14.04:2.1.1'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('chargen') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('chargen') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all chargen services have
  # disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.2' do
  impact  1.0
  title   '2.1.2 Ensure daytime services are not enabled (Scored)'
  desc    "daytime is a network service that responds with the server's current date and time. This service is intended for debugging and testing purposes. It is recommended that this service be disabled."

  tag cis: 'ubuntu-14.04:2.1.2'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('daytime') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('daytime') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all daytime services have
  # disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.3' do
  impact  1.0
  title   '2.1.3 Ensure discard services are not enabled (Scored)'
  desc    'discard is a network service that simply discards all data it receives. This service is intended for debugging and testing purposes. It is recommended that this service be disabled.'

  tag cis: 'ubuntu-14.04:2.1.3'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('discard') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('discard') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all discard services have
  # disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.4' do
  impact  1.0
  title   '2.1.4 Ensure echo services are not enabled (Scored)'
  desc    'echo is a network service that responds to clients with the data sent to it by the client. This service is intended for debugging and testing purposes. It is recommended that this service be disabled.'

  tag cis: 'ubuntu-14.04:2.1.4'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('echo') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('echo') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all echo services have
  # disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.5' do
  impact  1.0
  title   '2.1.5 Ensure time services are not enabled (Scored)'
  desc    "time is a network service that responds with the server's current date and time as a 32 bit integer. This service is intended for debugging and testing purposes. It is recommended that this service be disabled."

  tag cis: 'ubuntu-14.04:2.1.5'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('time') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('time') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all time services have
  # disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.6' do
  impact  1.0
  title   '2.1.6 Ensure rsh server is not enabled (Scored)'
  desc    'The Berkeley rsh-server (rsh, rlogin, rexec) package contains legacy services that exchange credentials in clear-text.'

  tag cis: 'ubuntu-14.04:2.1.6'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('shell') { should eq nil }
    its('login') { should eq nil }
    its('exec') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('shell') { should eq nil }
      its('login') { should eq nil }
      its('exec') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all rsh, rlogin, and
  # rexec services have disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.7' do
  impact  1.0
  title   '2.1.7 Ensure talk server is not enabled (Scored)'
  desc    'The talk software makes it possible for users to send and receive messages across systems through a terminal session. The talk client (allows initiate of talk sessions) is installed by default.'

  tag cis: 'ubuntu-14.04:2.1.7'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('talk') { should eq nil }
    its('ntalk') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('talk') { should eq nil }
      its('ntalk') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all talk services have disable =
  # yes set.
end

control 'cis-ubuntu-14.04-2.1.8' do
  impact  1.0
  title   '2.1.8 Ensure telnet server is not enabled (Scored)'
  desc    'The telnet-server package contains the telnet daemon, which accepts connections from users from other systems via the telnet protocol.'

  tag cis: 'ubuntu-14.04:2.1.8'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('telnet') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('telnet') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all telnet services
  # have disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.9' do
  impact  1.0
  title   '2.1.9 Ensure tftp server is not enabled (Scored)'
  desc    'Trivial File Transfer Protocol (TFTP) is a simple file transfer protocol, typically used to automatically transfer configuration or boot machines from a boot server. The packages tftp and atftp are both used to define and support a TFTP server.'

  tag cis: 'ubuntu-14.04:2.1.9'

  inetd_d_files = Dir.glob('/etc/inetd.d/*')
  describe inetd_conf do
    its('tftp') { should eq nil }
  end
  inetd_d_files.each do |f|
    describe inetd_conf(f) do
      its('tftp') { should eq nil }
    end
  end
  # ToDo:
  # check /etc/xinetd.conf and /etc/xinetd.d/* and verify all tftp services
  # have disable = yes set.
end

control 'cis-ubuntu-14.04-2.1.10' do
  impact  1.0
  title   '2.1.10 Ensure xinetd is not enabled (Scored)'
  desc    'The eXtended InterNET Daemon (xinetd) is an open source super daemon that replaced the original inetd daemon. The xinetd daemon listens for well known services and dispatches the appropriate daemon to properly respond to service requests.'

  tag cis: 'ubuntu-14.04:2.1.10'

  only_if do
    command('initctl show-config xinetd').exit_status == 0
  end

  describe file('/etc/init/xinetd.conf') do
    its('content') { should_not match '^start on runlevel' }
  end
end
