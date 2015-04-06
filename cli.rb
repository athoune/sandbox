#!/usr/bin/env ruby

# This is just a debug tool
#
require 'socket'
require 'timeout'

tpl = STDIN.read
socket_path = ARGV[0]

s = UNIXSocket.new(socket_path)

begin
  status = Timeout::timeout(5) do
    # FIXME handling UTF8
    s.puts [tpl.length].pack("L")
    s.puts tpl
    status, size = s.recv(5).unpack("CL")
    raise 'wrong status' if status > 1
    if size
      all_data = []
      while true
        blob = s.recv(size)
        all_data << blob
        size -= blob.length
        break if size == 0
      end
      response = all_data.join
      raise response if status == 1
      response
    end
  end
rescue Timeout::Error
  s.close
end

p status
