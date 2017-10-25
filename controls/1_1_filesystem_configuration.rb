# encoding: utf-8
# copyright: 2017, The Authors

title '1.1 Filesystem Configuration'

control 'cis-ubuntu-14.04-1.1.1.1' do
  impact  1.0
  title   '1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Scored)'
  desc    'The cramfs filesystem type is a compressed read-only Linux filesystem embedded in small footprint systems. A cramfs image can be used without having to first decompress the image'

  tag cis: 'ubuntu-14.04:1.1.1.1'

  describe kernel_module('cramfs') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.1.2' do
  impact  1.0
  title   '1.1.1.2 Ensure mounting of freevxfs filesystems is disabled (Scored)'
  desc    'The freevxfs filesystem type is a free version of the Veritas type filesystem. This is the primary filesystem type for HP-UX operating systems.'

  tag cis: 'ubuntu-14.04:1.1.1.2'

  describe kernel_module('freevxfs') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.1.3' do
  impact  1.0
  title   '1.1.1.3 Ensure mounting of jffs2 filesystems is disabled (Scored)'
  desc    'The jffs2 (journaling flash filesystem 2) filesystem type is a log-structured filesystem used in flash memory devices.'

  tag cis: 'ubuntu-14.04:1.1.1.3'

  describe kernel_module('jffs2') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.1.4' do
  impact  1.0
  title   '1.1.1.4 Ensure mounting of hfs filesystems is disabled (Scored)'
  desc    'The hfs filesystem type is a hierarchical filesystem that allows you to mount Mac OS filesystems.'

  tag cis: 'ubuntu-14.04:1.1.1.4'

  describe kernel_module('hfs') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.1.5' do
  impact  1.0
  title   '1.1.1.5 Ensure mounting of hfsplus filesystems is disabled (Scored)'
  desc    'The hfsplus filesystem type is a hierarchical filesystem designed to replace hfs that allows you to mount Mac OS filesystems.'

  tag cis: 'ubuntu-14.04:1.1.1.5'

  describe kernel_module('hfsplus') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.1.6' do
  impact  1.0
  title   '1.1.1.6 Ensure mounting of squashfs filesystems is disabled (Scored)'
  desc    'The squashfs filesystem type is a compressed read-only Linux filesystem embedded in small footprint systems (similar to cramfs). A squashfs image can be used without having to first decompress the image.'

  tag cis: 'ubuntu-14.04:1.1.1.6'

  describe kernel_module('squashfs') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.1.7' do
  impact  1.0
  title   '1.1.1.7 Ensure mounting of udf filesystems is disabled (Scored)'
  desc    'The udf filesystem type is the universal disk format used to implement ISO/IEC 13346 and ECMA-167 specifications. This is an open vendor filesystem type for data storage on a broad range of media. This filesystem type is necessary to support writing DVDs and newer optical disc formats.'

  tag cis: 'ubuntu-14.04:1.1.1.7'

  describe kernel_module('udf') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.1.8' do
  impact  1.0
  title   '1.1.1.8 Ensure mounting of FAT filesystems is disabled (Scored)'
  desc    'The FAT filesystem format is primarily used on older windows systems and portable USB drives or flash modules. It comes in three types FAT12, FAT16, and FAT32 all of which are supported by the vfat kernel module.'

  tag cis: 'ubuntu-14.04:1.1.1.8'

  describe kernel_module('vfat') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-1.1.2' do
  impact  1.0
  title   '1.1.2 Ensure separate partition exists for /tmp (Scored)'
  desc    'The /tmp directory is a world-writable directory used for temporary storage by all users and some applications.'

  tag cis: 'ubuntu-14.04:1.1.2'

  describe mount('/tmp') do
    it { should be_mounted }
  end
end

