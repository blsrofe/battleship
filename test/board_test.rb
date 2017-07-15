require './test/test_helper.rb'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exists
    assert_instance_of Board, Board.new
  end

  def test_it_can_find_square
    board = Board.new
    square = board.layout[10]
    assert_equal square, board.find_square("C3")
  end

  def test_it_can_tell_if_left_square_is_occupied#add more test cases after adding ships
    board = Board.new
    assert board.left_occupied?("A1")
    refute board.left_occupied?("B2")
  end

  def test_it_can_tell_if_right_square_is_occupied
    board = Board.new
    assert board.right_occupied?("A4")
    refute board.right_occupied?("B2")
  end

end
