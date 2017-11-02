# encoding: utf-8
# copyright: 2017, The Authors

title '3.7 Ensure wireless interfaces are disabled (Not Scored)'

control 'cis-ubuntu-14.04-3.7' do
  impact  1.0
  title   '3.7 Ensure wireless interfaces are disabled (Not Scored)'
  desc    'Wireless networking is used when wired networks are unavailable. Ubuntu contains a wireless tool kit to allow system administrators to configure and use wireless networks.'

  tag cis: 'ubuntu-14.04:3.7'

  only_if do
    package('wireless-tools').installed?
  end

  # TODO: Placeholder for an appropriate test
  #    - what is the output of iwconfig like?
  #    - how do you identify a wireless interface?
  #    - test to check wireless interface is disabled
  describe command('iwconfig') do
    its(:exit_status) { should eq 0 }
  end
end