control 'cis-ubuntu-14.04-1.1.3' do
  impact  1.0
  title   '1.1.3 Ensure nodev option set on /tmp partition (Scored)'
  desc    'The nodev mount option specifies that the filesystem cannot contain special devices.'

  tag cis: 'ubuntu-14.04:1.1.3'

  describe mount('/tmp') do
    its('options') { should include 'nodev' }
  end
end

control 'cis-ubuntu-14.04-1.1.4' do
  impact  1.0
  title   '1.1.4 Ensure nosuid option set on /tmp partition (Scored)'
  desc    'The nosuid mount option specifies that the filesystem cannot contain setuid files.'

  tag cis: 'ubuntu-14.04:1.1.4'

  describe mount('/tmp') do
    its('options') { should include 'nosuid' }
  end
end

control 'cis-ubuntu-14.04-1.1.5' do
  impact  1.0
  title   '1.1.5 Ensure separate partition exists for /var (Scored)'
  desc    'The /var directory is used by daemons and other system services to temporarily store dynamic data. Some directories created by these processes may be world-writable.'

  tag cis: 'ubuntu-14.04:1.1.5'

  describe mount('/var') do
    it { should be_mounted }
  end
end

control 'cis-ubuntu-14.04-1.1.6' do
  impact  1.0
  title   '1.1.6 Ensure separate partition exists for /var/tmp (Scored)'
  desc    'The /var/tmp directory is a world-writable directory used for temporary storage by all users and some applications.'

  tag cis: 'ubuntu-14.04:1.1.6'

  describe mount('/var/tmp') do
    it { should be_mounted }
  end
end

control 'cis-ubuntu-14.04-1.1.7' do
  impact  1.0
  title   '1.1.7 Ensure nodev option set on /var/tmp partition (Scored)'
  desc    'The nodev mount option specifies that the filesystem cannot contain special devices.'

  tag cis: 'ubuntu-14.04:1.1.7'

  describe mount('/var/tmp') do
    its('options') { should include 'nodev' }
  end
end

control 'cis-ubuntu-14.04-1.1.8' do
  impact  1.0
  title   '1.1.8 Ensure nosuid option set on /var/tmp partition (Scored)'
  desc    'The nosuid mount option specifies that the filesystem cannot contain setuid files.'

  tag cis: 'ubuntu-14.04:1.1.8'

  describe mount('/var/tmp') do
    its('options') { should include 'nosuid' }
  end
end

control 'cis-ubuntu-14.04-1.1.9' do
  impact  1.0
  title   '1.1.9 Ensure noexec option set on /var/tmp partition (Scored)'
  desc    'The noexec mount option specifies that the filesystem cannot contain executable binaries.'

  tag cis: 'ubuntu-14.04:1.1.9'

  describe mount('/var/tmp') do
    its('options') { should include 'noexec' }
  end
end

control 'cis-ubuntu-14.04-1.1.10' do
  impact  1.0
  title   '1.1.10 Ensure separate partition exists for /var/log (Scored)'
  desc    'There are two important reasons to ensure that system logs are stored on a separate partition: protection against resource exhaustion (since logs can grow quite large) and protection of audit data.'

  tag cis: 'ubuntu-14.04:1.1.10'

  describe mount('/var/log') do
    it { should be_mounted }
  end
end

control 'cis-ubuntu-14.04-1.1.11' do
  impact  1.0
  title   '1.1.11 Ensure separate partition exists for /var/log/audit (Scored)'
  desc    'The auditing daemon, auditd, stores log data in the /var/log/audit directory.'

  tag cis: 'ubuntu-14.04:1.1.11'

  describe mount('/var/log/audit') do
    it { should be_mounted }
  end
end

control 'cis-ubuntu-14.04-1.1.12' do
  impact  1.0
  title   '1.1.12 Ensure separate partition exists for /home (Scored)'
  desc    'The /home directory is used to support disk storage needs of local users.'

  tag cis: 'ubuntu-14.04:1.1.12'

  describe mount('/home') do
    it { should be_mounted }
  end
end

