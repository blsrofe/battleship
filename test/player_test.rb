require './test/test_helper.rb'
require './lib/player'

class PlayerTest < Minitest::Test

  def test_it_exists
    assert_instance_of Player, Player.new
  end

  def test_can_find_unoccupied_square_to_place_ships
    player = Player.new
    square = player.find_empty_square
    refute square.values[0].occupied
  end

end
