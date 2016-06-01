require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/parser'
require 'pry'

class ParserTest < Minitest::Test

  def setup
    @parser = Parser.new
  end

  def test_route_hello
    @parser.route("/hello")
    assert_equal ["http/1.1 200 ok\r\n\r\n", hello_world]
  end

  def test_route_datetime
    @parser.route("/datetime")
    assert @parser.route("/datetime").include?("date:")
  end

  def test_route_shutdown
    @parser.route("/shutdown")
    assert @parser.route("/shutdown").include?("Total requests:")
  end
end
