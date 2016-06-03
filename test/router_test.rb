require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/router'
require 'pry'

class RouterTest < Minitest::Test
  attr_reader :router, :request

  def setup
    @router = Router.new
    @request = {}
  end

  def test_route_hello_returns_hello_world
    request = {'Path' => "/hello"}
    assert_equal "Hello, world! (1)", router.content(request)[0]
  end

  def test_route_datetime_returns_datetime
    request = {'Path' => "/datetime"}
    assert_equal "date: #{Time.now.strftime('%l:%m %p on %A, %B %e, %Y')}", router.content(request)[0]
  end

  def test_route_root_returns_nothing
    request = {'Path' => "/"}
    assert_equal "", router.content(request)[0]
  end

  def test_route_shutdown_returns_shutdown
    request = {'Path' => "/shutdown"}
    assert router.content(request)[0].include?"Total requests:"
  end

  def test_route_word_search_returns_results
    request = {'Path' => "/word_search?=face"}
    assert_equal "face is a known word", router.content(request)[0]
  end
end
