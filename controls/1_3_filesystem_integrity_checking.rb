# encoding: utf-8
# copyright: 2017, The Authors

title '1.3 Filesystem Integrity Checking'

control 'cis-ubuntu-14.04-1.3.1' do
  impact  1.0
  title   '1.3.1 Ensure AIDE is installed (Scored)'
  desc    'AIDE takes a snapshot of filesystem state including modification times, permissions, and file hashes which can then be used to compare against the current state of the filesystem to detect modifications to the system.'

  tag cis: 'ubuntu-14.04:1.3.1'

  describe package('aide') do
    it { should be_installed }
  end
end

control 'cis-ubuntu-14.04-1.3.2' do
  impact  1.0
  title   '1.3.2 Ensure filesystem integrity is regularly checked (Scored)'
  desc    'Periodic checking of the filesystem integrity is needed to detect changes to the filesystem.'

  tag cis: 'ubuntu-14.04:1.3.2'

  describe crontab('root') do
    its('commands') { should include '/usr/bin/aide --check' }
  end
end
