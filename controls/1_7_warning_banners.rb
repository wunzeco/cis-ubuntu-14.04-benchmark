# encoding: utf-8
# copyright: 2017, The Authors

title '1.7 Warning Banners'

# 1.7.1 Command Line Warning Banners
control 'cis-ubuntu-14.04-1.7.1.1' do
  impact  1.0
  title   '1.7.1.1 Ensure message of the day is configured properly (Scored)'
  desc    'The contents of the /etc/motd file are displayed to users after login and function as a message of the day for authenticated users.'

  tag cis: 'ubuntu-14.04:1.7.1.1'

  describe file('/etc/motd') do
    it { should exist }
    its(:content) { should_not match /(\\v|\\r|\\m|\\s)/ }
  end
end

control 'cis-ubuntu-14.04-1.7.1.2' do
  impact  0.0
  title   '1.7.1.2 Ensure local login warning banner is configured properly (Not Scored)'
  desc    'The contents of the /etc/issue file are displayed to users prior to login for local terminals.'

  tag cis: 'ubuntu-14.04:1.7.1.2'

  describe file('/etc/issue') do
    its(:content) { should_not match /(\\v|\\r|\\m|\\s)/ }
  end
end

control 'cis-ubuntu-14.04-1.7.1.3' do
  impact  0.0
  title   '1.7.1.3 Ensure remote login warning banner is configured properly (Not Scored)'
  desc    'The contents of the /etc/issue.net file are displayed to users prior to login for remote connections from configured services.'

  tag cis: 'ubuntu-14.04:1.7.1.3'

  describe file('/etc/issue.net') do
    its(:content) { should_not match /(\\v|\\r|\\m|\\s)/ }
  end
end

control 'cis-ubuntu-14.04-1.7.1.4' do
  impact  0.0
  title   '1.7.1.4 Ensure permissions on /etc/motd are configured (Not Scored)'
  desc    'The contents of the /etc/motd file are displayed to users after login and function as a message of the day for authenticated users.'

  tag cis: 'ubuntu-14.04:1.7.1.4'

  describe file('/etc/motd') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
end

control 'cis-ubuntu-14.04-1.7.1.6' do
  impact  0.0
  title   '1.7.1.6 Ensure permissions on /etc/issue.net are configured (Not Scored)'
  desc    'The contents of the /etc/issue.net file are displayed to users prior to login for remote connections from configured services.'

  tag cis: 'ubuntu-14.04:1.7.1.6'

  describe file('/etc/issue.net') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
end

control 'cis-ubuntu-14.04-1.7.1.5' do
  impact  0.0
  title   '1.7.1.5 Ensure permissions on /etc/issue are configured (Scored)'
  desc    'The contents of the /etc/issue file are displayed to users prior to login for local terminals.'

  tag cis: 'ubuntu-14.04:1.7.1.5'

  describe file('/etc/issue') do
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
  end
end

# 1.7.2 Ensure GDM login banner is configured (Scored)

control 'cis-ubuntu-14.04-1.7.2' do
  impact  0.0
  title   '1.7.2 Ensure GDM login banner is configured (Scored)'
  desc    'GDM is the GNOME Display Manager which handles graphical login for GNOME based systems.'

  tag cis: 'ubuntu-14.04:1.7.2'

  only_if do
    file('/etc/dconf/profile/gdm').exist?
  end

  describe file('/etc/dconf/profile/gdm') do
    its(:content) { should match 'user-db:user\nsystem-db:gdm\nfile-db:/usr/share/gdm/greeter-dconf-defaults' }
  end
  describe file('/etc/dconf/db/gdm.d/01-banner-message') do
    its(:content) { should match 'banner-message-enable=true' }
    its(:content) { should match /banner-message-text=.*/ }
  end
end

