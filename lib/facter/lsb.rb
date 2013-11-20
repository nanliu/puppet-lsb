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
elsif Facter.value('osfamily') == 'Suse'
  lsb = Hash.new('')
  data = File.read('/etc/SuSE-release').split("\n")
  lsb[:distdescription] = data[0].chomp

  lsb[:distid] = 'SUSE LINUX'
  lsb[:distrelease] = data[1].split('=').last.chomp
  lsb[:majdistrelease] = data[1].split('=').last.chomp
  lsb[:distcodename] = 'n/a'

  lsb.each do |key, value|
    Facter.add("lsb#{key}") { setcode { value } }
  end
end
