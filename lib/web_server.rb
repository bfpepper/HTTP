require 'socket'
require './lib/diagnostic'
require './lib/parser'
require 'pry'


class WebServer

  def server_loop
    tcp_server = TCPServer.new(9292)
    loop do
      client = tcp_server.accept
      # binding.pry
      request = Diagnostic.parse_requests(client)
      Parser.new.route(request)
      client.close
    end
  end

end
server = WebServer.new
server.server_loop
