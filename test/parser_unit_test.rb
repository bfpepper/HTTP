require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/parser'
require 'pry'

class ParserTest < Minitest::Test

  def setup
    @parser = Parser.new
    @request = {}
  end

  def test_route_hello
    @request = {'Path' => "/hello"}
    assert @parser.route(@request).include?("http/1.1 200 ok\r\n\r\n")
  end

  def test_route_datetime
    @request = {'Path' => "/datetime"}
    assert @parser.route(@request).include?("date:")
  end

  def test_route_root
    @request = {'Path' => "/"}
    assert @parser.route(@request).include?("<html><head></head><body><pre>\n{\"Path\"=>\"/\"}</pre></body></html>")
  end

  def test_route_shutdown
    @request = {'Path' => "/shutdown"}
    assert @parser.route(@request).include?("Total requests:")
  end
end
