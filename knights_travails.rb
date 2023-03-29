# frozen_string_literal: true

class BoardSquare
  attr_accessor :board_position, :adjacent_squares, :game_piece

  def initialize(row, column)
    @board_position = [row, column]
    @adjacent_squares = []
    @game_piece = nil
  end
end

class GameBoard
  attr_accessor :board, :knight

  def initialize
    @board = build_board
    @knight = Knight.new
  end

  def build_board
    board = []
    8.times do |n|
      8.times do |i|
        board.push(BoardSquare.new(n, i))
      end
    end
    determine_adjacent_squares(board)
  end

  def determine_adjacent_squares(board)
    board.each do |board_square|
      board_square.adjacent_squares = if board_square.board_position[0].zero? || board_square.board_position[0] == 7
                                        first_and_last_rows_adjacent_squares(board_square.board_position)
                                      else
                                        middle_rows_adjacent_squares(board_square.board_position)
                                      end
    end
    board
  end

  def adjacent_square_array_builder(board_square, adjacent_square_positions, adjacent_squares)
    adjacent_square_positions.each do |square|
      adjacent_square = [board_square[0] + square[0], board_square[1] + square[1]]
      adjacent_squares.push(adjacent_square)
    end
  end

  def board_corner_adjacent_squares(board_square)
    # Left corners
    return [0, 1], [1, 0], [1, 1] if board_square == [0, 0]
    return [7, 1], [6, 0], [6, 1] if board_square == [7, 0]
    # Right corners
    return [0, 6], [1, 6], [1, 7] if board_square == [0, 7]
    return [7, 6], [6, 6], [6, 7] if board_square == [7, 7]
  end

  def first_and_last_rows_adjacent_squares(board_square, adjacent_squares = [])
    return board_corner_adjacent_squares(board_square) if [[0, 0], [7, 0], [0, 7], [7, 7]].include?(board_square)

    adjacent_square_positions = [[0, -1], [+1, -1], [+1, 0], [+1, +1], [0, +1]]
    adjacent_square_array_builder(board_square, adjacent_square_positions, adjacent_squares)
    adjacent_squares
  end

  def middle_rows_edge_squares(board_square)
    return middle_rows_edge_first_row(board_square) if (board_square[1]).zero?
    return middle_rows_edge_last_row(board_square) if board_square[1] == 7
  end

  def middle_rows_edge_first_row(board_square, adjacent_squares = [])
    adjacent_square_positions = [[-1, 0], [-1, +1], [0, +1], [+1, +1], [+1, 0]]
    adjacent_square_array_builder(board_square, adjacent_square_positions, adjacent_squares)
    adjacent_squares
  end

  def middle_rows_edge_last_row(board_square, adjacent_squares = [])
    adjacent_square_positions = [[-1, -1], [0, -1], [+1, -1], [+1, 0], [-1, 0]]
    adjacent_square_array_builder(board_square, adjacent_square_positions, adjacent_squares)
    adjacent_squares
  end

  def middle_rows_adjacent_squares(board_square, adjacent_squares = [])
    return middle_rows_edge_squares(board_square) if (board_square[1]).zero? || board_square[1] == 7

    adjacent_square_positions = [[-1, -1], [0, -1], [1, -1],
                                 [1, 0],
                                 [1, 1], [0, 1], [-1, 1],
                                 [-1, 0]]
    adjacent_square_array_builder(board_square, adjacent_square_positions, adjacent_squares)
    adjacent_squares
  end
end

class Knight
  def moves_from_one_position(starting_square, possible_move_positions = [])
    # move two spaces and then one space to left, right, up, or down
   # return if board_position[0].negative? || board_position[1].negative? || board_position[0] > 7 || board_position[1] > 7
   possible_moves = [[-2,-1], [-2,+1], [+2,-1], [+2,+1], [+1,-2], [-1,-2], [+1,+2], [-1,+2]]
   # down/left  -2,-1
   # down/right -2,+1
   possible_moves.each do |move|
    possible_move_positions.push([starting_square[0] + move[0], starting_square[1] + move[1]])
  end
   # up/left +2,-1
   # up/right +2,+1
   
   # left/up +1,-2
   # left/down -1,-2   

   # right/up +1,+2
   # right/down -1,+2
   

   #p board.board[0].game_piece = board.knight
   possible_move_positions
  end

  def all_possible_moves(board)

     # down/left  -2,-1
     # down/right -2,+1

    # up/left +2,-1
    # up/right +2,+1
   
    # left/up +1,-2
    # left/down -1,-2   

    # right/up +1,+2
    # right/down -1,+2
   

   # Do I need to build a tree using recursion that shows the above options?
    all_possible_moves
  end

  def knight_moves(starting_square, destination_square)
    # shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.
  end
end

board = GameBoard.new

p board.knight.moves_from_one_position([4,4])

#p board