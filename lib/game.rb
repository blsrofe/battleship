require './lib/board'
require './lib/ship'
require './lib/player'
require 'pry'
class Game

  attr_accessor :board,
                :winner

  def initialize
    @board = Board.new
    @winner = nil
  end

  def initial_instructions
    puts "Welcome to BATTLESHIP"
    puts ""
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    gets.chomp.downcase
  end

  def start_sequence(choice)
    if choice == "p" || choice == "play"
      comp = Player.new
      player = Player.new
      comp_destroyer, comp_sub = comp.computer_ship_placement
      player_destroyer, player_sub = player.player_ship_placement
      game_play_loop()
    elsif choice == "i" or choice == "input"
      puts give_instructions
      puts ""
      puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
      choice = gets.chomp.downcase
      start_sequence(choice)
    elsif choice == "q" or choice == "quit"
      puts "Thank you for playing."
    else
      puts "That is not a valid command."
      puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
      choice = gets.chomp.downcase
      start_sequence(choice)
    end
  end

  def give_instructions
    "You have two ships. You will be prompted to place your ships."
  end

  def computer_view
    puts "==========="
    puts "Computer View"
    puts "==========="
    puts ".1234"
    puts "A"
    puts "B"
    puts "C"
    puts "D"
    puts "==========="
  end

  def player_grid
    puts "==========="
    puts "Player View"
    puts "==========="
    puts ".1234"
    puts "A"
    puts "B"
    puts "C"
    puts "D"
    puts "==========="
  end

end
