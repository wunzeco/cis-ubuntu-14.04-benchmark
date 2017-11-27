# encoding: utf-8
# copyright: 2017, The Authors

title '3.3 IPv6'

control 'cis-ubuntu-14.04-3.3.1' do
  impact  0.0
  title   '3.3.1 Ensure IPv6 router advertisements are not accepted (Not Scored)'
  desc    "This setting disables the system's ability to accept IPv6 router advertisements."

  tag cis: 'ubuntu-14.04:3.3.1'

  describe command('sysctl net.ipv6.conf.all.accept_ra') do
    its(:stdout) { should match 'net.ipv6.conf.all.accept_ra = 0' }
  end
  describe command('sysctl net.ipv6.conf.default.accept_ra') do
    its(:stdout) { should match 'net.ipv6.conf.default.accept_ra = 0' }
  end
end

control 'cis-ubuntu-14.04-3.3.2' do
  impact  0.0
  title   '3.3.2 Ensure IPv6 redirects are not accepted (Not Scored)'
  desc    'This setting prevents the system from accepting ICMP redirects. ICMP redirects tell the system about alternate routes for sending traffic.'

  tag cis: 'ubuntu-14.04:3.3.2'

  describe command('sysctl net.ipv6.conf.all.accept_redirects') do
    its(:stdout) { should match 'net.ipv6.conf.all.accept_redirects = 0' }
  end
  describe command('sysctl net.ipv6.conf.default.accept_redirects') do
    its(:stdout) { should match 'net.ipv6.conf.default.accept_redirects = 0' }
  end
end

control 'cis-ubuntu-14.04-3.3.3' do
  impact  0.0
  title   '3.3.3 Ensure IPv6 is disabled (Not Scored)'
  desc    'Although IPv6 has many advantages over IPv4, few organizations have implemented IPv6. If IPv6 is not to be used, it is recommended that it be disabled to reduce the attack surface of the system.'

  tag cis: 'ubuntu-14.04:3.3.3'

  only_if do
    command('grep "^\s*linux" /boot/grub/grub.cfg | grep "ipv6.disable=1"').exit_status != 0
  end

  describe file('/etc/default/grub') do
    its(:content) { should match 'GRUB_CMDLINE_LINUX=".*ipv6.disable=1.*"' }
  end
end
