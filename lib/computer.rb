require './lib/board'
require './lib/ship'

class Computer

  attr_accessor :board,
                :destroyer,
                :submarine,
                :shots

  def initialize(board = Board.new, destroyer = nil, submarine = nil, shots = [])
    @board = board
    @destroyer = destroyer
    @submarine = submarine
    @shots = shots
  end

  def computer_ship_placement
    place_computer_destroyer
    choice, empty_square = valid_sub_placement_identifier
    place_computer_sub(choice, empty_square)
  end


  def place_computer_destroyer
    empty_square = find_empty_square
    choice = ["horizontal", "vertical"].sample
    empty_square.values[0].occupied = true
    @destroyer = Ship.new(2, [empty_square.keys.join])
    if choice == "horizontal"
      next_square = place_ship_horizonally(empty_square)
      next_square.values[0].occupied = true
      @destroyer.coordinates << next_square.keys.join
    else
      next_square = place_ship_vertically(empty_square)
      next_square.values[0].occupied = true
      @destroyer.coordinates << next_square.keys.join
    end
  end

  def find_empty_square
    random_square = @board.layout.sample
    if random_square.values[0].occupied == false
      return random_square
    else
      find_empty_square
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
      new_square = left_or_right(empty_square_column, empty_square_row)
      new_square
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
      new_square = up_or_down(empty_square_column, empty_square_row)
      new_square
    end
  end

  def up_or_down(empty_square_column, empty_square_row)
    choice = ["up", "down"].sample
    if choice == "up"
      new_square = go_up(empty_square_column, empty_square_row)
      new_square
    else
      new_square = go_down(empty_square_column, empty_square_row)
      new_square
    end
  end

  def left_or_right(empty_square_column, empty_square_row)
    choice = ["left", "right"].sample
    if choice == "left"
      new_square = go_left(empty_square_column, empty_square_row)
      new_square
    else
      new_square = go_right(empty_square_column, empty_square_row)
      new_square
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

  def valid_sub_placement_identifier
    empty_square = find_empty_square
    vertical = evaluate_vertical?(empty_square)
    horizontal = evaluate_horizontal?(empty_square)
    if vertical == true && horizontal == true
      choice = ["horizontal", "vertical"].sample
      return choice, empty_square
    elsif vertical == true
      choice = "vertical"
      return choice, empty_square
    elsif horizontal == true
      choice = "horizontal"
      return choice, empty_square
    else
      valid_sub_placement_identifier
    end
  end

  def evaluate_horizontal?(empty_square)
    empty_square_name = empty_square.keys.join
    look_right_square = @board.right_occupied?(empty_square_name)
    look_left_square = @board.left_occupied?(empty_square_name)
    empty_square_column = empty_square.keys.join[1].to_i
    empty_square_row = empty_square.keys.join[0]
    if look_left_square && look_right_square
      false
    elsif look_left_square
      right_square = go_right(empty_square_column, empty_square_row)
      look_two_squares_right = @board.right_occupied?(right_square.keys.join)
      if look_two_squares_right
        false
      else
        true
      end
    elsif look_right_square
      left_square = go_left(empty_square_column, empty_square_row)
      look_two_squares_left = @board.left_occupied?(left_square.keys.join)
      if look_two_squares_right
        false
      else
        true
      end
    else
      left_square = go_left(empty_square_column, empty_square_row)
      look_two_squares_left = @board.left_occupied?(left_square.keys.join)
      right_square = go_right(empty_square_column, empty_square_row)
      look_two_squares_right = @board.right_occupied?(right_square.keys.join)
      if look_two_squares_right && look_two_squares_left
        false
      else
        true
      end
    end
  end

  def evaluate_vertical?(empty_square)
    empty_square_name = empty_square.keys.join
    look_above_square = @board.above_occupied?(empty_square_name)
    look_below_square = @board.below_occupied?(empty_square_name)
    empty_square_column = empty_square.keys.join[1].to_i
    empty_square_row = empty_square.keys.join[0]
    if look_below_square && look_above_square
      false
    elsif look_below_square
      above_square = go_up(empty_square_column, empty_square_row)
      look_two_squares_above = @board.above_occupied?(above_square.keys.join)
      if look_two_squares_above
        false
      else
        true
      end
    elsif look_above_square
      below_square = go_down(empty_square_column, empty_square_row)
      look_two_squares_below = @board.below_occupied?(below_square.keys.join)
      if look_two_squares_below
        false
      else
        true
      end
    else
      below_square = go_down(empty_square_column, empty_square_row)
      look_two_squares_below = @board.below_occupied?(below_square.keys.join)
      above_square = go_up(empty_square_column, empty_square_row)
      look_two_squares_above = @board.above_occupied?(above_square.keys.join)
      if look_two_squares_above && look_two_squares_below
        false
      else
        true
      end
    end
  end

  def place_computer_sub(choice, empty_square)#test this
    empty_square.values[0].occupied = true
    @submarine = Ship.new(3, [empty_square.keys.join])
    if choice == "horizontal"
      next_square = place_ship_horizonally(empty_square)
      next_square.values[0].occupied = true
      @submarine.coordinates << next_square.keys.join
      third_square = place_ship_horizonally(next_square)
      third_square.values[0].occupied = true
      @submarine.coordinates << third_square.keys.join
    else
      next_square = place_ship_vertically(empty_square)
      next_square.values[0].occupied = true
      @submarine.coordinates << next_square.keys.join
      third_square = place_ship_vertically(next_square)
      third_square.values[0].occupied = true
      @submarine.coordinates << third_square.keys.join
    end
  end

end
