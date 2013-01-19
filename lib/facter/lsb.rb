if Facter.value('osfamily') == 'RedHat'
  lsb = Hash.new('')
  lsb[:distdescription] = File.read('/etc/redhat-release').chomp

  lsb[:distid], remainder = lsb[:distdescription].split(' release ')
  lsb[:distrelease], codename = remainder.split(' ', 2)
  lsb[:majdistrelease] = lsb[:distrelease].split('.')[0]
  lsb[:distcodename] = codename.gsub(/[()]/,'')

  lsb.each do |key, value|
    Facter.add("lsb#{key}") { setcode { value } }
  end
end
