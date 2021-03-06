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

control 'cis-ubuntu-14.04-5.3.2' do
  impact  0.0
  title   '5.3.2 Ensure lockout for failed password attempts is configured (Not Scored)'
  desc    'Locking out user IDs after n unsuccessful consecutive login attempts mitigates brute force password attacks against your systems.'

  tag cis: 'ubuntu-14.04:5.3.2'

  describe file('/etc/pam.d/common-auth') do
    its(:content) { should match %r{auth\s+required\s+pam_tally2.so\s+onerr=fail\s+audit\s+silent\s+deny=\d+\s+unlock_time=\d+} }
  end
end

control 'cis-ubuntu-14.04-5.3.3' do
  impact  1.0
  title   '5.3.3 Ensure password reuse is limited (Scored)'
  desc    "The /etc/security/opasswd file stores the users' old passwords and can be checked to ensure that users are not recycling recent passwords."

  tag cis: 'ubuntu-14.04:5.3.3'

  describe file('/etc/pam.d/common-password') do
    its(:content) { should match %r{^password\s+sufficient\s+pam_unix.so} }
  end
end

control 'cis-ubuntu-14.04-5.3.4' do
  impact  1.0
  title   '5.3.4 Ensure password hashing algorithm is SHA-512 (Scored)'
  desc    'The SHA-512 algorithm provides much stronger hashing than MD5, thus providing additional protection to the system by increasing the level of effort for an attacker to successfully determine passwords.'

  tag cis: 'ubuntu-14.04:5.3.4'

  describe file('/etc/pam.d/common-password') do
    its(:content) { should match %r{^password.*pam_unix.so.*sha512} }
  end
end
