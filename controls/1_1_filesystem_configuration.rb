# encoding: utf-8
# copyright: 2017, The Authors

title '1.1 Filesystem Configuration'

control 'cis-ubuntu-14.04-1.1.1.1' do
  impact  1.0
  title   '1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Scored)'
  desc    'The cramfs filesystem type is a compressed read-only Linux filesystem embedded in small footprint systems. A cramfs image can be used without having to first decompress the image'

  tag cis: 'ubuntu-14.04:1.1.1.1'

  describe '' do
  end
end
