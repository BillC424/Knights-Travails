class BoardSquare
  def initialize(row,column)
    @board_position = [row,column]
    @game_piece = nil
  end
end

class GameBoard
  def initialize()
    @board = build_board()
    @knight = Knight.new
  end

  def build_board()
    board = []
    for n in 0..7
      for i in 0..7
       board.push(BoardSquare.new(n,i))
      end
    end
    board
  end

  def knight_moves(starting_square, destination_square)
  
  end

end

class Knight
  def move()
    #move two spaces and then one space to left or right
  end
end

board = GameBoard.new

p board

