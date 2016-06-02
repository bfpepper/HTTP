require 'faraday'
require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/game_controller'
require 'pry'

class GameControllerTest < Minitest::Test

  def test_it_can_start_game

    response = Faraday.post 'http://127.0.0.1:9292/start_game'
    assert response.body.include?("Good luck!")
  end

end
