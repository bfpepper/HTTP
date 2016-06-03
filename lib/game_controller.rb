require './lib/router'

class GameController

  def initialize
    @start = false
    @guess_counter = 0
  end

  def start
    @start = true
    @win_num = rand(0..100)
  end

  def guess(guess_num)
    @guess_counter += 1
    if guess_num > @win_num
      return "your guess of #{guess_num} was too high. you've guessed #{@guess_counter} time(s)."
    elsif guess_num < @win_num
      return "your guess of #{guess_num} was too low. you've guessed #{@guess_counter} time(s)."
    elsif guess_num == @win_num
      return "your guess of #{guess_num} was just right! you guessed #{@guess_counter} time(s)."
    end
  end
end
