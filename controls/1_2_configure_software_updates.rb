# encoding: utf-8
# copyright: 2017, The Authors

title '1.2 Configure Software Updates'

control 'cis-ubuntu-14.04-1.2.1' do
  impact  0.0
  title   '1.2.1 Ensure package manager repositories are configured (Not Scored)'
  desc    'Systems need to have package manager repositories configured to ensure they receive the latest patches and updates.'

  tag cis: 'ubuntu-14.04:1.2.1'

  describe command('apt-cache policy') do
    its('stdout') { should match /trusty\/(main|universe|multiverse|restricted)/ }
  end
end

control 'cis-ubuntu-14.04-1.2.2' do
  impact  0.0
  title   '1.2.2 Ensure GPG keys are configured (Not Scored)'
  desc    'Most packages managers implement GPG key signing to verify package integrity during installation.'

  tag cis: 'ubuntu-14.04:1.2.2'

  describe command('apt-key list') do
    its('stdout') { should match '437D05B5' } # Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>
    its('stdout') { should match 'FBB75451' } # Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>
    its('stdout') { should match 'C0B21F32' } # Ubuntu Archive Automatic Signing Key (2012) <ftpmaster@ubuntu.com>
    its('stdout') { should match 'EFE21092' } # Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>
  end
end

