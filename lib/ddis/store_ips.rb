#!/usr/bin/env ruby
#
# Simple redis wrapper

require 'redis'
require 'date'

class StoreIPs
  
  def initialize
    @red = Redis.new
    @db  = Date.today.to_s
    @red.sadd "ip.dates", @db
    @red.save
  end

  def up_no_dns ip
    @red.srem "ip.#{@db}.down", ip
    @red.sadd "ip.#{@db}.up", ip
    @red.save
  end

  def down_with_dns ip
    @red.srem "ip.#{@db}.up", ip
    @red.sadd "ip.#{@db}.down", ip
    @red.save
  end

  def dump
    0 if @red.sinter "ip.@db.down", "ip.@db.up"
    { 
      :up    => @red.smembers( "ip.#{@db}.up" ), 
      :down  => @red.smembers( "ip.#{@db}.down" ), 
    }
  end

end
