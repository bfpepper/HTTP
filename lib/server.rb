require_relative 'parser'
require 'socket'
require 'timeout'
require 'pry'

#this receives all the input from other files.

class Server


  tcp_server = TCPServer.new(9292)
  client = tcp_server.accept
  hw_count = 0
  all_count = 0
  timeout_in_seconds = 4

  while tcp_server.listen(1)
    Timeout::timeout(timeout_in_seconds) do
      puts "Ready for a request"
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      p=Parser.new(request_lines)

      #puts "Got this request:"
      #puts request_lines.inspect

      puts "Sending response."
      response = "<pre>Hello world (#{hw_count})\n#{p.verb}\n#{p.path}\n#{p.protocol}\n#{p.host}\n#{p.port}\n#{p.origin}\n#{p.accept}</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{output.length}\r\n\r\n"].join("\r\n")
        client.puts headers
        client.puts output

        puts ["Wrote this response:", headers, output].join("\n")
        all_count += 1
        puts "\nResponse complete, exiting."

      end

    end

  end
