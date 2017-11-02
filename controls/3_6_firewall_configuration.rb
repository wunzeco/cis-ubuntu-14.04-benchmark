# encoding: utf-8
# copyright: 2017, The Authors

title '3.6 Firewall Configuration'

control 'cis-ubuntu-14.04-3.6.1' do
  impact  1.0
  title   '3.6.1 Ensure iptables is installed (Scored)'
  desc    'iptables allows configuration of the IPv4 tables in the linux kernel and the rules stored within them. Most firewall configuration utilities operate as a front end to iptables.'

  tag cis: 'ubuntu-14.04:3.6.1'

  describe package('iptables') do
    it { should be_installed }
  end
end

control 'cis-ubuntu-14.04-3.6.2' do
  impact  1.0
  title   '3.6.2 Ensure default deny firewall policy (Scored)'
  desc    'A default deny all policy on connections ensures that any unconfigured network usage will be rejected.'

  tag cis: 'ubuntu-14.04:3.6.2'

	describe iptables do
		it { should have_rule('-P INPUT DROP') }
		it { should have_rule('-P OUTPUT DROP') }
		it { should have_rule('-P FORWARD DROP') }
	end
end

control 'cis-ubuntu-14.04-3.6.3' do
  impact  1.0
  title   '3.6.3 Ensure loopback traffic is configured (Scored)'
  desc    'Configure the loopback interface to accept traffic. Configure all other interfaces to deny traffic to the loopback network (127.0.0.0/8).'

  tag cis: 'ubuntu-14.04:3.6.3'

	describe iptables do
    it { should have_rule('-A INPUT -i lo -j ACCEPT') }
    it { should have_rule('-A OUTPUT -o lo -j ACCEPT') }
    it { should have_rule('-A INPUT -s 127.0.0.0/8 -j DROP') }
	end
end

control 'cis-ubuntu-14.04-3.6.4' do
  impact  0.0
  title   '3.6.4 Ensure outbound and established connections are configured (Not Scored)'
  desc    'Configure the firewall rules for new outbound, and established connections.'

  tag cis: 'ubuntu-14.04:3.6.4'

	describe iptables do
    it { should have_rule('-A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT') }
    it { should have_rule('-A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT') }
    it { should have_rule('-A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT') }
    it { should have_rule('-A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT') }
    it { should have_rule('-A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT') }
    it { should have_rule('-A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT') }
	end
end

control 'cis-ubuntu-14.04-3.6.5' do
  impact  0.0
  title   '3.6.5 Ensure firewall rules exist for all open ports (Scored)'
  desc    'Any ports that have been opened on non-loopback addresses need firewall rules to govern traffic.'

  tag cis: 'ubuntu-14.04:3.6.5'

	listening_ports = command('netstat -lntu4 | grep -v -E "127.0.0.|^Active|^Proto"').stdout.split("\n")

	describe iptables do
    listening_ports.each do |line|
      protocol = line.split()[0]
      port = line.split()[3].gsub(/.*:(\d)/, '\1')
			it { should have_rule("-A INPUT -p #{protocol} --dport #{port} -m state --state NEW -j ACCEPT") }
    end
	end
end


