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

  def test_can_find_unoccupied_square_to_place_ships#add to this test later after you have added method to place ships
    game = Game.new
    board = Board.new
    name = game.find_unoccupied_start_square(board)
    refute name.values[0].occupied
  end

end
