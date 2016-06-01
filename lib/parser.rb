require './lib/diagnostic'
require 'pry'

class Parser
  attr_reader :request_lines,
  :hello_world,
  :route

  def initialize
    @hello_world = 0
    # @verb = "#{request_lines[0].split[0]}"
    # @path = "#{request_lines[0].split[1]}"
    # @protocol = "#{request_lines[0].split[2]}"
    # @host = "#{request_lines[1].split[1].split(':')[0]}"
    # @port = "#{request_lines[1].split[1].split(':')[1]}"
    # @origin = "#{request_lines[1].split[1]}"
    # @accept = "#{request_lines[6].split[1]}"
  end

  def route(request)
    if request['Path'] == "/hello"
      ["http/1.1 200 ok\r\n\r\n", hello_world]
    elsif request['Path'] == "/datetime"
      puts "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}"
    elsif request['Path'] == "/shutdown"
      puts "Total requests: #{all_count}"
      client.close
    elsif request['Path'] == "/"
      puts "Sending response."
      response = "<pre>\n#{request.each { |k, v| puts k + ": " + v }}</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      puts ["Wrote this response:", headers, output].join("\n")
      [headers, output]
        # client.puts headers
        # client.puts output


    end
  end

    def hello_world
      result =  "Hello, world! (#{@hello_world})"
      @hello_world += 1
      result
    end

  end
