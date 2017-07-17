require './test/test_helper.rb'
require './lib/battleship.rb'

class BattleShipTest < Minitest::Test

  def test_it_exists#runs through start_sequence. Is this OK?, has errors on play
    assert_instance_of BattleShip, BattleShip.new
  end

end
