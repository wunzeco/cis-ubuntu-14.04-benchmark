# encoding: utf-8
# copyright: 2017, The Authors

title '2.2 Special Purpose Services'

# 2.2.1 Time Synchronization

control 'cis-ubuntu-14.04-2.2.1.1' do
  impact  1.0
  title   '2.2.1.1 Ensure time synchronization is in use (Not Scored)'
  desc    'System time should be synchronized between all systems in an environment. This is typically done by establishing an authoritative time server or set of servers and having all systems synchronize their clocks to them.'

  tag cis: 'ubuntu-14.04:2.2.1.1'

  if package('chrony').installed? 
    describe package('chrony') do
      it { should be_installed }
    end
  else
    describe package('ntp') do
      it { should be_installed }
    end
  end
end

control 'cis-ubuntu-14.04-2.2.1.2' do
  impact  1.0
  title   '2.2.1.2 Ensure ntp is configured (Scored)'
  desc    'ntp is a daemon which implements the Network Time Protocol (NTP). It is designed to synchronize system clocks across a variety of systems and use a source that is highly accurate. More information on NTP can be found at http://www.ntp.org. ntp can be configured to be a client and/or a server.'

  tag cis: 'ubuntu-14.04:2.2.1.2'

  only_if do
    package('ntp').installed?
  end

  describe file('/etc/ntp.conf') do
    its(:content) { should match %r{^restrict (-4)?\s*default \w+} }
    its(:content) { should match %r{^restrict -6 default \w+} }
  end
  # restrict -4 default
  describe command('grep "^restrict" /etc/ntp.conf | grep -v "\-6"') do
    its(:stdout) { should match 'kod' }
    its(:stdout) { should match 'nomodify' }
    its(:stdout) { should match 'notrap' }
    its(:stdout) { should match 'nopeer' }
    its(:stdout) { should match 'noquery' }
  end
  # restrict -6 default
  describe command('grep "^restrict" /etc/ntp.conf | grep "\-6"') do
    its(:stdout) { should match 'kod' }
    its(:stdout) { should match 'nomodify' }
    its(:stdout) { should match 'notrap' }
    its(:stdout) { should match 'nopeer' }
    its(:stdout) { should match 'noquery' }
  end
  describe file('/etc/ntp.conf') do
    its(:content) { should match %r{^server\s+\w+} }
  end
  describe file('/etc/init.d/ntp') do
    its(:content) { should match '^RUNASUSER=ntp' }
  end
end

control 'cis-ubuntu-14.04-2.2.1.3' do
  impact  1.0
  title   '2.2.1.3 Ensure chrony is configured (Scored)'
  desc    'chrony is a daemon which implements the Network Time Protocol (NTP) is designed to synchronize system clocks across a variety of systems and use a source that is highly accurate. More information on chrony can be found at http://chrony.tuxfamily.org/. chrony can be configured to be a client and/or a server.'

  tag cis: 'ubuntu-14.04:2.2.1.3'

  only_if do
    package('chrony').installed?
  end

  describe file('/etc/chrony/chrony.conf') do
    its(:content) { should match %r{^server\s+\w+} }
  end
end

control 'cis-ubuntu-14.04-2.2.2' do
  impact  1.0
  title   '2.2.2 Ensure X Window System is not installed (Scored)'
  desc    'The X Window System provides a Graphical User Interface (GUI) where users can have multiple windows in which to run programs and various add on. The X Windows system is typically used on workstations where users login, but not on servers where users typically do not login.'

  tag cis: 'ubuntu-14.04:2.2.2'

  command("apt-cache search '^xserver-xorg*' | cut -d ' ' -f1").stdout.split(' ').each do |pkg|
    describe package(pkg) do
      it { should_not be_installed }
    end
  end
end

control 'cis-ubuntu-14.04-2.2.3' do
  impact  1.0
  title   '2.2.3 Ensure Avahi Server is not enabled (Scored)'
  desc    'Avahi is a free zeroconf implementation, including a system for multicast DNS/DNS-SD service discovery. Avahi allows programs to publish and discover services and hosts running on a local network with no specific configuration. For example, a user can plug a computer into a network and Avahi automatically finds printers to print to, files to look at and people to talk to, as well as network services running on the machine.'

  tag cis: 'ubuntu-14.04:2.2.3'

  describe command('initctl show-config avahi-daemon') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.4' do
  impact  1.0
  title   '2.2.4 Ensure CUPS is not enabled (Scored)'
  desc    'The Common Unix Print System (CUPS) provides the ability to print to both local and network printers. A system running CUPS can also accept print jobs from remote systems and print them to local printers. It also provides a web based remote administration capability.'

  tag cis: 'ubuntu-14.04:2.2.4'

  describe command('initctl show-config cups') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.5' do
  impact  1.0
  title   '2.2.5 Ensure DHCP Server is not enabled (Scored)'
  desc    'The Dynamic Host Configuration Protocol (DHCP) is a service that allows machines to be dynamically assigned IP addresses.'

  tag cis: 'ubuntu-14.04:2.2.5'

  describe command('initctl show-config isc-dhcp-server') do
    its(:stdout) { should_not match 'start on' }
  end
  describe command('initctl show-config isc-dhcp-server6') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.6' do
  impact  1.0
  title   '2.2.6 Ensure LDAP server is not enabled (Scored)'
  desc    'The Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for NIS/YP. It is a service that provides a method for looking up information from a central database.'

  tag cis: 'ubuntu-14.04:2.2.7'

  describe service('slapd') do
    it { should_not be_installed }
    it { should_not be_enabled }
    it { should_not be_running }
  end
