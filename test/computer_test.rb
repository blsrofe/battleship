require './test/test_helper.rb'
require './lib/board'
require './lib/computer'

class ComputerTest < Minitest::Test

  def test_it_exists
    assert_instance_of Computer, Computer.new
  end

  def test_can_find_unoccupied_square_to_place_ships
    player = Computer.new
    square = player.find_empty_square
    refute square.values[0].occupied
  end

  def test_can_place_ships_horizontally
    player = Computer.new
    empty_square = player.board.layout[0]
    right_square = player.place_ship_horizonally(empty_square)
    assert_equal player.board.layout[1], right_square
    empty_square = player.board.layout[3]
    left_square = player.place_ship_horizonally(empty_square)
    assert_equal player.board.layout[2], left_square
  end

  def test_can_place_ships_vertically
    player = Computer.new
    empty_square = player.board.layout[0]
    below_square = player.place_ship_vertically(empty_square)
    assert_equal player.board.layout[4], below_square
    empty_square = player.board.layout[13]
    above_square = player.place_ship_vertically(empty_square)
    assert_equal player.board.layout[9], above_square
  end

  def test_can_find_key_to_the_left
    player = Computer.new
    empty_square_row = "B"
    empty_square_column = 2
    new_square = player.go_left(empty_square_column, empty_square_row)
    assert_equal "B1", new_square.keys.join
  end

  def test_can_find_key_to_the_right
    player = Computer.new
    empty_square_row = "C"
    empty_square_column = 2
    new_square = player.go_right(empty_square_column, empty_square_row)
    assert_equal "C3", new_square.keys.join
  end

  def test_can_find_key_above
    player = Computer.new
    empty_square_row = "B"
    empty_square_column = 2
    new_square = player.go_up(empty_square_column, empty_square_row)
    assert_equal "A2", new_square.keys.join
  end

  def test_can_find_key_below
    player = Computer.new
    empty_square_row = "B"
    empty_square_column = 2
    new_square = player.go_down(empty_square_column, empty_square_row)
    assert_equal "C2", new_square.keys.join
  end

  def test_knows_if_horizontal_sub_will_fit_on_board
    player = Computer.new
    first_square_destroyer = player.board.layout[5]#B2
    first_square_destroyer.values[0].occupied = true
    second_square_destroyer = player.board.layout[9]#C2
    second_square_destroyer.values[0].occupied = true
    empty_square = player.board.layout[10]#C3 hash
    refute player.evaluate_horizontal?(empty_square)
    new_empty_square = player.board.layout[1]
    assert player.evaluate_horizontal?(new_empty_square)
  end

  def test_knows_if_vertical_sub_will_fit_on_board
    player = Computer.new
    first_square_destroyer = player.board.layout[5]#B2
    first_square_destroyer.values[0].occupied = true
    second_square_destroyer = player.board.layout[6]#B3
    second_square_destroyer.values[0].occupied = true
    empty_square = player.board.layout[9]#B4 hash
    refute player.evaluate_vertical?(empty_square)
    new_empty_square = player.board.layout[7]
    assert player.evaluate_vertical?(new_empty_square)
  end

  def test_can_place_computer_sub_ship_vertically
    player = Computer.new
    empty_square = player.board.layout[0]
    refute empty_square.values[0].occupied
    player.place_computer_sub("vertical", empty_square)
    assert empty_square.values[0].occupied
    assert player.board.layout[4].values[0].occupied
    assert player.board.layout[8].values[0].occupied
  end

  def test_can_place_computer_sub_ship_horizontally
    player = Computer.new
    empty_square = player.board.layout[0]
    refute empty_square.values[0].occupied
    player.place_computer_sub("horizontal", empty_square)
    assert empty_square.values[0].occupied
    assert player.board.layout[1].values[0].occupied
    assert player.board.layout[2].values[0].occupied
  end

end
