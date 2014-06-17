require 'minitest/autorun'

require '../lib/game'

class TestGame < Minitest::Test
  def setup
    @game = Game.new(1)
  end

  def test_new_game
    assert_equal 0, @game.at(1, 1)
    assert @game.empty?
    assert_equal 9, @game.empty_cells.size
  end

  def test_save
    @game.place(1, 1)
    @game.place(0, 0)
    @game.place(1, 2)
    @game.place(0, 1)

    assert_equal "O|XX--OO---", @game.save
  end

  def test_show
    @game.place(1, 1)
    @game.place(0, 0)

    assert_equal 'O', @game.show_at(1,1)
    assert_equal '-', @game.show_at(1,0)
    assert_equal 'X', @game.show_at(0,0)
  end

  def test_load
    @game.place(1, 1)
    @game.place(0, 0)
    @game.place(1, 2)
    @game.place(0, 1)

    assert_equal "O|XX--OO---", @game.save

    game2 = Game.load("O|XX--OO---")

    assert_equal 1, game2.next
    assert_equal 1, game2.at(1,1)
    assert_equal -1, game2.at(0,0)
    assert_equal 1, game2.at(1,2)
    assert_equal -1, game2.at(0,1)

  end

  def test_add_piece
    @game.place(1, 1)
    assert_equal 1, @game.at(1, 1)
    assert_equal 8, @game.empty_cells.size
  end

  def test_cannot_add_if_taken
    @game.place(1, 1)
    exception = assert_raises(RuntimeError) { @game.place(1, 1) }
    assert_match /taken/, exception.message
  end

  def test_cannot_add_if_other_turn
    exception = assert_raises(RuntimeError) { @game.place(1, 1, -1) }
    assert_match /turn/, exception.message
  end

  def test_cannot_add_if_out_of_grid
    exception = assert_raises(RuntimeError) { @game.place(3, 1) }
    assert_equal "Out of board", exception.message
  end

  def test_win
    @game.place(1, 1)
    @game.place(0, 0)
    @game.place(1, 2)
    @game.place(0, 1)

    assert_equal false, @game.finish?
    assert_equal 0, @game.winner

    @game.place(1, 0)

    assert_equal true, @game.finish?
    assert_equal 1, @game.winner
    assert_equal 4, @game.empty_cells.size
  end

  def test_cannot_play_if_finished
    @game.place(1, 1)
    @game.place(0, 0)
    @game.place(1, 2)
    @game.place(0, 1)

    assert_equal false, @game.finish?
    
    @game.place(1, 0)

    assert_equal true, @game.finish?

    assert_raises(RuntimeError) { @game.place(2, 2) }
  end
end