require 'socket'
require './lib/diagnostic'
require './lib/parser'
require 'pry'

class WebServer
  attr_accessor :looping
  attr_reader :all_count

  def initialize
    @looping = true
  end

  def server_loop
    tcp_server = TCPServer.new(9292)
    parser = Parser.new
    while @looping #needs to be until/while loop, not sure how to implement
      client = tcp_server.accept
      request = Diagnostic.parse_requests(client)
      response = parser.response(request)
      # headers, output = parser.route(request)
      # client.puts headers
      client.puts response
      client.close
    end
  end

end
if __FILE__ == $0
server = WebServer.new
server.server_loop
end
