class Game
  LINES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  
  def initialize(next_player)
    @grid = [[0,0,0],[0,0,0],[0,0,0]]
    @next = next_player
  end

  def empty?
    empty_cells.size == 9
  end

  def toggle_next
    @next *= -1
  end

  def next
    @next
  end

  def board
    @grid
  end

  def empty_cells
    cells = []
    (0..2).each do |x|
      (0..2).each do |y|
        cells << [x,y] if @grid[x][y] == 0
      end
    end

    cells
  end
  
  def at(x, y)
    @grid[x][y]
  end

  def winner
    return 0 unless finish?
    @next * -1
  end

  def finish?
    LINES.each do |x|
      return true if (@grid.flatten[x[0]] + @grid.flatten[x[1]] + @grid.flatten[x[2]]).abs == 3
    end
    false
  end

  def place(x, y, value = @next)
    raise "Finished" if finish?
    raise "Out of board" unless [0, 1, 2].include?(x) && [0, 1, 2].include?(y)
    raise "Not your turn" if value != @next
    raise "Cannot play at #{x},#{y} - already taken" unless @grid[x][y] == 0
    
    @grid[x][y] = value
    toggle_next
  end
end