#!/usr/bin/env ruby

require 'socket'

tpl = STDIN.read

s = UNIXSocket.new("box.sock")

# FIXME handling UTF8
s.puts [tpl.length].pack("L")
s.puts tpl
size = s.recv(4).unpack("L")[0]


p s.recv(size) if not size.nil?
