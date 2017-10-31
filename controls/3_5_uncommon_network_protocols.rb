# encoding: utf-8
# copyright: 2017, The Authors

title '3.5 Uncommon Network Protocols'

control 'cis-ubuntu-14.04-3.5.1' do
  impact  0.0
  title   '3.5.1 Ensure DCCP is disabled (Not Scored)'
  desc    'The Datagram Congestion Control Protocol (DCCP) is a transport layer protocol that supports streaming media and telephony. DCCP provides a way to gain access to congestion control, without having to do it at the application layer, but does not provide in-sequence delivery.'

  tag cis: 'ubuntu-14.04:3.5.1'

  describe kernel_module('dccp') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-3.5.2' do
  impact  0.0
  title   '3.5.2 Ensure SCTP is disabled (Not Scored)'
  desc    'The Stream Control Transmission Protocol (SCTP) is a transport layer protocol used to support message oriented communication, with several streams of messages in one connection. It serves a similar function as TCP and UDP, incorporating features of both. It is message-oriented like UDP, and ensures reliable in-sequence transport of messages with congestion control like TCP.'

  tag cis: 'ubuntu-14.04:3.5.2'

  describe kernel_module('sctp') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-3.5.3' do
  impact  0.0
  title   '3.5.3 Ensure RDS is disabled (Not Scored)'
  desc    'The Reliable Datagram Sockets (RDS) protocol is a transport layer protocol designed to provide low-latency, high-bandwidth communications between cluster nodes. It was developed by the Oracle Corporation.'

  tag cis: 'ubuntu-14.04:3.5.3'

  describe kernel_module('rds') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end

control 'cis-ubuntu-14.04-3.5.4' do
  impact  0.0
  title   '3.5.4 Ensure TIPC is disabled (Not Scored)'
  desc    'The Transparent Inter-Process Communication (TIPC) protocol is designed to provide communication between cluster nodes.'

  tag cis: 'ubuntu-14.04:3.5.4'

  describe kernel_module('tipc') do
    it { should be_disabled }
    it { should_not be_loaded }
  end
end
