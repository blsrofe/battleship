require './test/test_helper.rb'
require './lib/player'

class PlayerTest < Minitest::Test

  def test_it_exists
    assert_instance_of Player, Player.new
  end

  def test_can_find_unoccupied_square_to_place_ships
    player = Player.new
    square = player.find_empty_square
    refute square.values[0].occupied
  end

  def test_can_place_computer_destroyer_ship
    skip
    player = Player.new
    empty_square = player.find_empty_square
    refute empty_square.values[0].occupied
    player.place_computer_destroyer(empty_square)
    assert empty_square.values[0].occupied
  end

  def test_can_place_ships_horizontally
    player = Player.new
    empty_square = @board.layout[0]
    right_square = player.place_ship_horizonally(empty_square)
    assert_equal @board.layout[1], right_square
    empty_square = @board.layout[3]
    left_square = player.place_ship_horizonally(empty_square)
    assert_equal @board.layout[2], left_square
  end

  def test_can_place_ships_vertically
    player = Player.new
    empty_square = @board.layout[0]
    below_square = player.place_ship_vertically(empty_square)
    assert_equal @board.layout[4], below_square
    empty_square = @board.layout[13]
    above_square = player.place_ship_vertically(empty_square)
    assert_equal @board.layout[9], above_square
  end


end
