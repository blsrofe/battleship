require './test/test_helper.rb'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    assert_instance_of Ship, Ship.new("A4")
  end

  def
  end

end
