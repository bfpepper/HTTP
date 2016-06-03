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

  def test_guess_is_too_high
    game = GameController.new
    game.start
    assert_equal "your guess of 100 was too high. you've guessed 1 time(s).", game.guess(100)
  end

  def test_guess_is_too_low
    game = GameController.new
    game.start
    assert_equal "your guess of 0 was too low. you've guessed 1 time(s).", game.guess(0)
  end
end
