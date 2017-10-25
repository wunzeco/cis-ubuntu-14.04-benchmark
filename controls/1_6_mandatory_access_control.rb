# encoding: utf-8
# copyright: 2017, The Authors

title '1.6 Mandatory Access Control'

control 'cis-ubuntu-14.04-1.6.1.1' do
  impact  1.0
  title   '1.6.1.1 Ensure SELinux is not disabled in bootloader configuration (Scored)'
  desc    'Configure SELINUX to be enabled at boot time and verify that it has not been overwritten by the grub boot parameters.'

  tag cis: 'ubuntu-14.04:1.6.1.1'

  only_if do
    package('selinux').installed?
  end

  describe command("grep '^\s*linux' /boot/grub/grub.cfg | grep -E '(selinux|enforcing)=0'") do
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-1.6.1.2' do
  impact  1.0
  title   '1.6.1.2 Ensure the SELinux state is enforcing (Scored)'
  desc    'SELinux must be enabled at boot time in to ensure that the controls it provides are in effect at all times.'

  tag cis: 'ubuntu-14.04:1.6.1.2'

  only_if do
    package('selinux').installed?
  end

  describe file('/etc/selinux/config') do
    its(:content) { should match 'SELINUX=enforcing' }
  end
  describe command('sestatus') do
    its(:stdout) { should match 'SELinux status: enabled\nCurrent mode: enforcing\nMode from config file: enforcing' }
  end
end

control 'cis-ubuntu-14.04-1.6.1.3' do
  impact  1.0
  title   '1.6.1.3 Ensure SELinux policy is configured (Scored)'
  desc    'Configure SELinux to meet or exceed the default targeted policy, which constrains daemons and system software only.'

  tag cis: 'ubuntu-14.04:1.6.1.3'

  only_if do
    package('selinux').installed?
  end

  describe file('/etc/selinux/config') do
    its(:content) { should match /SELINUXTYPE=(ubuntu|default|mls)/ }
  end
end

control 'cis-ubuntu-14.04-1.6.1.4' do
  impact  1.0
  title   '1.6.1.4 Ensure no unconfined daemons exist (Scored)'
  desc    'Daemons that are not defined in SELinux policy will inherit the security context of their parent process.'

  tag cis: 'ubuntu-14.04:1.6.1.4'

  only_if do
    package('selinux').installed?
  end

  describe command("ps -eZ | egrep 'initrc' | egrep -vw 'tr|ps|egrep|bash|awk' | tr ':' ' ' | awk '{ print $NF }'") do
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-1.6.2.1' do
  impact  1.0
  title   '1.6.2.1 Ensure AppArmor is not disabled in bootloader configuration (Scored)'
  desc    'Configure AppArmor to be enabled at boot time and verify that it has not been overwritten by the bootloader boot parameters.'

  tag cis: 'ubuntu-14.04:1.6.2.1'

  only_if do
    package('apparmor').installed?
  end

  describe command("grep '^\s*linux' /boot/grub/grub.cfg | grep 'apparmor=0'") do
    its(:stdout) { should eq '' }
  end
end

control 'cis-ubuntu-14.04-1.6.2.2' do
  impact  1.0
  title   '1.6.2.2 Ensure all AppArmor Profiles are enforcing (Scored)'
  desc    'AppArmor profiles define what resources applications are able to access.'

  tag cis: 'ubuntu-14.04:1.6.2.2'

  only_if do
    package('apparmor').installed?
  end

  describe command('apparmor_status') do
    its(:stdout) { should match /\d+ profiles are loaded./ }
    its(:stdout) { should match '0 profiles are in complain mode.' }
    its(:stdout) { should match '0 processes are unconfined but have a profile defined.' }
  end
end

control 'cis-ubuntu-14.04-1.6.2.3' do
  impact  1.0
  title   '1.6.3 Ensure SELinux or AppArmor are installed (Not Scored)'
  desc    'SELinux and AppArmor provide Mandatory Access Controls.'

  tag cis: 'ubuntu-14.04:1.6.2.3'

  if package('selinux').installed? 
    describe package('selinux') do
      it { should be_installed }
    end
  else
    describe package('apparmor') do
      it { should be_installed }
    end
  end
end

