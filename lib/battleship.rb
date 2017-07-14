require './lib/game'

game = Game.new
choice = game.initial_instructions
game.start_sequence(choice)
