# encoding: utf-8
# copyright: 2017, The Authors

title '3.4 TCP Wrappers'

control 'cis-ubuntu-14.04-3.4.1' do
  impact  1.0
  title   '3.4.1 Ensure TCP Wrappers is installed (Scored)'
  desc    'TCP Wrappers provides a simple access list and standardized logging method for services capable of supporting it. In the past, services that were called from inetd and xinetd supported the use of tcp wrappers. As inetd and xinetd have been falling in disuse, any service that can support tcp wrappers will have the libwrap.so library attached to it.'

  tag cis: 'ubuntu-14.04:3.4.1'

  describe package('tcpd') do
    it { should be_installed }
  end
end

control 'cis-ubuntu-14.04-3.4.2' do
  impact  1.0
  title   '3.4.2 Ensure /etc/hosts.allow is configured (Scored)'
  desc    'The /etc/hosts.allow file specifies which IP addresses are permitted to connect to the host. It is intended to be used in conjunction with the /etc/hosts.deny file.'

  tag cis: 'ubuntu-14.04:3.4.2'

  describe file('/etc/hosts.allow') do
    its(:content) { should match '^\w+' }   # non-commented line
  end
end

control 'cis-ubuntu-14.04-3.4.3' do
  impact  1.0
  title   '3.4.3 Ensure /etc/hosts.deny is configured (Scored)'
  desc    'The /etc/hosts.deny file specifies which IP addresses are not permitted to connect to the host. It is intended to be used in conjunction with the /etc/hosts.allow file.'

  tag cis: 'ubuntu-14.04:3.4.3'

  describe file('/etc/hosts.deny') do
    its(:content) { should match '^\w+' }   # non-commented line
  end
end

control 'cis-ubuntu-14.04-3.4.4' do
  impact  1.0
  title   '3.4.4 Ensure permissions on /etc/hosts.allow are configured (Scored)'
  desc    'The /etc/hosts.allow file contains networking information that is used by many applications and therefore must be readable for these applications to operate.'

  tag cis: 'ubuntu-14.04:3.4.4'

  describe file('/etc/hosts.allow') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
end

control 'cis-ubuntu-14.04-3.4.5' do
  impact  1.0
  title   '3.4.5 Ensure permissions on /etc/hosts.deny are 644 (Scored)'
  desc    'The /etc/hosts.deny file contains network information that is used by many system applications and therefore must be readable for these applications to operate.'

  tag cis: 'ubuntu-14.04:3.4.4'

  describe file('/etc/hosts.deny') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
end

