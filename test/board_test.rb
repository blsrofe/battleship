require './test/test_helper.rb'

class BoardTest < Minitest::Test

  def test_it_exists
    assert_instance_of Board, Board.new
  end

end
