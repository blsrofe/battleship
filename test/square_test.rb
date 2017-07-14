require './test/test_helper.rb'

class SquareTest < Minitest::Test

  def test_it_exists
    assert_instance_of Square, Square.new
  end

end
