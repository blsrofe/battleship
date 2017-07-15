require './test/test_helper.rb'
require './lib/square'

class SquareTest < Minitest::Test

  def test_it_exists
    assert_instance_of Square, Square.new
  end

  def test_it_is_unoccupied_when_instantiated
    square = Square.new
    refute square.occupied
  end

end
