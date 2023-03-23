class BoardSquare
  def initialize()
    @game_piece = nil
  end
end

class GameBoard
  def initialize()
    @board = build_board()
    @knight = Knight.new
  end

  def build_board()
    [#BoardSquare.new 16 times (8 rows and 8 columns)]
  end

  def knight_moves(starting_square, destination_square)
  
  end


end

class Knight
  def move()
    #move two spaces and then one space to left or right
  end
end