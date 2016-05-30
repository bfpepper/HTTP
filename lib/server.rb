require 'pry'
require 'byebug'
require 'socket'
require 'timeout'


# class ServerClass

  tcp_server = TCPServer.new(9292)
  client = tcp_server.accept
  count = 0
  timeout_in_seconds = 4

    while tcp_server.listen(1)
      Timeout::timeout(timeout_in_seconds) do
    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    # byebug
    # binding.pry

    puts "Got this request:"
    puts request_lines.inspect

    puts "Sending response."
    response = "<pre>Hello world (#{count})\nVERB: #{request_lines[0].split[0]}\nPATH: #{request_lines[0].split[1]}\nPROTOCOL: #{request_lines[0].split[2]}\nHOST: #{request_lines[1].split[1].split(':')[0]}\nPORT: #{request_lines[1].split[1].split(':')[1]}\nORIGIN: #{request_lines[1].split[1]}\nACCEPT: #{request_lines[6].split[1]}</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      puts ["Wrote this response:", headers, output].join("\n")
      # binding.pry
      count += 1
    #  end
      # client.close
      puts "\nResponse complete, exiting."

    end

end
