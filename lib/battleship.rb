require './lib/game'

class BattleShip

  game = Game.new
  choice = game.initial_instructions
  game.start_sequence(choice)

end
