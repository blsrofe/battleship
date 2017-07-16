require './test/test_helper.rb'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    assert_instance_of Ship, Ship.new("A4")
  end

  def test_second_and_third_squares_are_nil_upon_instantiation
    ship = Ship.new("A4")
    assert_nil ship.second_square
    assert_nil ship.third_square
  end

end
