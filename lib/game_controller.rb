require './lib/router'

class GameController

  def initialize
    @start = false
  end

  def start
    @start = true
    win_num = rand(0..100)
  end
end
