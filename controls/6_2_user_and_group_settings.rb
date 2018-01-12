# encoding: utf-8
# copyright: 2017, The Authors

title '6.2 User and Group Settings'

control 'cis-ubuntu-14.04-6.2.1' do
  impact  1.0
  title   '6.2.1 Ensure password fields are not empty (Scored)'
  desc    'An account with an empty password field means that anybody may log in as that user without providing a password. All accounts must have passwords or be locked to prevent the account from being used by an unauthorized user.'

  tag cis: 'ubuntu-14.04:6.2.1'

  cmd = %q{cat /etc/shadow | awk -F: '($2 == "" ) { print $1 " does not have a password "}'}
  describe command(cmd) do
    its('stdout') { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.2' do
  impact  1.0
  title   '6.2.2 Ensure no legacy "+" entries exist in /etc/passwd (Scored)'
  desc    'The character + in various files used to be markers for systems to insert data from NIS maps at a certain point in a system configuration file. These entries are no longer required on most systems, but may exist in files that have been imported from other platforms.'

  tag cis: 'ubuntu-14.04:6.2.2'

  describe file('/etc/passwd') do
    its(:content) { should_not match '^\+:' }
  end
end

control 'cis-ubuntu-14.04-6.2.3' do
  impact  1.0
  title   '6.2.3 Ensure no legacy "+" entries exist in /etc/shadow (Scored)'
  desc    'The character + in various files used to be markers for systems to insert data from NIS maps at a certain point in a system configuration file. These entries are no longer required on most systems, but may exist in files that have been imported from other platforms.'

  tag cis: 'ubuntu-14.04:6.2.3'

  describe file('/etc/shadow') do
    its(:content) { should_not match '^\+:' }
  end
end

control 'cis-ubuntu-14.04-6.2.4' do
  impact  1.0
  title   '6.2.4 Ensure no legacy "+" entries exist in /etc/group (Scored)'
  desc    'The character + in various files used to be markers for systems to insert data from NIS maps at a certain point in a system configuration file. These entries are no longer required on most systems, but may exist in files that have been imported from other platforms.'

  tag cis: 'ubuntu-14.04:6.2.4'

  describe file('/etc/group') do
    its(:content) { should_not match '^\+:' }
  end
end

control 'cis-ubuntu-14.04-6.2.5' do
  impact  1.0
  title   '6.2.5 Ensure root is the only UID 0 account (Scored)'
  desc    'Any account with UID 0 has superuser privileges on the system. This access must be limited to only the default root account and only from the system console. Administrative access must be through an unprivileged account using an approved mechanism as noted in Item 5.6 Ensure access to the su command is restricted.'

  tag cis: 'ubuntu-14.04:6.2.5'

  describe command("cat /etc/passwd | awk -F: '($3 == 0) { print $1 }'") do
    its(:stdout) { should eq "root\n" }
  end
end

control 'cis-ubuntu-14.04-6.2.6' do
  impact  1.0
  title   '6.2.6 Ensure root PATH Integrity (Scored)'
  desc    'The root user can execute any command on the system and could be fooled into executing programs unintentionally if the PATH is not set correctly.'

  tag cis: 'ubuntu-14.04:6.2.6'

  cmd = inspec.profile.file('root_path_integrity_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.7' do
  impact  1.0
  title   "6.2.7 Ensure all users' home directories exist (Scored)"
  desc    'Users can be defined in /etc/passwd without a home directory or with a home directory that does not actually exist. If the user\'s home directory does not exist or is unassigned, the user will be placed in "/" and will not be able to write any files or have local environment variables set.'

  tag cis: 'ubuntu-14.04:6.2.7'

  cmd = inspec.profile.file('home_dirs_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.8' do
  impact  1.0
  title   "6.2.8 Ensure users' home directories permissions are 750 or more restrictive (Scored)"
  desc    "While the system administrator can establish secure permissions for users' home directories, the users can easily override these. Group or world-writable user home directories may enable malicious users to steal or modify other users' data or to gain another user's system privileges."

  tag cis: 'ubuntu-14.04:6.2.8'

  cmd = inspec.profile.file('home_dirs_perms_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.9' do
  impact  1.0
  title   '6.2.9 Ensure users own their home directories (Scored)'
  desc    'The user home directory is space defined for the particular user to set local environment variables and to store personal files. Since the user is accountable for files stored in the user home directory, the user must be the owner of the directory.'

  tag cis: 'ubuntu-14.04:6.2.9'

  cmd = inspec.profile.file('home_dirs_owner_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.10' do
  impact  1.0
  title   "6.2.10 Ensure users' dot files are not group or world writable (Scored)"
  desc    "While the system administrator can establish secure permissions for users' \"dot\" files, the users can easily override these. Group or world-writable user configuration files may enable malicious users to steal or modify other users' data or to gain another user's system privileges."

  tag cis: 'ubuntu-14.04:6.2.10'

  cmd = inspec.profile.file('user_dotfiles_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.11' do
  impact  1.0
  title   '6.2.11 Ensure no users have .forward files (Scored)'
  desc    "The .forward file specifies an email address to forward the user's mail to. Use of the .forward file poses a security risk in that sensitive data may be inadvertently transferred outside the organization. The .forward file also poses a risk as it can be used to execute commands that may perform unintended actions."

  tag cis: 'ubuntu-14.04:6.2.11'

  cmd = inspec.profile.file('user_dot_forward_file_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.12' do
  impact  1.0
  title   '6.2.12 Ensure no users have .netrc files (Scored)'
  desc    'The .netrc file contains data for logging into a remote host for file transfers via FTP. The .netrc file presents a significant security risk since it stores passwords in unencrypted form. Even if FTP is disabled, user accounts may have brought over .netrc files from other systems which could pose a risk to those systems.'

  tag cis: 'ubuntu-14.04:6.2.12'

  cmd = inspec.profile.file('user_dot_netrc_file_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.13' do
  impact  1.0
  title   "6.2.13 Ensure users' .netrc Files are not group or world accessible (Scored)"
  desc    "While the system administrator can establish secure permissions for users' .netrc files, the users can easily override these. .netrc files may contain unencrypted passwords that may be used to attack other systems. The .netrc file presents a significant security risk since it stores passwords in unencrypted form. Even if FTP is disabled, user accounts may have brought over .netrc files from other systems which could pose a risk to those systems."

  tag cis: 'ubuntu-14.04:6.2.13'

  cmd = inspec.profile.file('user_dot_netrc_file_perms_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.14' do
  impact  1.0
  title   '6.2.14 Ensure no users have .rhosts files (Scored)'
  desc    'While no .rhosts files are shipped by default, users can easily create them. This action is only meaningful if .rhosts support is permitted in the file /etc/pam.conf. Even though the .rhosts files are ineffective if support is disabled in /etc/pam.conf, they may have been brought over from other systems and could contain information useful to an attacker for those other systems.'

  tag cis: 'ubuntu-14.04:6.2.14'

  cmd = inspec.profile.file('user_dot_rhosts_file_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.2.15' do
  impact  1.0
  title   '6.2.15 Ensure all groups in /etc/passwd exist in /etc/group (Scored)'
  desc    'Over time, system administration errors and changes can lead to groups being defined in /etc/passwd but not in /etc/group. Groups defined in the /etc/passwd file but not in the /etc/group file pose a threat to system security since group permissions are not properly managed.'

  tag cis: 'ubuntu-14.04:6.2.15'

  cmd = inspec.profile.file('user_groups_audit.sh')
  describe bash(cmd) do
    its(:exit_status) { should cmp 0 }
    its(:stdout) { should eq '' }
  end
end
