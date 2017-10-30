# encoding: utf-8
# copyright: 2017, The Authors

title '3.2 Network Parameters (Host and Router)'

control 'cis-ubuntu-14.04-3.2.1' do
  impact  1.0
  title   '3.2.1 Ensure source routed packets are not accepted (Scored)'
  desc    'In networking, source routing allows a sender to partially or fully specify the route packets take through a network. In contrast, non-source routed packets travel a path determined by routers in the network. In some cases, systems may not be routable or reachable from some locations (e.g. private addresses vs. Internet routable), and so source routed packets would need to be used.'

  tag cis: 'ubuntu-14.04:3.2.1'

  describe command('sysctl net.ipv4.conf.all.accept_source_route') do
    its(:stdout) { should match 'net.ipv4.conf.all.accept_source_route = 0' }
  end
  describe command('sysctl net.ipv4.conf.default.accept_source_route') do
    its(:stdout) { should match 'net.ipv4.conf.default.accept_source_route = 0' }
  end
end

control 'cis-ubuntu-14.04-3.2.2' do
  impact  1.0
  title   '3.2.2 Ensure ICMP redirects are not accepted (Scored)'
  desc    "ICMP redirect messages are packets that convey routing information and tell your host (acting as a router) to send packets via an alternate path. It is a way of allowing an outside routing device to update your system routing tables. By setting net.ipv4.conf.all.accept_redirects to 0, the system will not accept any ICMP redirect messages, and therefore, won't allow outsiders to update the system's routing tables."

  tag cis: 'ubuntu-14.04:3.2.2'

  describe command('sysctl net.ipv4.conf.all.accept_redirects') do
    its(:stdout) { should match 'net.ipv4.conf.all.accept_redirects = 0' }
  end
  describe command('sysctl net.ipv4.conf.default.accept_redirects') do
    its(:stdout) { should match 'net.ipv4.conf.default.accept_redirects = 0' }
  end
end

control 'cis-ubuntu-14.04-3.2.3' do
  impact  1.0
  title   '3.2.3 Ensure secure ICMP redirects are not accepted (Scored)'
  desc    'Secure ICMP redirects are the same as ICMP redirects, except they come from gateways listed on the default gateway list. It is assumed that these gateways are known to your system, and that they are likely to be secure.'

  tag cis: 'ubuntu-14.04:3.2.3'

  describe command('sysctl net.ipv4.conf.all.secure_redirects') do
    its(:stdout) { should match 'net.ipv4.conf.all.secure_redirects = 0' }
  end
  describe command('sysctl net.ipv4.conf.default.secure_redirects') do
    its(:stdout) { should match 'net.ipv4.conf.default.secure_redirects = 0' }
  end
end

control 'cis-ubuntu-14.04-3.2.4' do
  impact  1.0
  title   '3.2.4 Ensure suspicious packets are logged (Scored)'
  desc    'When enabled, this feature logs packets with un-routable source addresses to the kernel log.'

  tag cis: 'ubuntu-14.04:3.2.4'

  describe command('sysctl net.ipv4.conf.all.log_martians') do
    its(:stdout) { should match 'net.ipv4.conf.all.log_martians = 1' }
  end
  describe command('sysctl net.ipv4.conf.default.log_martians') do
    its(:stdout) { should match 'net.ipv4.conf.default.log_martians = 1' }
  end
end

control 'cis-ubuntu-14.04-3.2.5' do
  impact  1.0
  title   '3.2.5 Ensure broadcast ICMP requests are ignored (Scored)'
  desc    'Setting net.ipv4.icmp_echo_ignore_broadcasts to 1 will cause the system to ignore all ICMP echo and timestamp requests to broadcast and multicast addresses.'

  tag cis: 'ubuntu-14.04:3.2.5'

  describe command('sysctl net.ipv4.icmp_echo_ignore_broadcasts') do
    its(:stdout) { should match 'net.ipv4.icmp_echo_ignore_broadcasts = 1' }
  end
end

control 'cis-ubuntu-14.04-3.2.6' do
  impact  1.0
  title   '3.2.6 Ensure bogus ICMP responses are ignored (Scored)'
  desc    'Setting icmp_ignore_bogus_error_responses to 1 prevents the kernel from logging bogus responses (RFC-1122 non-compliant) from broadcast reframes, keeping file systems from filling up with useless log messages.'

  tag cis: 'ubuntu-14.04:3.2.6'

  describe command('sysctl net.ipv4.icmp_ignore_bogus_error_responses') do
    its(:stdout) { should match 'net.ipv4.icmp_ignore_bogus_error_responses = 1' }
  end
end

control 'cis-ubuntu-14.04-3.2.7' do
  impact  1.0
  title   '3.2.7 Ensure Reverse Path Filtering is enabled (Scored)'
  desc    'Setting net.ipv4.conf.all.rp_filter and net.ipv4.conf.default.rp_filter to 1 forces the Linux kernel to utilize reverse path filtering on a received packet to determine if the packet was valid. Essentially, with reverse path filtering, if the return packet does not go out the same interface that the corresponding source packet came from, the packet is dropped (and logged if log_martians is set).'

  tag cis: 'ubuntu-14.04:3.2.7'

  describe command('sysctl net.ipv4.conf.all.rp_filter') do
    its(:stdout) { should match 'net.ipv4.conf.all.rp_filter = 1' }
  end
  describe command('sysctl net.ipv4.conf.default.rp_filter') do
    its(:stdout) { should match 'net.ipv4.conf.default.rp_filter = 1' }
  end
end

control 'cis-ubuntu-14.04-3.2.8' do
  impact  1.0
  title   '3.2.8 Ensure TCP SYN Cookies is enabled (Scored)'
  desc    'When tcp_syncookies is set, the kernel will handle TCP SYN packets normally until the half-open connection queue is full, at which time, the SYN cookie functionality kicks in. SYN cookies work by not using the SYN queue at all. Instead, the kernel simply replies to the SYN with a SYN|ACK, but will include a specially crafted TCP sequence number that encodes the source and destination IP address and port number and the time the packet was sent. A legitimate connection would send the ACK packet of the three way handshake with the specially crafted sequence number. This allows the system to verify that it has received a valid response to a SYN cookie and allow the connection, even though there is no corresponding SYN in the queue.'

  tag cis: 'ubuntu-14.04:3.2.8'

  describe command('sysctl net.ipv4.tcp_syncookies') do
    its(:stdout) { should match 'net.ipv4.tcp_syncookies = 1' }
  end
end
