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

  def place_ship_horizonally(empty_square)
    empty_square_column = empty_square.keys.join[1].to_i
    empty_square_row = empty_square.keys.join[0]
    empty_square_name = empty_square.keys.join
    if @board.left_occupied?(empty_square_name) && @board.right_occupied?(empty_square_name)
      place_ship_vertically(empty_square)
    elsif @board.left_occupied?(empty_square_name)
      new_square = go_right(empty_square_column, empty_square_row)
      new_square
    elsif @board.right_occupied?(empty_square_name)
      new_square = go_left(empty_square_column, empty_square_row)
      new_square
    else
        choice = ["left", "right"].sample
        if choice == "left"
          new_square = go_left(empty_square_column, empty_square_row)
          new_square
        else
          new_square = go_right(empty_square_column, empty_square_row)
          new_square
        end
    end
  end

  def place_ship_vertically(empty_square)
    empty_square_column = empty_square.keys.join[1].to_i
    empty_square_row = empty_square.keys.join[0]
    empty_square_name = empty_square.keys.join
    if @board.above_occupied?(empty_square_name) && @board.below_occupied?(empty_square_name)
      place_ship_horizonally(empty_square)
    elsif @board.below_occupied?(empty_square_name)
      new_square = go_up(empty_square_column, empty_square_row)
      new_square
    elsif @board.above_occupied?(empty_square_name)
      new_square = go_down(empty_square_column, empty_square_row)
      new_square
    else
        choice = ["up", "down"].sample
        if choice == "up"
          new_square = go_up(empty_square_column, empty_square_row)
          new_square
        else
          new_square = go_down(empty_square_column, empty_square_row)
          new_square
        end
    end
  end

  def go_up(empty_square_column, empty_square_row)
    if empty_square_row == "D"
      new_key_row = "C"
    elsif empty_square_row == "C"
      new_key_row = "B"
    elsif empty_square_row == "B"
      new_key_row = "A"
    end
    new_key = new_key_row += empty_square_column.to_s
    new_square = @board.find_square(new_key)
    new_square
  end

  def go_down(empty_square_column, empty_square_row)
    if empty_square_row == "A"
      new_key_row = "B"
    elsif empty_square_row == "B"
      new_key_row = "C"
    elsif empty_square_row == "C"
      new_key_row = "D"
    end
    new_key = new_key_row += empty_square_column.to_s
    new_square = @board.find_square(new_key)
    new_square
  end

  def go_left(empty_square_column, empty_square_row)
    new_key_column = (empty_square_column - 1).to_s
    new_key = empty_square_row += new_key_column
    new_square = @board.find_square(new_key)
    new_square
  end

  def go_right(empty_square_column, empty_square_row)
    new_key_column = (empty_square_column + 1).to_s
    new_key = empty_square_row += new_key_column
    new_square = @board.find_square(new_key)
    new_square
  end
end
