#Move controller and connect to server.rb
#get debugger to work with Hello world



require './lib/parser'
require 'socket'
require './lib/controller'

require 'timeout'
require 'pry'

#this receives all the input from other files.

class Server

# Server
#add loop to Server
  tcp_server = TCPServer.new(9292)
  client = tcp_server.accept
  timeout_in_seconds = 4

  while tcp_server.listen(1)
    Timeout::timeout(timeout_in_seconds) do
      puts "Ready for a request"
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      p=Parser.new(request_lines)
# end server
      #puts "Got this request:"
      #puts request_lines.inspect
      end

    end

  end
