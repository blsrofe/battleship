require './lib/board'
require './lib/ship'
require './lib/authentication'

class Human

  include Authentication

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

  def player_ship_placement
    coord = display_player_message
    des_coords = evaluate_coordinates_form(coord)
    final_des_coords = evaluate_coordinates_proximity(des_coords)
    split_coord_collection = final_des_coords.split(" ")
    make_player_destroyer(split_coord_collection)
    coords = get_sub_coordinates
    sub_coords = evaluate_sub_coordinates_form(coords)
    final_sub_coords = evaluate_sub_coordinates_proximity(sub_coords)
    split_sub_collection = final_sub_coords.split(" ")
    make_player_sub(split_sub_collection)
  end

  def display_player_message
    puts "    I have laid out my ships on the grid.
    You now need to layout your two ships.
    The first is two units long and the
    second is three units long.
    The grid has A1 at the top left and D4 at the bottom right.

    Enter the squares for the two-unit ship:"
    coord = gets.chomp
    coord
  end
  
  def place_player_ship(coord_collection)
    coord_collection.each do |coord|
      square = @board.find_square(coord)
      square.values[0].occupied = true
    end
  end

  def make_player_destroyer(coord_collection)
    place_player_ship(coord_collection)
    @destroyer = Ship.new(2, [coord_collection[0], coord_collection[1]])
  end

  def get_sub_coordinates
    puts "What are the coordinates for your submarine?"
    sub_coor = gets.chomp
    sub_coor
  end

  def make_player_sub(split_sub_collection)
    place_player_ship(split_sub_collection)
    @submarine = Ship.new(3, [split_sub_collection[0], split_sub_collection[1], split_sub_collection[2]])
  end

end
