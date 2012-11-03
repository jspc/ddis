#!/usr/bin/env ruby
#
# Helper classes for ddis - DNS Discovery thing

require 'netaddr'
require 'resolv'
require 'net/ping/icmp'

require 'ddis/ip_iterate.rb'
require 'ddis/store_ips.rb'

class DDis
  attr_accessor :base, :size

  def initialize range unassigned
    @unass    = unassigned
    @resolv   = Resolv.new
    @ping     = Net::Ping::ICMP.new nil, nil, 1

    ip_range  = NetAddr::CIDR.create range
    @base     = ip_range.base
    @size     = ip_range.size
    @iterator = Iterator.new @base, @size
    @db       = StoreIPs.new

  end

  def test_ip ip
    begin
      hostname = @resolv.getname ip
    rescue
      return nil
    end
    
    @ping.host = ip
    
    @db.up_no_dns( ip )     if ( @ping.ping? and
                                 hostname =~ @unass
                                 )
    @db.down_with_dns( ip ) if ( !@ping.ping? and
                                 hostname !~ @unass
                                 )
    
  end
  
end
  
