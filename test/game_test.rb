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

  def test_computer_can_place_ships
    skip
    game = Game.new
    message = "Your opponent has placed their ships. Now you need to place your ships"
    assert_equal message, game.computer_ship_placement
  end

  def test_can_find_random_square_to_start_placing_ships
    skip
    start = game.find_random_start_square
    assert board.layout.any? {|square| square.keys == [start]} #this works if start returns a string, might have to convert start to string before doing this
  end

end
