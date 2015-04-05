#!/usr/bin/env ruby

# This is just a debug tool
#
require 'socket'

tpl = STDIN.read
socket_path = ARGV[0]

s = UNIXSocket.new(socket_path)

# FIXME handling UTF8
s.puts [tpl.length].pack("L")
s.puts tpl
size = s.recv(4).unpack("L")[0]

p s.recv(size) if not size.nil?
