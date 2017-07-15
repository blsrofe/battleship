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
    place_computer_ship(unoccupied_square, comp_board)
  end

  def find_unoccupied_start_square(comp_board)
    random_square = comp_board.layout.sample
    if random_square.values[0].occupied == false
      return random_square
    else
      find_unoccupied_start_square(comp_board)
    end
  end

  def place_computer_ship(unoccupied_square, comp_board)
    binding.pry
    choice = ["horizontal", "vertical"].sample
    unoccupied_square.values[0].occupied = true
    # start_square_name = unoccupied_square.keys.join#returns string
    if choice = "horizontal"
      place_ship_horizonally(unoccupied_square, comp_board)
    else
      place_ship_vertically(unoccupied_square, comp_board)
    end
  end

  def place_ship_horizonally(unoccupied_square, comp_board)
    unoccupied_square_column = unoccupied_square.keys.join[1].to_i
    unoccupied_square_row = unoccupied_square.keys.join[0]
    choice = ["left", "right"].sample
    if unoccupied_square_column == 4
      new_key = go_left(unoccupied_square_column, unoccupied_square_row)
      comp_board.find_square(new_key)
      
    elsif unoccupied_square_column == 1
      go_right(unoccupied_square_column, unoccupied_square_row)
    elsif choice == "left"
      go_left(unoccupied_square_column, unoccupied_square_row)
    elsif choice == "right"
      go_right(unoccupied_square_column, unoccupied_square_row)
    end
  end

  def go_left(unoccupied_square_column, unoccupied_square_row)
    new_key_column = (unoccupied_square_column - 1).to_s
    new_key = unoccupied_square_row += new_key_column
    new_key
  end

  def place_ship_vertically(unoccupied_square, comp_board)
    puts "put ship vertical"
  end

end
