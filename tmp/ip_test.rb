#!/usr/bin/env ruby
#
# Increment IPs

def increment_last ip
  octets = ip.split "."
  last = octets[-1]

  return "#{increment_last octets[0..-2].join('.')}.0" if last == '255'
  last = Integer(last)
  last += 1
  return "#{octets[0..-2].join('.')}.#{last}"
  
end


puts "10.0.50.1 becomes #{increment_last '10.0.50.1'}"
puts "10.0.50.254 becomes #{increment_last '10.0.50.254'}"
puts "10.0.50.255 becomes #{increment_last '10.0.50.255'}"
puts "10.0.255.255 becomes #{increment_last '10.0.255.255'}"
