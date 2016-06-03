require 'pry'
require 'socket'
require './lib/request_parser'
require './lib/router'

class WebServer
  attr_accessor :looping
  attr_reader :all_count

  def initialize
    @looping = true
  end

  def server_loop
    tcp_server = TCPServer.new(9292)
    router = Router.new
    while @looping
      client = tcp_server.accept
      request = RequestParser.parse_requests(client)
      response = router.response(request)
      client.puts response
      @looping = false if response.split.include?"/shutdown"
      client.close
    end
  end

end
if __FILE__ == $0
server = WebServer.new
server.server_loop
end
