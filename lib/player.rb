require './lib/board'
require './lib/ship'
require './lib/computer'
require './lib/human'
class Player

  include Computer
  include Human

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

end
