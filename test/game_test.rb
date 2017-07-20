require './test/test_helper.rb'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    assert_instance_of Game, Game.new
  end

  def test_can_give_instrutions
    game = Game.new
    instructions = "You have two ships. You will be prompted to place your ships. Enter the coordinates
    with a space separating them. You will then be asked to fire at a square on your
    opponents board. If you hit all squares of their ship, you will sink their ship.
    The first player to sink both of their opponents ships is the winner."
    assert_equal instructions, game.give_instructions
  end

  def test_it_can_quit
    game = Game.new
    message = "Thank you for playing."
    assert_equal message, game.start_sequence("q")
  end

end
