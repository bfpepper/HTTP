require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/router'
require 'pry'

class RouterTest < Minitest::Test

  def setup
    @router = Router.new
    @request = {}
  end

  def test_route_hello
    @request = {'Path' => "/hello"}
    assert @router.response(@request).include?("http/1.1 200 ok\r\n\r\n")
  end

  def test_route_datetime
    @request = {'Path' => "/datetime"}
    assert @router.response(@request).include?("date:")
  end

  def test_route_root
    @request = {'Path' => "/"}
    assert @router.response(@request).include?("<html><head></head><body><pre>\n{\"Path\"=>\"/\"}</pre></body></html>")
  end

  def test_route_shutdown
    @request = {'Path' => "/shutdown"}
    assert @router.response(@request).include?("Total requests:")
  end
end
