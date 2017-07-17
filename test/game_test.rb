require './test/test_helper.rb'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    assert_instance_of Game, Game.new
  end

  def test_lowercase_or_capital_i_returns_info
    skip#test start_sequence scenarios
    game = Game.new
    instructions = "You have two ships. You will be prompted to place your ships."
    assert_equal instructions, game.start_sequence("i")
  end

  def test_can_give_instrutions
    game = Game.new
    instructions = "You have two ships. You will be prompted to place your ships."
    assert_equal instructions, game.give_instructions
  end
  
end
