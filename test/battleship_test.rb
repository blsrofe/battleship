require './test/test_helper.rb'

class BattleShipTest < Minitest::Test

  def test_it_exists
    assert_instance_of BattleShip, BattleShip.new
  end

end
