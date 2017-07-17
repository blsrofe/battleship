require './lib/board'
require './lib/ship'
require './lib/player'
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
      comp = Player.new
      player = Player.new
      comp_board, comp_destroyer, comp_sub = comp.computer_ship_placement
      # comp_board, comp_destroyer, comp_sub = computer_ship_placement(board)
      # player_board, player_destroyer, player_sub = player_ship_placement(board)
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

  def player_ship_placement(board)
    coord = display_player_message
    des_coords = evaluate_coordinates(coord)
    split_coord_collection = des_coords.split(" ")
    new_board, destroyer_p = place_player_destroyer(split_coord_collection, board)
    coords = get_sub_coordinates
    sub_coords = evaluate_coordinates(sub_coords)
    split_sub_collection = sub_coords.split(" ")
    final_play_board, sub_p = place_player_sub(split_sub_collection, new_board)
  end

  def evaluate_coordinates(coord)
    #make sure to return coordinates in correct form upcase
    #should have a length of five
    #string[0] and [2] should be letter between and d
    #string[1] and [3] should be numbers between 1-4
    #second squre must be adjacent to first square
    #should work for sub coords too
    coord
  end

  def place_player_destroyer(coord_collection, board)
    coord_collection.each do |coord|
      square = board.find_square(coord)
      square.values[0].occupied = true
    end
    destroyer_p = Ship.new(coord_collection[0], coord_collection[1])
    return board, destroyer_p
  end

  def get_sub_coordinates
    puts "What are the coordinates for your submarine?"
    sub_coor = gets.chomp
    sub_coords
  end

  def place_player_sub(split_sub_collection, new_board)
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

end
