# encoding: utf-8
# copyright: 2017, The Authors

title '5.3 Configure PAM'

control 'cis-ubuntu-14.04-5.3.1' do
  impact  1.0
  title   '5.3.1 Ensure password creation requirements are configured (Scored)'
  desc    'The pam_pwquality.so module checks the strength of passwords. It performs checks such as making sure a password is not a dictionary word, it is a certain length, contains a mix of characters (e.g. alphabet, numeric, other) and more.'

  tag cis: 'ubuntu-14.04:5.3.1'

  describe file('/etc/pam.d/common-password') do
    its(:content) { should match %r{password\s+requisite\s+pam_pwquality.so\s+try_first_pass\s+retry=3} }
  end

  describe ini('/etc/security/pwquality.conf') do
    its('minlen') { should match %r#1[4-9]|[2-9]\d+|\d{3,}# }
    its('dcredit') { should cmp '-1' }
    its('ucredit') { should cmp '-1' }
    its('ocredit') { should cmp '-1' }
    its('lcredit') { should cmp '-1' }
  end
end
