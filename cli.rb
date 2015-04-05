#!/usr/bin/env ruby

# This is just a debug tool
#
require 'socket'
require 'timeout'

tpl = STDIN.read
socket_path = ARGV[0]

s = UNIXSocket.new(socket_path)

status = Timeout::timeout(5) do
  # FIXME handling UTF8
  s.puts [tpl.length].pack("L")
  s.puts tpl
  size = s.recv(4).unpack("L")[0]

  if size
    all_data = []
    while true
      blob = s.recv(size)
      all_data << blob
      size -= blob.length
      break if size == 0
    end
    all_data.join
  end
end

p status
