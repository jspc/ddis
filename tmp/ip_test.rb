#!/usr/bin/env ruby
#
# Increment IPs

def increment_last ip
  return nil if ip == '255.255.255.255'    # End of the line
  octets = ip.split "."
  last = octets[-1]

  return "#{increment_last octets[0..-2].join('.')}.0" if last == '255'
  last = Integer(last)
  last += 1
  return "#{octets[0..-2].join('.')}.#{last}"
  
end


ip     = '0.0.0.0'
end_ip = '255.255.255.255'

until ip == end_ip
  puts ip
  ip = increment_last ip
end
