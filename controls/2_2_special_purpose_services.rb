# encoding: utf-8
# copyright: 2017, The Authors

title '2.2 Special Purpose Services'

# 2.2.1 Time Synchronization

control 'cis-ubuntu-14.04-2.2.1.1' do
  impact  1.0
  title   '2.2.1.1 Ensure time synchronization is in use (Not Scored)'
  desc    'System time should be synchronized between all systems in an environment. This is typically done by establishing an authoritative time server or set of servers and having all systems synchronize their clocks to them.'

  tag cis: 'ubuntu-14.04:2.2.1.1'

  if package('chrony').installed? 
    describe package('chrony') do
      it { should be_installed }
    end
  else
    describe package('ntp') do
      it { should be_installed }
    end
  end
end
