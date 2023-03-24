class BoardSquare
  attr_accessor :board_position, :adjacent_squares, :game_piece

  def initialize(row,column)
    @board_position = [row,column]
    @adjacent_squares = []
    @game_piece = nil
  end
end

class GameBoard
  def initialize()
    @board = build_board#determine_adjacent_squares
    @knight = Knight.new
  end

  def build_board()
    board = []
    for n in 0..7
      for i in 0..7
       board.push(BoardSquare.new(n,i))
      end
    end
    determine_adjacent_squares(board)
  end

  def determine_adjacent_squares(board)
    board.each do |board_square|
       board_square.adjacent_squares = first_and_last_rows_adjacent_squares(board_square.board_position) if board_square.board_position[0] == 0 || board_square.board_position[0] == 7
    end
    board
  end

  def board_corner_adjacent_squares(board_square)
   #Left corners
   return [0, 1], [1, 0], [1, 1] if board_square == [0, 0]
   return [7, 1], [6, 0], [7, 1] if board_square == [7, 0]
   #Right corners
   return [0, 6], [1, 6], [1, 7] if board_square == [0, 7]
   return [7, 6], [6, 6], [6, 7] if board_square == [7, 7] 
  end

  def first_and_last_rows_adjacent_squares(board_square)
    return board_corner_adjacent_squares(board_square) if board_square == [0, 0] || board_square == [7, 0] || board_square == [0, 7] || board_square == [7, 7]

  end

end

class Knight
  def move()
    #move two spaces and then one space to left, right, up, or down
  end

  def knight_moves(starting_square, destination_square)
    #shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.
  end
end

board = GameBoard.new

p board