end

control 'cis-ubuntu-14.04-2.2.7' do
  impact  1.0
  title   '2.2.7 Ensure NFS and RPC are not enabled (Scored)'
  desc    'The Network File System (NFS) is one of the first and most widely distributed file systems in the UNIX environment. It provides the ability for systems to mount file systems of other servers through the network.'

  tag cis: 'ubuntu-14.04:2.2.7'

  describe service('nfs-kernel-server') do
    it { should_not be_installed }
    it { should_not be_enabled }
    it { should_not be_running }
  end
  describe command('initctl show-config rpcbind') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.8' do
  impact  1.0
  title   '2.2.8 Ensure DNS Server is not enabled (Scored)'
  desc    'The Domain Name System (DNS) is a hierarchical naming system that maps names to IP addresses for computers, services and other resources connected to a network.'

  tag cis: 'ubuntu-14.04:2.2.8'

  describe service('bind9') do
    it { should_not be_installed }
    it { should_not be_enabled }
    it { should_not be_running }
  end
end

control 'cis-ubuntu-14.04-2.2.9' do
  impact  1.0
  title   '2.2.9 Ensure FTP Server is not enabled (Scored)'
  desc    'The File Transfer Protocol (FTP) provides networked computers with the ability to transfer files.'

  tag cis: 'ubuntu-14.04:2.2.9'

  describe command('initctl show-config vsftpd') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.10' do
  impact  1.0
  title   '2.2.10 Ensure HTTP server is not enabled (Scored)'
  desc    'HTTP or web servers provide the ability to host web site content.'

  tag cis: 'ubuntu-14.04:2.2.10'

  describe service('apache2') do
    it { should_not be_installed }
    it { should_not be_enabled }
    it { should_not be_running }
  end
end

control 'cis-ubuntu-14.04-2.2.11' do
  impact  1.0
  title   '2.2.11 Ensure IMAP and POP3 server is not enabled (Scored)'
  desc    'dovecot is an open source IMAP and POP3 server for Linux based systems.'

  tag cis: 'ubuntu-14.04:2.2.11'

  describe command('initctl show-config dovecot') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.12' do
  impact  1.0
  title   '2.2.12 Ensure Samba is not enabled (Scored)'
  desc    'The Samba daemon allows system administrators to configure their Linux systems to share file systems and directories with Windows desktops. Samba will advertise the file systems and directories via the Small Message Block (SMB) protocol. Windows desktop users will be able to mount these directories and file systems as letter drives on their systems.'

  tag cis: 'ubuntu-14.04:2.2.12'

  describe command('initctl show-config smbd') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.13' do
  impact  1.0
  title   '2.2.13 Ensure HTTP Proxy Server is not enabled (Scored)'
  desc    'Squid is a standard proxy server used in many distributions and environments.'

  tag cis: 'ubuntu-14.04:2.2.13'

  describe command('initctl show-config squid3') do
    its(:stdout) { should_not match 'start on' }
  end
end

control 'cis-ubuntu-14.04-2.2.14' do
  impact  1.0
  title   '2.2.14 Ensure SNMP Server is not enabled (Scored)'
  desc    'The Simple Network Management Protocol (SNMP) server is used to listen for SNMP commands from an SNMP management system, execute the commands or collect the information and then send results back to the requesting system.'

  tag cis: 'ubuntu-14.04:2.2.14'

  describe service('snmpd') do
    it { should_not be_installed }
    it { should_not be_enabled }
    it { should_not be_running }
  end
end

control 'cis-ubuntu-14.04-2.2.15' do
  impact  1.0
  title   '2.2.15 Ensure mail transfer agent is configured for local-only mode (Scored)'
  desc    'Mail Transfer Agents (MTA), such as sendmail and Postfix, are used to listen for incoming mail and transfer the messages to the appropriate user or mail server. If the system is not intended to be a mail server, it is recommended that the MTA be configured to only process local mail.'

  tag cis: 'ubuntu-14.04:2.2.15'

  describe file('/etc/postfix/main.cf') do
    its(:content) { should match 'inet_interfaces\s*=\s*localhost'}
  end
end

control 'cis-ubuntu-14.04-2.2.16' do
  impact  1.0
  title   '2.2.16 Ensure rsync service is not enabled (Scored)'
  desc    'The rsyncd service can be used to synchronize files between systems over network links.'

  tag cis: 'ubuntu-14.04:2.2.16'

  describe file('/etc/default/rsync') do
    its(:content) { should match 'RSYNC_ENABLE=false'}
  end
end
