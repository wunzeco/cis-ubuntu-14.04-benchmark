# encoding: utf-8
# copyright: 2017, The Authors

title '1.5 Additional Process Hardening'

control 'cis-ubuntu-14.04-1.5.1' do
  impact  1.0
  title   '1.5.1 Ensure core dumps are restricted (Scored)'
  desc    'A core dump is the memory of an executable program. It is generally used to determine why a program aborted. It can also be used to glean confidential information from a core file. The system provides the ability to set a soft limit for core dumps, but this can be overridden by the user.'

  tag cis: 'ubuntu-14.04:1.5.1'

  limits_d_files = Dir.glob('/etc/security/limits.d/*.conf').join(' ')
  describe command("grep 'hard core' /etc/security/limits.conf #{limits_d_files}") do
    its(:stdout) { should match '* hard core 0' }
  end

  describe command("sysctl fs.suid_dumpable") do
    its('stdout') { should match 'fs.suid_dumpable = 0' }
  end
end

control 'cis-ubuntu-14.04-1.5.2' do
  impact  1.0
  title   '1.5.2 Ensure XD/NX support is enabled (Not Scored)'
  desc    'Recent processors in the x86 family support the ability to prevent code execution on a per memory page basis. Generically and on AMD processors, this ability is called No Execute (NX), while on Intel processors it is called Execute Disable (XD). This ability can help prevent exploitation of buffer overflow vulnerabilities and should be activated whenever possible. Extra steps must be taken to ensure that this protection is enabled, particularly on 32-bit x86 systems.'

  tag cis: 'ubuntu-14.04:1.5.2'

  describe command('dmesg | grep NX') do
    its(:stdout) { should include 'NX (Execute Disable) protection: active' }
  end
end

control 'cis-ubuntu-14.04-1.5.3' do
  impact  1.0
  title   '1.5.3 Ensure address space layout randomization (ASLR) is enabled (Scored)'
  desc    'Address space layout randomization (ASLR) is an exploit mitigation technique which randomly arranges the address space of key data areas of a process.'

  tag cis: 'ubuntu-14.04:1.5.3'

  describe command('dmesg | grep NX') do
    its(:stdout) { should include 'NX (Execute Disable) protection: active' }
  end
end

control 'cis-ubuntu-14.04-1.5.4' do
  impact  1.0
  title   '1.5.4 Ensure prelink is disabled (Scored)'
  desc    'prelink is a program that modifies ELF shared libraries and ELF dynamically linked binaries in such a way that the time needed for the dynamic linker to perform relocations at startup significantly decreases.'

  tag cis: 'ubuntu-14.04:1.5.4'

  describe package('prelink') do
    it { should_not be_installed }
  end
end
