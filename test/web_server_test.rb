require 'faraday'
require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/web_server'
require 'pry'

class WebServerTest < Minitest::Test

  def test_it_can_get_home_page
    response = Faraday.get 'http://127.0.0.1:9292'
    assert response.body.include?("Verb: GET")
  end

  def test_hello_world_increments_with_each_request
    conn = Faraday.new(:url => 'http://127.0.0.1:9292/hello')
    response1 = conn.get
    assert_equal "(1)", response1.body.split[2]
    response2 = conn.get
    assert_equal "(2)", response2.body.split[2]
  end

  def test_it_can_get_word_search
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=game'
    assert response.body.include?("game is a known word")
  end

  def test_it_can_start_the_game
    response = Faraday.post 'http://127.0.0.1:9292/start_game'
    assert response.body.include?("Verb: POST")
  end
end
