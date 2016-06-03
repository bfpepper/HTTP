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
    content = content(request)
    diag = "<pre>\n#{request.map { |k, v| k + ": " + v  }.join("\n")}\n</pre>"
    body = "<html><head></head><body>#{content[0]}\n#{diag}</body></html>"
    headers = ["#{content[1]}",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{body.length}\n\n"].join("\n")
    headers + body
  end

  def content(request)
    if request['Path'] == "/"
      ["", "HTTP/1.1 200 OK"]
    elsif request['Path'] == "/hello"
      [hello_world, "HTTP/1.1 200 OK"]
    elsif request['Path'] == "/datetime"
      [datetime, "HTTP/1.1 200 OK"]
    elsif request['Path'] == "/shutdown"
      [shutdown, "HTTP/1.1 200 OK"]
    elsif request['Path'].include? "/word_search"
      word = request['Path'].partition('=').last
      [word_search(word), "HTTP/1.1 200 OK"]
    elsif request['Verb'] == "POST" && request['Path'] == "/start_game"
      @game.start
      ["Good luck!", "HTTP/1.1 200 OK"]
    elsif request['Verb'] == "POST" && request['Path'].include?("/game")
      guess_num = request['Path'].partition('=').last.to_i
      [@game.guess(guess_num), "HTTP 1.1 302 FOUND\nLocation: http://127.0.0.1:9292/game"]
    else
      "404"
    end
  end

  def hello_world
    @hello_world += 1
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
