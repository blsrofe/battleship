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
    random_square = find_random_start_square(comp_board)
    check_square = check_if_square_is_empty(random_square)
  end

  def find_random_start_square(comp_board)
    comp_board.layout.sample#returns one hash from layout
  end

  def check_if_square_is_empty(random_square)
    random_square.value
  end

end
