# encoding: utf-8
# copyright: 2017, The Authors

title '4.3 Ensure logrotate is configured'

control 'cis-ubuntu-14.04-4.3' do
  impact  1.0
  title   '4.3 Ensure logrotate is configured (Not Scored)'
  desc    'The system includes the capability of rotating log files regularly to avoid filling up the system with logs or making the logs unmanageable large. The file /etc/logrotate.d/syslog is the configuration file used to rotate log files created by syslog or rsyslog.'

  tag cis: 'ubuntu-14.04:4.3'

  # Actual content depends on site policy.
  if package('rsyslog').installed?
    describe file('/etc/logrotate.d/rsyslog') do
      it { should be_file }
    end
  end
  if package('syslog-ng').installed?
    describe file('/etc/logrotate.d/syslog-ng') do
      it { should be_file }
    end
  end
end
