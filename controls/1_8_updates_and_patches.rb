# encoding: utf-8
# copyright: 2017, The Authors

title '1.8 Ensure updates, patches, and additional security software are installed (Not Scored)'

control 'cis-ubuntu-14.04-1.8' do
  impact  0.0
  title   '1.8 Ensure updates, patches, and additional security software are installed (Not Scored)'
  desc    'Periodically patches are released for included software either due to security flaws or to include additional functionality.'

  tag cis: 'ubuntu-14.04:1.8'

  describe command('apt-get --simulate upgrade') do
    its(:stdout) { should match /^0 upgraded,/ }
  end
end
