# encoding: utf-8
# copyright: 2017, The Authors

title '5.4 User Accounts and Environment'

# 5.4.1 Set Shadow Password Suite Parameters

control 'cis-ubuntu-14.04-5.4.1.1' do
  impact  1.0
  title   '5.4.1.1 Ensure password expiration is 90 days or less (Scored)'
  desc    'The PASS_MAX_DAYS parameter in /etc/login.defs allows an administrator to force passwords to expire once they reach a defined age. It is recommended that the PASS_MAX_DAYS parameter be set to less than or equal to 90 days.'

  tag cis: 'ubuntu-14.04:5.4.1.1'

  describe login_defs do
    its('PASS_MAX_DAYS') { should match %r{([1-8]\d|90)$} }
  end

  cmd = %q(awk -F: '($2 != "!" && $2 != "*" && $5 > 90) {print $1}' /etc/shadow)
  describe command(cmd) do
    its(:stdout) { should eq ''}
  end
end

control 'cis-ubuntu-14.04-5.4.1.2' do
  impact  1.0
  title   '5.4.1.2 Ensure minimum days between password changes is 7 or more (Scored)'
  desc    'The PASS_MIN_DAYS parameter in /etc/login.defs allows an administrator to prevent users from changing their password until a minimum number of days have passed since the last time the user changed their password. It is recommended that PASS_MIN_DAYS parameter be set to 7 or more days. By restricting the frequency of password changes, an administrator can prevent users from repeatedly changing their password in an attempt to circumvent password reuse controls.'

  tag cis: 'ubuntu-14.04:5.4.1.2'

  describe login_defs do
    its('PASS_MIN_DAYS') { should match %r{([7-9]|[1-9]\d+)$} }
  end

  cmd = %q(awk -F: '($2 != "!" && $2 != "*" && $4 < 7) {print $1}' /etc/shadow)
  describe command(cmd) do
    its(:stdout) { should eq ''}
  end
end

control 'cis-ubuntu-14.04-5.4.1.3' do
  impact  1.0
  title   '5.4.1.3 Ensure password expiration warning days is 7 or more (Scored)'
  desc    'The PASS_WARN_AGE parameter in /etc/login.defs allows an administrator to notify users that their password will expire in a defined number of days. It is recommended that the PASS_WARN_AGE parameter be set to 7 or more days.'

  tag cis: 'ubuntu-14.04:5.4.1.3'

  describe login_defs do
    its('PASS_WARN_AGE') { should match %r{([7-9]|[1-9]\d+)$} }
  end
end

control 'cis-ubuntu-14.04-5.4.1.4' do
  impact  1.0
  title   '5.4.1.4 Ensure inactive password lock is 30 days or less (Scored)'
  desc    'User accounts that have been inactive for over a given period of time can be automatically disabled. It is recommended that accounts that are inactive for 30 days after password expiration be disabled.'

  tag cis: 'ubuntu-14.04:5.4.1.4'

  users = command("egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1").stdout.chomp.split()

  users.each do |user|
    describe shadow.users(user) do
      its('inactive_days') { should cmp %r{\d|[1-2]\d|30} }
    end
  end
end

control 'cis-ubuntu-14.04-5.4.2' do
  impact  1.0
  title   '5.4.2 Ensure system accounts are non-login (Scored)'
  desc    'There are a number of accounts provided with Ubuntu that are used to manage applications and are not intended to provide an interactive shell. It is important to make sure that accounts that are not being used by regular users are prevented from being used to provide an interactive shell. By default, Ubuntu sets the password field for these accounts to an invalid string, but it is also recommended that the shell field in the password file be set to /sbin/nologin. This prevents the account from potentially being used to run any commands.'

  tag cis: 'ubuntu-14.04:5.4.2'

  cmd = %q(
        egrep -v "^\+" /etc/passwd | awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="vagrant" && \
        $1!="halt" && $3<1000 && $7!="/usr/sbin/nologin" && $7!="/bin/false") {print $1}'
        )

  describe command(cmd) do
    its('stdout') { should eq '' }
  end
end

control 'cis-ubuntu-14.04-5.4.3' do
  impact  1.0
  title   '5.4.3 Ensure default group for the root account is GID 0 (Scored)'
  desc    'The usermod command can be used to specify which group the root user belongs to. This affects permissions of files that are created by the root user. Using GID 0 for the root account helps prevent root-owned files from accidentally becoming accessible to non-privileged users.'

  tag cis: 'ubuntu-14.04:5.4.3'

  describe passwd.users('root') do
    its('gids') { should cmp 0 }
  end
end

control 'cis-ubuntu-14.04-5.4.4' do
  impact  1.0
  title   '5.4.4 Ensure default user umask is 027 or more restrictive (Scored)'
  desc    'The default umask determines the permissions of files created by users. The user creating the file has the discretion of making their files and directories readable by others via the chmod command. Users who wish to allow their files and directories to be readable by others by default may choose a different default umask by inserting the umask command into the standard shell configuration files (.profile, .bashrc, etc.) in their home directories.'

  tag cis: 'ubuntu-14.04:5.4.4'

  options = {
    assignment_regex: /^\s*(\S*){1}\s*(.*?)\s*$/,
    multiple_values: false
  }

  %w{
    /etc/bash.bashrc
    /etc/profile
  }.each do |f|
    describe parse_config_file(f, options) do
      its('umask') { should cmp '027' }
    end
  end
end
