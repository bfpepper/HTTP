require './lib/request_parser'
require 'pry'

class Router
  attr_reader :hello_world,
  :route, :response

  def initialize
    @hello_world = 0
    @all_count = 0
  end

  def response(request)
    @all_count += 1
    diag = "<pre>\n#{request.each { |k, v| puts k + ": " + v }}</pre>"
    body = "<html><head></head><body>#{content(request)}\n\n#{diag}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{body.length}\r\n\r\n"].join("\r\n")
    response = headers + body
  end

  def content(request)
      ""                  if request['Path'] == "/"
      hello_world         if request['Path'] == "/hello"
      datetime            if request['Path'] == "/datetime"
      shutdown            if request['Path'] == "/shutdown"
      word_search(word)   if request['Path'].include? "/word_search"
      # binding.pry
  end

  def hello_world
    @hello_world += 1
    # binding.pry
    "Hello, world! (#{@hello_world})"
  end

  def datetime
    "date: #{Time.now.strftime('%l:%m %p on %A, %B %e, %Y')}"
  end

  def shutdown
    "Total requests: #{@all_count}"
  end

  def word_search(word)
    word_included = File.read("/usr/share/dict/words").split("\n").include?(word)
    word_included ? "#{word} is a known word" : "#{word} is not a known word"
  end
end
