require 'faraday'
require 'minitest/autorun'
require 'minitest/nyan_cat'
require 'pry'

class ServerTest < Minitest::Test

  def test_it_can_get_home_page
    conn = Faraday.new(:url => 'http://127.0.0.1:9292')
    response = conn.get
    response.body
    assert response.body.include?("\"Verb\"=>\"GET\"")
  end

  def test_it_can_get_hello_world
    conn = Faraday.new(:url => 'http://127.0.0.1:9292/hello')
    response = conn.get
    response.body
    assert response.body.include?("Hello, world!")
  end


  def test_hello_world_increments_with_each_request
    conn = Faraday.new(:url => 'http://127.0.0.1:9292/hello')
    response1 = conn.get
    first = response1.body[-3].to_i
    # binding.pry
    response2 = conn.get
    second = response2.body[-3].to_i# => "Hello, world! (9)"
    assert_equal 1, second - first
  end

end
