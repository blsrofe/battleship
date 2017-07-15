require './test/test_helper.rb'

class BoardTest < Minitest::Test

  def test_it_exists
    assert_instance_of Board, Board.new
  end

  def test_it_has_a_first_row
    board = Board.new
    assert_equal [{"A1" => Square.new}, {"A2" => Square.new}, {"A3" => Square.new}, {"A4" => Square.new}], board.row_1
  end

end
