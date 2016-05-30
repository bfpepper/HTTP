require 'socket'
require 'timeout'

  tcp_server = TCPServer.new(9292)
  client = tcp_server.accept
  count = 0
  timeout_in_seconds = 4
  hw = "Hello, world (#{count})"

  while tcp_server.listen(1)
    Timeout::timeout(timeout_in_seconds) do
  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end
end
