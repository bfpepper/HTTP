require 'socket'
require './lib/diagnostic'
require './lib/parser'
require 'pry'

class WebServer

  def server_loop
    tcp_server = TCPServer.new(9292)
    parser = Parser.new
    loop do
      client = tcp_server.accept
      request = Diagnostic.parse_requests(client)
      # binding.pry
      headers, output = parser.route(request) #not working yet
      client.puts headers
      client.puts output
      client.close
    end
  end

end
server = WebServer.new
server.server_loop
