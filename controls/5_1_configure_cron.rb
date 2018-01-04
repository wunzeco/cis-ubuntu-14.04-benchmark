# encoding: utf-8
# copyright: 2017, The Authors

title '5.1 Configure cron'

control 'cis-ubuntu-14.04-5.1.1' do
  impact  1.0
  title   '5.1.1 Ensure cron daemon is enabled (Scored)'
  desc    'The cron daemon is used to execute batch jobs on the system. While there may not be user jobs that need to be run on the system, the system does have maintenance jobs that may include security monitoring that have to run, and cron is used to execute them.'

  tag cis: 'ubuntu-14.04:5.1.1'

  describe service('cron') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'cis-ubuntu-14.04-5.1.2' do
  impact  1.0
  title   '5.1.2 Ensure permissions on /etc/crontab are configured (Scored)'
  desc    'The /etc/crontab file is used by cron to control its own jobs. The commands in this item make sure that root is the user and group owner of the file and that only the owner can access the file.'

  tag cis: 'ubuntu-14.04:5.1.2'

  describe file('/etc/crontab') do
    its('type') { should cmp 'file' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end
end

control 'cis-ubuntu-14.04-5.1.3' do
  impact  1.0
  title   '5.1.3 Ensure permissions on /etc/cron.hourly are configured (Scored)'
  desc    'This directory contains system cron jobs that need to run on an hourly basis. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.'

  tag cis: 'ubuntu-14.04:5.1.3'

  describe file('/etc/cron.hourly') do
    its('type') { should cmp 'directory' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end
end

control 'cis-ubuntu-14.04-5.1.4' do
  impact  1.0
  title   '5.1.4 Ensure permissions on /etc/cron.daily are configured (Scored)'
  desc    'The /etc/cron.daily directory contains system cron jobs that need to run on a daily basis. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.'

  tag cis: 'ubuntu-14.04:5.1.4'

  describe file('/etc/cron.daily') do
    its('type') { should cmp 'directory' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end
end

control 'cis-ubuntu-14.04-5.1.5' do
  impact  1.0
  title   '5.1.5 Ensure permissions on /etc/cron.weekly are configured (Scored)'
  desc    'The /etc/cron.weekly directory contains system cron jobs that need to run on a weekly basis. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.'

  tag cis: 'ubuntu-14.04:5.1.5'

  describe file('/etc/cron.weekly') do
    its('type') { should cmp 'directory' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end
end

control 'cis-ubuntu-14.04-5.1.6' do
  impact  1.0
  title   '5.1.6 Ensure permissions on /etc/cron.monthly are configured (Scored)'
  desc    'The /etc/cron.monthly directory contains system cron jobs that need to run on a monthly basis. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.'

  tag cis: 'ubuntu-14.04:5.1.6'

  describe file('/etc/cron.monthly') do
    its('type') { should cmp 'directory' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end
end

control 'cis-ubuntu-14.04-5.1.7' do
  impact  1.0
  title   '5.1.7 Ensure permissions on /etc/cron.d are configured (Scored)'
  desc    'The /etc/cron.d directory contains system cron jobs that need to run in a similar manner to the hourly, daily weekly and monthly jobs from /etc/crontab, but require more granular control as to when they run. The files in this directory cannot be manipulated by the crontab command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.'

  tag cis: 'ubuntu-14.04:5.1.7'

  describe file('/etc/cron.d') do
    its('type') { should cmp 'directory' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end
end

control 'cis-ubuntu-14.04-5.1.8' do
  impact  1.0
  title   '5.1.8 Ensure at/cron is restricted to authorized users (Scored)'
  desc    'Configure /etc/cron.allow and /etc/at.allow to allow specific users to use these services. If /etc/cron.allow or /etc/at.allow do not exist, then /etc/at.deny and /etc/cron.deny are checked. Any user not specifically defined in those files is allowed to use at and cron. By removing the files, only users in /etc/cron.allow and /etc/at.allow are allowed to use at and cron. Note that even though a given user is not listed in cron.allow, cron jobs can still be run as that user. The cron.allow file only controls administrative access to the crontab command for scheduling and modifying cron jobs.'

  tag cis: 'ubuntu-14.04:5.1.8'

  ['cron.allow', 'at.allow'].each do |f|
    describe file("/etc/#{f}") do
      its('type') { should cmp 'file' }
      its('owner') { should eq 'root' }
      its('group') { should eq 'root' }
      its('mode') { should cmp '0600' }
    end
  end
end
