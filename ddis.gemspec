Gem::Specification.new do |s|
  s.name = "ddis"
  s.version = "1.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jspc"]
  s.date = "2013-01-21"
  s.description = "A small utility to determine the conformity of an IP on a network"
  s.summary = s.description
  s.email = "james@zero-internet.org.uk"
  s.homepage = "https://github.com/jspc/ddis"
  s.executables = ["ddis"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "LICENSE.txt" ,
    "RATIONALE.txt" ,
    "README.md" ,
    "bin/ddis" ,
    "lib/ddis.rb" ,
    "lib/ddis/ip_iterate.rb" ,
    "lib/ddis/store_ips.rb" ,
   ]
   s.add_dependency( 'net-ping', '>=1.5.3' )
   s.add_dependency( 'netaddr',  '>=1.5.0' )
   s.add_dependency( 'redis',    '>=3.0.2' )

end
