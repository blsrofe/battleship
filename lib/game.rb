require './lib/board'
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
      comp_board = Board.new
      computer_ship_placement(comp_board)
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

  def computer_ship_placement(comp_board)
    unoccupied_square = find_unoccupied_start_square(comp_board)
    new_board = place_computer_destroyer(unoccupied_square, comp_board)
    unoccupied_square = find_unoccupied_start_square(new_board)
    choice, unoccupied_square = valid_sub_placement_identifier(unoccupied_square, new_board)
    final_setup_board = place_computer_sub(unoccupied_square, new_board, choice)
    final_setup_board
  end

  def find_unoccupied_start_square(comp_board)
    random_square = comp_board.layout.sample
    if random_square.values[0].occupied == false
      return random_square
    else
      find_unoccupied_start_square(comp_board)
    end
  end

  def valid_sub_placement_identifier(unoccupied_square, new_board)
    evalutate_vertical(unoccupied_square, new_board)
    evaluate_horizontal(unoccupied_square, new_board)
    if evalutate_vertical == true && evaluate_horizontal == true
      choice = ["horizontal", "vertical"].sample
      return choice, unoccupied_square
    elsif evalutate_vertical == true
      choice = "vertical"
      return choice, unoccupied_square
    elsif evaluate_horizontal == true
      choice = "horizontal"
      return choice, unoccupied_square
    else
      unoccupied_square = find_unoccupied_start_square(new_board)
      valid_sub_placement_identifier(unoccupied_square, new_board)
    end
  end

  def evaluate_horizontal(unoccupied_square, new_board)
  end

  def evalutate_vertical(unoccupied_square, new_board)
  end

  def place_computer_destroyer(unoccupied_square, comp_board)
    choice = ["horizontal", "vertical"].sample
    unoccupied_square.values[0].occupied = true
    if choice == "horizontal"
      next_square, comp_board = place_ship_horizonally(unoccupied_square, comp_board)
      next_square.values[0].occupied = true
      comp_board
    else
      next_square, comp_board = place_ship_vertically(unoccupied_square, comp_board)
      next_square.values[0].occupied = true
      comp_board
    end
  end

  def place_computer_sub(unoccupied_square, comp_board)#make sure this returns final_setup_board
    choice = ["horizontal", "vertical"].sample
    unoccupied_square.values[0].occupied = true
    if choice == "horizontal"
      next_square = place_ship_horizonally(unoccupied_square, comp_board)
      next_square.values[0].occupied = true
      third_square = place_ship_horizonally(next_square, comp_board)
    else
      next_square = place_ship_vertically(unoccupied_square, comp_board)
      next_square.values[0].occupied = true
      return next_square, choice
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
