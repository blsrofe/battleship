require './lib/board'
class Player

  attr_accessor :board

  def initialize(board = Board.new)
    @board = board
  end

  def computer_ship_placement#how do I test this?
    empty_square = find_empty_square
    new_board, destroyer = place_computer_destroyer(unoccupied_square, board)
    unoccupied_square = find_unoccupied_start_square(new_board)
    choice, unoccupied_square = valid_sub_placement_identifier(unoccupied_square, new_board)
    final_setup_board, submarine = place_computer_sub(unoccupied_square, new_board, choice)
    return final_setup_board, destroyer, submarine
  end

  def find_empty_square
    random_square = @board.layout.sample
    if random_square.values[0].occupied == false
      return random_square
    else
      find_empty_square
    end
  end

end
