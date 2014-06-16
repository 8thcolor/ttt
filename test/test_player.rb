require 'minitest/autorun'

require '../lib/game'
require '../lib/player'

class TestPlayer < Minitest::Test
  def setup
    @game = Game.new(1)
    @player = Player.new(@game, 1)
  end

  def test_my_turn
    assert_equal true, @player.my_turn?
  end

  def test_play_center_empty
    @player.play
    assert_equal 1, @game.at(1, 1)
    assert_equal false, @player.my_turn?
  end

  def test_play
    @game.place(1, 1)
    @game.place(0, 1)
    
    @player.play

    assert_equal 6, @game.empty_cells.size
  end
end