# encoding: utf-8
# copyright: 2017, The Authors

title '2.3 Service Clients'

control 'cis-ubuntu-14.04-2.3.1' do
  impact  1.0
  title   '2.3.1 Ensure NIS Client is not installed (Scored)'
  desc    'The Network Information Service (NIS), formerly known as Yellow Pages, is a client-server directory service protocol used to distribute system configuration files. The NIS client (ypbind) was used to bind a machine to an NIS server and receive the distributed configuration files.'

  tag cis: 'ubuntu-14.04:2.3.1'

  describe package('nis') do
    it { should_not be_installed }
  end
end

control 'cis-ubuntu-14.04-2.3.2' do
  impact  1.0
  title   '2.3.2 Ensure rsh client is not installed (Scored)'
  desc    'These legacy clients contain numerous security exposures and have been replaced with the more secure SSH package. Even if the server is removed, it is best to ensure the clients are also removed to prevent users from inadvertently attempting to use these commands and therefore exposing their credentials. Note that removing the rsh package removes the clients for rsh, rcp and rlogin.'

  tag cis: 'ubuntu-14.04:2.3.2'

  ['rsh-client', 'rsh-redone-client'].each do |pkg|
    describe package(pkg) do
      it { should_not be_installed }
    end
  end
end

control 'cis-ubuntu-14.04-2.3.3' do
  impact  1.0
  title   '2.3.3 Ensure talk client is not installed (Scored)'
  desc    'The talk software makes it possible for users to send and receive messages across systems through a terminal session. The talk client, which allows initialization of talk sessions, is installed by default.'

  tag cis: 'ubuntu-14.04:2.3.3'

  describe package('talk') do
    it { should_not be_installed }
  end
end

control 'cis-ubuntu-14.04-2.3.4' do
  impact  1.0
  title   '2.3.4 Ensure telnet client is not installed (Scored)'
  desc    'The telnet package contains the telnet client, which allows users to start connections to other systems via the telnet protocol.'

  tag cis: 'ubuntu-14.04:2.3.4'

  describe package('telnet') do
    it { should_not be_installed }
  end
end

control 'cis-ubuntu-14.04-2.3.5' do
  impact  1.0
  title   '2.3.5 Ensure LDAP client is not installed (Scored)'
  desc    'The Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for NIS/YP. It is a service that provides a method for looking up information from a central database.'

  tag cis: 'ubuntu-14.04:2.3.5'

  describe package('ldap-utils') do
    it { should_not be_installed }
  end
end
