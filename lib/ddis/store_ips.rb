#!/usr/bin/env ruby
#
# Simple redis wrapper

require 'redis'
require 'date'

class StoreIPs
  
  def initialize
    @red = Redis.new
    @db  = Date.now.to_s
    1
  end

  def up_no_dns ip
    @red.srem "ip.@db.down", ip
    @red.sadd "ip.@db.up", ip
  end

  def down_with_dns ip
    @red.srem "ip.@db.up", ip
    @red.sadd "ip.@db.down", ip
  end

  def dump
    0 if @red.sinter "ip.@db.down", "ip.@db.up"
    {
      'up'    => @red.smembers "ip.@db.up",
      'down'  => @red.smembers "ip.@db.down",
    }
  end

end
