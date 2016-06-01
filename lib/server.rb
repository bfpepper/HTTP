#Move controller and connect to server.rb
#get debugger to work with Hello world
require './lib/parser'
require './lib/controller'
require 'socket'
require 'timeout'
require 'pry'
#this receives all the input from other files.

class Server

  #add loop to Server
  # tcp_server = TCPServer.new(9292)
  # client = tcp_server.accept
  timeout_in_seconds = 4
  parser = Parser.new
  while tcp_server.listen(1)
    #Timeout::timeout(timeout_in_seconds) do
      #puts "Ready for a request"
      # request_lines = []
      # while line = client.gets and !line.chomp.empty?
      #   request_lines << line.chomp
      # end
      parser.route(request_lines)
      #puts "Got this request:"
      #puts request_lines.inspect
    end

  end

end
