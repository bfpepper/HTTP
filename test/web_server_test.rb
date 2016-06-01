require 'faraday'
require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/web_server'
require 'pry'

class WebServerTest < Minitest::Test

  def test_it_can_get_home_page

    response = Faraday.get 'http://127.0.0.1:9292'
    assert response.body.include?("\"Verb\"=>\"GET\"")
  end

  def test_it_can_get_hello_world
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert response.body.include?("Hello, world!")
  end


  def test_hello_world_increments_with_each_request
    conn = Faraday.new(:url => 'http://127.0.0.1:9292/hello')
    response1 = conn.get
    first = response1.body[-3].to_i
    response2 = conn.get
    second = response2.body[-3].to_i
    assert_equal 1, second - first
  end

end
