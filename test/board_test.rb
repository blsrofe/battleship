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


end
