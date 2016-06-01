require './lib/diagnostic'
require './lib/web_server'
require 'pry'

class Parser
  attr_reader :hello_world,
  :route

  def initialize
    @hello_world = 0
    @all_count = 0
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
      response = ["http/1.1 200 ok\r\n\r\n", hello_world]
      @all_count += 1
    elsif request['Path'] == "/datetime"
      response = "date: #{Time.now.strftime('%l:%m %p on %A, %B %e, %Y')}"
      @all_count += 1
    elsif request['Path'] == "/shutdown"
      response = "Total requests: #{@all_count}"
      @all_count += 1
    elsif request['Path'] == "/"
      puts "Sending response."
      respond = "<pre>\n#{request.each { |k, v| puts k + ": " + v }}</pre>"
      output = "<html><head></head><body>#{respond}</body></html>"
      headers = ["http/1.1 200 ok",
        "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
        "server: ruby",
        "content-type: text/html; charset=iso-8859-1",
        "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      puts ["Wrote this response:", headers, output].join("\n")
        response = [headers, output]
        @all_count +=1
    elsif request['Path'].include? "/word_search"
      word = request['Path'].partition('=').last
      word_search(word)
    end
    response
  end

  def hello_world
    result =  "Hello, world! (#{@hello_world})"
    @hello_world += 1
    result
  end

  def word_search(word)
    
  end
end
