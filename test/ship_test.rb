require './test/test_helper.rb'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    assert_instance_of Ship, Ship.new("A4")
  end

  def test_it_has_hit_points
    ship = Ship.new(2)
    assert_equal 2, ship.hit_points
  end

  def test_it_has_no_coordinates_when_created
    ship = Ship.new(2)
    assert_equal [], ship.coordinates
  end
end
