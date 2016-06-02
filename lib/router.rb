require './lib/request_parser'
require './lib/game_controller'
require 'pry'

class Router
  attr_reader :route, :response

  def initialize
    @hello_world = 0
    @all_count = 0
    @game = GameController.new
  end

  def response(request)
    @all_count += 1
    something = content(request)
    diag = "<pre>\n#{request.map { |k, v| k + ": " + v  }.join("\n")}\n</pre>"
    body = "<html><head></head><body>#{something}\n#{diag}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{body.length}\n\n"].join("\n")
    headers + body
  end

  def content(request)
    if request['Path'] == "/"
      ""
    elsif request['Path'] == "/hello"
      hello_world
    elsif request['Path'] == "/datetime"
      datetime
    elsif request['Path'] == "/shutdown"
      return shutdown
      # binding.pry
    elsif request['Path'].include? "/word_search"
      word = request['Path'].partition('=').last
      word_search(word)
    elsif request['Verb'] == "POST" && request['Path'] == "/start_game"
      @game.start
      "Good luck!"
    else
      "404"
    end
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