control 'cis-ubuntu-14.04-1.1.13' do
  impact  1.0
  title   '1.1.13 Ensure nodev option set on /home partition (Scored)'
  desc    'The nodev mount option specifies that the filesystem cannot contain special devices.'

  tag cis: 'ubuntu-14.04:1.1.13'

  describe mount('/home') do
    its('options') { should include 'nodev' }
  end
end

control 'cis-ubuntu-14.04-1.1.14' do
  impact  1.0
  title   '1.1.14 Ensure nodev option set on /run/shm partition (Scored)'
  desc    'The nodev mount option specifies that the filesystem cannot contain special devices.'

  tag cis: 'ubuntu-14.04:1.1.14'

  describe mount('/run/shm') do
    its('options') { should include 'nodev' }
  end
end

control 'cis-ubuntu-14.04-1.1.15' do
  impact  1.0
  title   '1.1.15 Ensure nosuid option set on /run/shm partition (Scored)'
  desc    'The nosuid mount option specifies that the filesystem cannot contain setuid files.'

  tag cis: 'ubuntu-14.04:1.1.15'

  describe mount('/run/shm') do
    its('options') { should include 'nosuid' }
  end
end

control 'cis-ubuntu-14.04-1.1.16' do
  impact  1.0
  title   '1.1.16 Ensure noexec option set on /run/shm partition (Scored)'
  desc    'The noexec mount option specifies that the filesystem cannot contain executable binaries.'

  tag cis: 'ubuntu-14.04:1.1.16'

  describe mount('/run/shm') do
    its('options') { should include 'noexec' }
  end
end

control 'cis-ubuntu-14.04-1.1.17' do
  impact  0.0
  title   '1.1.17 Ensure nodev option set on removable media partitions (Not Scored)'
  desc    'The nodev mount option specifies that the filesystem cannot contain special devices.'

  tag cis: 'ubuntu-14.04:1.1.17'

  only_if do
    command('mount | grep /media').exit_status == 0
  end

  describe command('mount | grep /media | grep nodev') do
    its('exit_status') { should_not eq 0 }
  end
end

control 'cis-ubuntu-14.04-1.1.18' do
  impact  0.0
  title   '1.1.18 Ensure nosuid option set on removable media partitions (Not Scored)'
  desc    'The nosuid mount option specifies that the filesystem cannot contain setuid files.'

  tag cis: 'ubuntu-14.04:1.1.18'

  only_if do
    command('mount | grep /media').exit_status == 0
  end

  describe command('mount | grep /media | grep nosuid') do
    its('exit_status') { should_not eq 0 }
  end
end

control 'cis-ubuntu-14.04-1.1.19' do
  impact  0.0
  title   '1.1.19 Ensure noexec option set on removable media partitions (Not Scored)'
  desc    'The noexec mount option specifies that the filesystem cannot contain executable binaries.'

  tag cis: 'ubuntu-14.04:1.1.19'

  only_if do
    command('mount | grep /media').exit_status == 0
  end

  describe command('mount | grep /media | grep noexec') do
    its('exit_status') { should_not eq 0 }
  end
end

control 'cis-ubuntu-14.04-1.1.20' do
  impact  0.0
  title   '1.1.20 Ensure sticky bit is set on all world-writable directories (Scored)'
  desc    'The noexec mount option specifies that the filesystem cannot contain executable binaries.'

  tag cis: 'ubuntu-14.04:1.1.20'

  cmd = "df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null"

  describe command(cmd) do
    its('exit_status') { should_not eq 0 }
    its('stdout') { should eq '' }
  end
end

control 'cis-ubuntu-14.04-1.1.21' do
  impact  0.0
  title   '1.1.21 Disable Automounting (Scored)'
  desc    'autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives.'

  tag cis: 'ubuntu-14.04:1.1.21'

  only_if do
    command('initctl show-config autofs').exit_status == 0
  end

  describe file('/etc/init/autofs.conf') do
    its('content') { should_not match /^start on runlevel/ }
  end
end
