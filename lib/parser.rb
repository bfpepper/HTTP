require 'pry'

class Parser
  attr_reader :request_lines,
  :hello_world,
  :route

  # def initialize(request_lines)
  #   @hello_world = 0
  #   @verb = "#{request_lines[0].split[0]}"
  #   @path = "#{request_lines[0].split[1]}"
  #   @protocol = "#{request_lines[0].split[2]}"
  #   @host = "#{request_lines[1].split[1].split(':')[0]}"
  #   @port = "#{request_lines[1].split[1].split(':')[1]}"
  #   @origin = "#{request_lines[1].split[1]}"
  #   @accept = "#{request_lines[6].split[1]}"
  # end

  def route(request_lines)
    if @path == "/hello"
      puts "Hello, world (#{@hello_world})"
      hw_count += 1
    elsif @path == "/datetime"
      puts "strftime thing"
    elsif @path == "/shutdown"
      puts "Total requests: #{all_count}"
      client.close
    elsif @path == "/"
      puts "Sending response."
      response = "<pre>\n#{request.each { |k, v| puts k + ": " + v }}</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{output.length}\r\n\r\n"].join("\r\n")
        client.puts headers
        client.puts output

      puts ["Wrote this response:", headers, output].join("\n")
    end
  end

    def hello_world
      "Hello, world! (#{@hello_world})"
      @hello_world += 1
    end

  end
