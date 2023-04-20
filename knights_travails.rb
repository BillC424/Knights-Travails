# frozen_string_literal: true

class Node
  attr_accessor :previous_square
  attr_reader :board_position, :subsequent_position

  def initialize(board_position)
    @board_position = board_position
    @subsequent_position = []
    @previous_square = @previous_square
  end

  def add_edge(subsequent_position)
    @subsequent_position << subsequent_position
  end
end

class AdjacencyList
  attr_reader :nodes

  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node] = Node.new(node)
  end

  def add_edge(predecessor_position, successor_position)
    @nodes[predecessor_position].add_edge(successor_position)
  end

  def [](name)
    @nodes[name]
  end
end

class Knight
  attr_reader :all_possible_moves_adjacency_list

  def initialize
    @all_possible_moves_adjacency_list = nil
  end

  def moves_from_one_position(starting_square)
    possible_moves = [[-2, -1], [-2, +1], [+2, -1], [+2, +1], [+1, -2], [-1, -2], [+1, +2], [-1, +2]]
    possible_moves.each do |move|
      possible_move = [starting_square[0] + move[0], starting_square[1] + move[1]]

      next if possible_move.any?(&:negative?) || possible_move.any? do |column_or_row_spot|
                column_or_row_spot > 7
              end

      @all_possible_moves_adjacency_list.add_edge(starting_square,
                                                  possible_move)
    end
  end

  def all_possible_moves(starting_square, previous_squares = [])
    return if previous_squares.any? { |square| square == starting_square } || previous_squares.length == 64

    @all_possible_moves_adjacency_list = AdjacencyList.new if previous_squares.empty?
    @all_possible_moves_adjacency_list.add_node(starting_square)
    previous_squares << starting_square
    moves_from_one_position(@all_possible_moves_adjacency_list[starting_square].board_position)

    @all_possible_moves_adjacency_list[starting_square].subsequent_position.each do |possible_move|
      all_possible_moves(possible_move, previous_squares)
    end
  end

  def print_knight_moves_path(starting_square, destination_square, previous_squares, moves)
    p "You made it in #{moves} moves! Here's your path:"
    previous_squares << destination_square
    starting_square = previous_squares[0]
    path = knight_moves_path_array_builder(starting_square, destination_square, moves)

    path.each { |move| p move }
  end

  def knight_moves_path_array_builder(starting_square, destination_square, moves, path = [])
    return path.reverse if path.size == moves + 1

    path << destination_square if path == []
    path << @all_possible_moves_adjacency_list[destination_square].previous_square
    knight_moves_path_array_builder(starting_square,
                                    @all_possible_moves_adjacency_list[destination_square].previous_square, moves, path)
  end

  def knight_moves(starting_square, destination_square, queue = [], previous_squares = [], moves = 0)
    all_possible_moves(starting_square)
    queue << starting_square
    while queue.empty? == false

      level_size = queue.size

      level_size.times do
        starting_square = queue[0]
        if starting_square == destination_square
          return print_knight_moves_path(starting_square, destination_square, previous_squares,
                                         moves)
        end

        unless previous_squares.any? { |square| square == starting_square }
          @all_possible_moves_adjacency_list[starting_square].subsequent_position.each do |move|
            queue << move
            if @all_possible_moves_adjacency_list[move].previous_square.nil?
              @all_possible_moves_adjacency_list[move].previous_square = starting_square
            end
          end
        end
        previous_squares << starting_square
        queue.shift
      end
      moves += 1
    end
  end
end

knight = Knight.new

knight.knight_moves([3, 3], [2, 3])
