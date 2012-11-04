#!/usr/bin/env ruby
#
# Helper classes for ddis - DNS Discovery thing

require 'netaddr'
require 'resolv'
require 'net/ping/icmp'

require 'ddis/ip_iterate.rb'
require 'ddis/store_ips.rb'

class DDis
  attr_accessor :iterator
  
  def initialize range, unassigned, verbose=nil
    @verbose  = true if verbose

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
      warn "Couldn't get host for #{ip}"
      return nil
    end
    
    @ping.host = ip
    up = @ping.ping?

    if up and hostname =~ /#{@unass}/
      warn "#{ip} is up yet has an invalid hostname" if @verbose
      @db.up_no_dns( ip )
    end

    if not up and hostname !~ /#{@unass}/
      warn "#{ip} is down yet has a hostname set" if @verbose
      @db.down_with_dns( ip )
    end
  end

end
