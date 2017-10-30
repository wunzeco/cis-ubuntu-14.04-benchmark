# encoding: utf-8
# copyright: 2017, The Authors

title '3.1 Network Parameters (Host Only)'

control 'cis-ubuntu-14.04-3.1.1' do
  impact  1.0
  title   '3.1.1 Ensure IP forwarding is disabled (Scored)'
  desc    'The net.ipv4.ip_forward flag is used to tell the system whether it can forward packets or not.'

  tag cis: 'ubuntu-14.04:3.1.1'

  describe command('sysctl net.ipv4.ip_forward') do
    its(:stdout) { should match 'net.ipv4.ip_forward = 0' }
  end
end

control 'cis-ubuntu-14.04-3.1.2' do
  impact  1.0
  title   '3.1.2 Ensure packet redirect sending is disabled (Scored)'
  desc    'ICMP Redirects are used to send routing information to other hosts. As a host itself does not act as a router (in a host only configuration), there is no need to send redirects.'

  tag cis: 'ubuntu-14.04:3.1.2'

  describe command('sysctl net.ipv4.conf.all.send_redirects') do
    its(:stdout) { should match 'net.ipv4.conf.all.send_redirects = 0' }
  end
  describe command('sysctl net.ipv4.conf.default.send_redirects') do
    its(:stdout) { should match 'net.ipv4.conf.default.send_redirects = 0' }
  end
end
