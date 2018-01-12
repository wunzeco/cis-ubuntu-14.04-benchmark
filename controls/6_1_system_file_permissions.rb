# encoding: utf-8
# copyright: 2017, The Authors

title '6.1 System File Permissions'

control 'cis-ubuntu-14.04-6.1.1' do
  impact  1.0
  title   '6.1.1 Audit system file permissions (Not Scored)'
  desc    'The Debian package manager has a number of useful options. One of these, the --verify option, can be used to verify that system packages are correctly installed. The --verify option can be used to verify a particular package or to verify all system packages. If no output is returned, the package is installed correctly.'

  tag cis: 'ubuntu-14.04:6.1.1'

  # Note: This control is added here for completeness sake!
  #       Remediation of this item is not automatable because it requires manual review
  #       of the output of "dpkg --verify" so as to review all installed packages.
  #
  #       So SKIP ALWAYS!

  only_if do
    false
  end
  describe command('dpkg --verify') do
    its(:exit_status) { should cmp 0 }
  end
end

control 'cis-ubuntu-14.04-6.1.2' do
  impact  1.0
  title   '6.1.2 Ensure permissions on /etc/passwd are configured (Scored)'
  desc    'The /etc/passwd file contains user account information that is used by many system utilities and therefore must be readable for these utilities to operate. It is critical to ensure that the /etc/passwd file is protected from unauthorized write access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.'

  tag cis: 'ubuntu-14.04:6.1.2'

  describe file('/etc/passwd') do
    its('mode') { should cmp '00644' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control 'cis-ubuntu-14.04-6.1.3' do
  impact  1.0
  title   '6.1.3 Ensure permissions on /etc/shadow are configured (Scored)'
  desc    'The /etc/shadow file is used to store the information about user accounts that is critical to the security of those accounts, such as the hashed password and other security information. If attackers can gain read access to the /etc/shadow file, they can easily run a password cracking program against the hashed password to break it. Other security information that is stored in the /etc/shadow file (such as expiration) could also be useful to subvert the user accounts.'

  tag cis: 'ubuntu-14.04:6.1.3'

  describe file('/etc/shadow') do
    its('mode') { should cmp '00640' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'shadow' }
  end
end

control 'cis-ubuntu-14.04-6.1.4' do
  impact  1.0
  title   '6.1.4 Ensure permissions on /etc/group are configured (Scored)'
  desc    'The /etc/group file contains a list of all the valid groups defined in the system. The command below allows read/write access for root and read access for everyone else. The /etc/group file needs to be protected from unauthorized changes by non-privileged users, but needs to be readable as this information is used with many non-privileged programs.'

  tag cis: 'ubuntu-14.04:6.1.4'

  describe file('/etc/group') do
    its('mode') { should cmp '00644' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control 'cis-ubuntu-14.04-6.1.5' do
  impact  1.0
  title   '6.1.5 Ensure permissions on /etc/shadow are configured (Scored)'
  desc    'The /etc/gshadow file is used to store the information about groups that is critical to the security of those accounts, such as the hashed password and other security information. If attackers can gain read access to the /etc/gshadow file, they can easily run a password cracking program against the hashed password to break it. Other security information that is stored in the /etc/gshadow file (such as group administrators) could also be useful to subvert the group.'

  tag cis: 'ubuntu-14.04:6.1.5'

  describe file('/etc/gshadow') do
    its('mode') { should cmp '00640' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'shadow' }
  end
end

control 'cis-ubuntu-14.04-6.1.6' do
  impact  1.0
  title   '6.1.6 Ensure permissions on /etc/passwd- are configured (Scored)'
  desc    'The /etc/passwd- file contains backup user account information. It is critical to ensure that the /etc/passwd- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.'

  tag cis: 'ubuntu-14.04:6.1.6'

  describe file('/etc/passwd-') do
    its('mode') { should cmp '00600' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control 'cis-ubuntu-14.04-6.1.7' do
  impact  1.0
  title   '6.1.7 Ensure permissions on /etc/shadow- are configured (Scored)'
  desc    'The /etc/shadow- file is used to store backup information about user accounts that is critical to the security of those accounts, such as the hashed password and other security information. It is critical to ensure that the /etc/shadow- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.'

  tag cis: 'ubuntu-14.04:6.1.7'

  describe file('/etc/shadow-') do
    its('mode') { should cmp '00600' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control 'cis-ubuntu-14.04-6.1.8' do
  impact  1.0
  title   '6.1.8 Ensure permissions on /etc/group- are configured (Scored)'
  desc    'The /etc/group- file contains a backup list of all the valid groups defined in the system. It is critical to ensure that the /etc/group- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.'

  tag cis: 'ubuntu-14.04:6.1.8'

  describe file('/etc/group-') do
    its('mode') { should cmp '00600' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control 'cis-ubuntu-14.04-6.1.9' do
  impact  1.0
  title   '6.1.9 Ensure permissions on /etc/gshadow- are configured (Scored)'
  desc    'The /etc/gshadow- file is used to store backup information about groups that is critical to the security of those accounts, such as the hashed password and other security information. It is critical to ensure that the /etc/gshadow- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions.'

  tag cis: 'ubuntu-14.04:6.1.9'

  describe file('/etc/gshadow-') do
    its('mode') { should cmp '00600' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end

control 'cis-ubuntu-14.04-6.1.10' do
  impact  1.0
  title   '6.1.10 Ensure no world writable files exist (Scored)'
  desc    "Unix-based systems support variable settings to control access to files. World writable files are the least secure. See the chmod(2) man page for more information. Data in world-writable files can be modified and compromised by any user on the system. World writable files may also indicate an incorrectly written script or program that could potentially be the cause of a larger compromise to the system's integrity."

  tag cis: 'ubuntu-14.04:6.1.10'

  cmd = "df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002"
  describe command(cmd) do
    its('stdout') { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.1.11' do
  impact  1.0
  title   '6.1.11 Ensure no unowned files or directories exist (Scored)'
  desc    'Sometimes when administrators delete users from the password file they neglect to remove all files owned by those users from the system. A new user who is assigned the deleted user\'s user ID or group ID may then end up "owning" these files, and thus have more access on the system than was intended.'

  tag cis: 'ubuntu-14.04:6.1.11'

  cmd = "df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser"
  describe command(cmd) do
    its('stdout') { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.1.12' do
  impact  1.0
  title   '6.1.12 Ensure no ungrouped files or directories exist (Scored)'
  desc    'Sometimes when administrators delete users or groups from the system they neglect to remove all files owned by those users or groups. A new user who is assigned the deleted user\'s user ID or group ID may then end up "owning" these files, and thus have more access on the system than was intended.'

  tag cis: 'ubuntu-14.04:6.1.12'

  cmd = "df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nogroup"
  describe command(cmd) do
    its('stdout') { should eq '' }
  end
end

control 'cis-ubuntu-14.04-6.1.13' do
  impact  0.0
  title   '6.1.13 Audit SUID executables (Not Scored)'
  desc    "The owner of a file can set the file's permissions to run with the owner's or group's permissions, even if the user running the program is not the owner or a member of the group. The most common reason for a SUID program is to enable users to perform functions (such as changing their password) that require root privileges."

  tag cis: 'ubuntu-14.04:6.1.13'

  # Note: This control is added here for completeness sake!
  #       Remediation of this item is not automatable because it requires manual audit
  #       of the output of the command below which will vary over time.
  #
  #       So SKIP ALWAYS!

  only_if do
    false
  end
  cmd = "df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -4000"
  describe command(cmd) do
    its('exit_status') { should cmp 0 }
  end
end

control 'cis-ubuntu-14.04-6.1.14' do
  impact  0.0
  title   '6.1.14 Audit SGID executables (Not Scored)'
  desc    "The owner of a file can set the file's permissions to run with the owner's or group's permissions, even if the user running the program is not the owner or a member of the group. The most common reason for a SGID program is to enable users to perform functions (such as changing their password) that require root privileges."

  tag cis: 'ubuntu-14.04:6.1.14'

  # Note: This control is added here for completeness sake!
  #       Remediation of this item is not automatable because it requires manual audit
  #       of the output of the command below which will vary over time.
  #
  #       So SKIP ALWAYS!

  only_if do
    false
  end
  cmd = "df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2000"
  describe command(cmd) do
    its('exit_status') { should cmp 0 }
  end
end
