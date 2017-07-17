require './lib/board'
require './lib/ship'
class Player

  attr_accessor :board

  def initialize(board = Board.new)
    @board = board
  end

  def computer_ship_placement#how do I test this?
    empty_square = find_empty_square
    destroyer = place_computer_destroyer(empty_square)
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

  def place_computer_destroyer(empty_square)#write test for this
    choice = ["horizontal", "vertical"].sample
    empty_square.values[0].occupied = true
    destroyer = Ship.new(empty_square.keys.join)
    if choice == "horizontal"
      next_square = place_ship_horizonally(empty_square)
      next_square.values[0].occupied = true
      destroyer.second_square = next_square.keys.join
      return destroyer
    else
      next_square = place_ship_vertically(empty_square)
      next_square.values[0].occupied = true
      destroyer.second_square = next_square.keys.join
      return destroyer
    end
  end

end
