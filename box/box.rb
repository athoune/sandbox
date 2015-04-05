#!/usr/bin/env ruby
require 'rubygems'
require 'socket'
require 'haml'

socket_path = ARGV[0]

File.unlink(socket_path) if File.exist?(socket_path)


UNIXServer.open(socket_path) do |serv|
  loop do
    s = serv.accept
    again = true
    while again
      size = s.recv(4).unpack("L")[0]
      if size.nil?
        sleep 0.1
      else
        # FIXME raise if size is too huge

        template = s.recv(size)
        # FIXME handling UTF8
        haml_engine = Haml::Engine.new(template)
        output = haml_engine.render
        # FIXME handling UTF8
        s.puts [output.length].pack("L")
        s.puts output
        s.close
        again = false
      end
    end
  end
end
