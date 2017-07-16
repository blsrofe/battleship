require './lib/board'
require './lib/ship'
require 'pry'
class Game


  def initialize
    @board = Board.new
  end

  def initial_instructions
    puts "Welcome to BATTLESHIP"
    puts ""
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    gets.chomp.downcase
  end

  def start_sequence(choice)
    if choice == "p" || choice == "play"
      board = Board.new
      comp_board, comp_destroyer, comp_sub = computer_ship_placement(board)
      player_board, player_destroyer, player_sub = player_ship_placement(board)
    elsif choice == "i" or choice == "input"
      puts give_instructions
      puts ""
      puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
      choice = gets.chomp.downcase
      start_sequence(choice)
    elsif choice == "q" or choice == "quit"
      puts "Thank you for playing."
    else
      puts "That is not a valid command."
      puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
      choice = gets.chomp.downcase
      start_sequence(choice)
    end
  end

  def give_instructions
    "You have two ships. You will be prompted to place your ships."
  end

  def computer_ship_placement(board)
    unoccupied_square = find_unoccupied_start_square(board)
    new_board, destroyer = place_computer_destroyer(unoccupied_square, board)
    unoccupied_square = find_unoccupied_start_square(new_board)
    choice, unoccupied_square = valid_sub_placement_identifier(unoccupied_square, new_board)
    final_setup_board, submarine = place_computer_sub(unoccupied_square, new_board, choice)
    return final_setup_board, destroyer, submarine
  end

  def player_ship_placement(board)
    coord = display_player_message
    des_coords = evaluate_coordinates(coord)
    split_coord_collection = des_coords.split(" ")
    new_board, destroyer = place_player_destroyer(split_coord_collection[0], board)
  end

  def evaluate_coordinates(coord)
    #make sure to return coordinates in correct form upcase
    coord
  end

  def find_unoccupied_start_square(comp_board)
    random_square = comp_board.layout.sample
    if random_square.values[0].occupied == false
      return random_square
    else
      find_unoccupied_start_square(comp_board)
    end
  end

  def display_player_message
    puts "    I have laid out my ships on the grid.
    You now need to layout your two ships.
    The first is two units long and the
    second is three units long.
    The grid has A1 at the top left and D4 at the bottom right.

    Enter the squares for the two-unit ship:"
    des_coord = gets.chomp
    des_coord
  end

  def valid_sub_placement_identifier(unoccupied_square, new_board)
    vertical = evaluate_vertical?(unoccupied_square, new_board)
    horizontal = evaluate_horizontal?(unoccupied_square, new_board)
    if vertical == true && horizontal == true
      choice = ["horizontal", "vertical"].sample
      return choice, unoccupied_square
    elsif vertical == true
      choice = "vertical"
      return choice, unoccupied_square
    elsif horizontal == true
      choice = "horizontal"
      return choice, unoccupied_square
    else
      unoccupied_square = find_unoccupied_start_square(new_board)
      valid_sub_placement_identifier(unoccupied_square, new_board)
    end
  end

  def evaluate_horizontal?(unoccupied_square, new_board)
    unoccupied_square_name = unoccupied_square.keys.join
    look_right_square = new_board.right_occupied?(unoccupied_square_name)
    look_left_square = new_board.left_occupied?(unoccupied_square_name)
    unoccupied_square_column = unoccupied_square.keys.join[1].to_i
    unoccupied_square_row = unoccupied_square.keys.join[0]
    left_square = go_left(unoccupied_square_column, unoccupied_square_row)
    right_square = go_right(unoccupied_square_column, unoccupied_square_row)
    look_two_squares_right = new_board.right_occupied?(right_square)
    look_two_squares_left = new_board.left_occupied?(left_square)
    if look_left_square && look_right_square
      false
    elsif look_left_square && look_two_squares_right
      false
    elsif look_right_square && look_two_squares_left
      false
    else
      true
    end
  end

  def evaluate_vertical?(unoccupied_square, new_board)
    unoccupied_square_name = unoccupied_square.keys.join
    look_above_square = new_board.above_occupied?(unoccupied_square_name)
    look_below_square = new_board.below_occupied?(unoccupied_square_name)
    unoccupied_square_column = unoccupied_square.keys.join[1].to_i
    unoccupied_square_row = unoccupied_square.keys.join[0]
    below_square = go_down(unoccupied_square_column, unoccupied_square_row)
    above_square = go_up(unoccupied_square_column, unoccupied_square_row)
    look_two_squares_above = new_board.above_occupied?(above_square)
    look_two_squares_below = new_board.below_occupied?(below_square)
    if look_below_square && look_above_square
      false
    elsif look_below_square && look_two_squares_above
      false
    elsif look_above_square && look_two_squares_below
      false
    else
      true
    end
  end

  def place_computer_destroyer(unoccupied_square, comp_board)
    choice = ["horizontal", "vertical"].sample
    unoccupied_square.values[0].occupied = true
    destroyer = Ship.new(unoccupied_square.keys.join)
    if choice == "horizontal"
      next_square, comp_board = place_ship_horizonally(unoccupied_square, comp_board)
      next_square.values[0].occupied = true
      destroyer.second_square = next_square.keys.join
      return comp_board, destroyer
    else
      next_square, comp_board = place_ship_vertically(unoccupied_square, comp_board)
      next_square.values[0].occupied = true
      destroyer.second_square = next_square.keys.join
      return comp_board, destroyer
    end
  end

  def place_computer_sub(unoccupied_square, comp_board, choice)
    unoccupied_square.values[0].occupied = true
    submarine = Ship.new(unoccupied_square.keys.join)
    if choice == "horizontal"
      next_square = place_ship_horizonally(unoccupied_square, comp_board)[0]
      next_square.values[0].occupied = true
      submarine.second_square = next_square.keys.join
      third_square = place_ship_horizonally(next_square, comp_board)[0]
      third_square.values[0].occupied = true
      submarine.third_square = third_square.keys.join
      return comp_board, submarine
    else
      next_square = place_ship_vertically(unoccupied_square, comp_board)[0]
      next_square.values[0].occupied = true
      submarine.second_square = next_square.keys.join
      third_square = place_ship_vertically(next_square, comp_board)[0]
      third_square.values[0].occupied = true
      submarine.third_square = third_square.keys.join
      return comp_board, submarine
    end
  end

  def place_ship_horizonally(unoccupied_square, comp_board)
    unoccupied_square_column = unoccupied_square.keys.join[1].to_i
    unoccupied_square_row = unoccupied_square.keys.join[0]
    unoccupied_square_name = unoccupied_square.keys.join
    if comp_board.left_occupied?(unoccupied_square_name) && comp_board.right_occupied?(unoccupied_square_name)
      place_ship_vertically(unoccupied_square, comp_board)
    elsif comp_board.left_occupied?(unoccupied_square_name)
      new_key = go_right(unoccupied_square_column, unoccupied_square_row)
      new_square = comp_board.find_square(new_key)
      return new_square, comp_board
    elsif comp_board.right_occupied?(unoccupied_square_name)
      new_key = go_left(unoccupied_square_column, unoccupied_square_row)
      new_square = comp_board.find_square(new_key)
      return new_square, comp_board
    else
        choice = ["left", "right"].sample
        if choice == "left"
          new_key = go_left(unoccupied_square_column, unoccupied_square_row)
          new_square = comp_board.find_square(new_key)
          return new_square, comp_board
        else
          new_key = go_right(unoccupied_square_column, unoccupied_square_row)
          new_square = comp_board.find_square(new_key)
          return new_square, comp_board
        end
    end
  end

  def go_left(unoccupied_square_column, unoccupied_square_row)
    new_key_column = (unoccupied_square_column - 1).to_s
    new_key = unoccupied_square_row += new_key_column
    new_key
  end

  def go_right(unoccupied_square_column, unoccupied_square_row)
    new_key_column = (unoccupied_square_column + 1).to_s
    new_key = unoccupied_square_row += new_key_column
    new_key
  end

  def go_up(unoccupied_square_column, unoccupied_square_row)
    if unoccupied_square_row == "D"
      new_key_row = "C"
    elsif unoccupied_square_row == "C"
      new_key_row = "B"
    elsif unoccupied_square_row == "B"
      new_key_row = "A"
    end
    new_key = new_key_row += unoccupied_square_column.to_s
    new_key
  end

  def go_down(unoccupied_square_column, unoccupied_square_row)
    if unoccupied_square_row == "A"
      new_key_row = "B"
    elsif unoccupied_square_row == "B"
      new_key_row = "C"
    elsif unoccupied_square_row == "C"
      new_key_row = "D"
    end
    new_key = new_key_row += unoccupied_square_column.to_s
    new_key
  end

  def place_ship_vertically(unoccupied_square, comp_board)
    unoccupied_square_column = unoccupied_square.keys.join[1].to_i
    unoccupied_square_row = unoccupied_square.keys.join[0]
    unoccupied_square_name = unoccupied_square.keys.join
    if comp_board.above_occupied?(unoccupied_square_name) && comp_board.below_occupied?(unoccupied_square_name)
      place_ship_horizonally(unoccupied_square, comp_board)
    elsif comp_board.below_occupied?(unoccupied_square_name)
      new_key = go_up(unoccupied_square_column, unoccupied_square_row)
      new_square = comp_board.find_square(new_key)
      return new_square, comp_board
    elsif comp_board.above_occupied?(unoccupied_square_name)
      new_key = go_down(unoccupied_square_column, unoccupied_square_row)
      new_square = comp_board.find_square(new_key)
      return new_square, comp_board
    else
        choice = ["up", "down"].sample
        if choice == "up"
          new_key = go_up(unoccupied_square_column, unoccupied_square_row)
          new_square = comp_board.find_square(new_key)
          return new_square, comp_board
        else
          new_key = go_down(unoccupied_square_column, unoccupied_square_row)
          new_square = comp_board.find_square(new_key)
          return new_square, comp_board
        end
    end
  end

end
