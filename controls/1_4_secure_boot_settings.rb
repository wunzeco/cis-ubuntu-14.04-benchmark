# encoding: utf-8
# copyright: 2017, The Authors

title '1.4 Secure Boot Settings'

control 'cis-ubuntu-14.04-1.4.1' do
  impact  1.0
  title   '1.4.1 Ensure permissions on bootloader config are configured (Scored)'
  desc    'The grub configuration file contains information on boot settings and passwords for unlocking boot options. The grub configuration is usually grub.cfg stored in /boot/grub.'

  tag cis: 'ubuntu-14.04:1.4.1'

  describe file('/boot/grub/grub.cfg') do
    its('mode') { should cmp '00600' }
  end
end

control 'cis-ubuntu-14.04-1.4.2' do
  impact  1.0
  title   '1.4.2 Ensure bootloader password is set (Scored)'
  desc    'Setting the boot loader password will require that anyone rebooting the system must enter a password before being able to set command line boot parameters'

  tag cis: 'ubuntu-14.04:1.4.2'

  describe file('/boot/grub/grub.cfg') do
    its('content') { should match /^set\ssuperusers/ }
    its('content') { should match /^password/ }
  end
end

control 'cis-ubuntu-14.04-1.4.3' do
  impact  1.0
  title   '1.4.3 Ensure authentication required for single user mode (Scored)'
  desc    'Single user mode is used for recovery when the system detects an issue during boot or by manual selection from the bootloader.'

  tag cis: 'ubuntu-14.04:1.4.3'

  describe file('/etc/shadow') do
    its('content') { should_not match /^root:[*\!]:/ }
  end
end
