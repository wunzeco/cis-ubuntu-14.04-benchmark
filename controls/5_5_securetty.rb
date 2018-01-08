# encoding: utf-8
# copyright: 2017, The Authors

title '5.5 Ensure root login is restricted to system console (Not Scored)'

control 'cis-ubuntu-14.04-5.5' do
  impact  0.0
  title   '5.5 Ensure root login is restricted to system console (Not Scored)'
  desc    'The file /etc/securetty contains a list of valid terminals that may be logged in directly as root. Since the system console has special properties to handle emergency situations, it is important to ensure that the console is in a physically secure location and that unauthorized consoles have not been defined.'

  tag cis: 'ubuntu-14.04:5.5'

  # Note:
  #   - No specific remediation guideline on contents of /etc/securetty given
  #   - but CIS Benchmark doc says..
  #     Remediation:
  #       Remove entries for any consoles that are not in a physically secure location.
  describe file('/etc/securetty') do
    it { should be file }
  end
end
