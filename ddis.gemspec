Gem::Specification.new do |s|
  s.name = "ddis"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jspc"]
  s.date = "2012-11-07"
  s.description = "A small utility to determine the conformity of an IP on a network"
  s.email = "james@zero-internet.org.uk"
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