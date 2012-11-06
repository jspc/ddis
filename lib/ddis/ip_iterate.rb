#!/usr/bin/env ruby
#
# Iterate through IPs given a CIDR, start and end IP

class Iterator
  attr_accessor :ip

  def initialize start_ip, size
    @start_ip = start_ip
    @start_si = size

    @ip       = start_ip
    @esize    = 0

  end

  def increment_last ip
    return nil if ip == '255.255.255.255'    # End of the line
    
    octets = ip.split "."
    last = octets[-1]
    
    return "#{increment_last octets[0..-2].join('.')}.0" if last == '255'
    last = Integer(last)
    last += 1
    return "#{octets[0..-2].join('.')}.#{last}"
  end
  
  def iterate
    @ip = increment_last @ip
    @esize += 1
    
    if @esize == @start_si
      @esize = @start_si
      @ip    = @start_ip
      return nil
    end
    
    return @ip

  end

end
