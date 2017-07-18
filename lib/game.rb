require './lib/board'
require './lib/ship'
require './lib/player'
require 'pry'
class Game

  attr_accessor :winner

  def initialize
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
      comp.computer_ship_placement
      player.player_ship_placement
      game_play_loop(comp, player)
      # print_final_message
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

  def computer_view(player)
    square = player.board.layout
    puts "==========="
    puts "Computer Board"
    puts "==========="
    puts ".1234"
    puts "A#{square[0].values[0].shot}#{square[1].values[0].shot}#{square[2].values[0].shot}#{square[3].values[0].shot}"
    puts "B#{square[4].values[0].shot}#{square[5].values[0].shot}#{square[6].values[0].shot}#{square[7].values[0].shot}"
    puts "C#{square[8].values[0].shot}#{square[9].values[0].shot}#{square[10].values[0].shot}#{square[11].values[0].shot}"
    puts "D#{square[12].values[0].shot}#{square[13].values[0].shot}#{square[14].values[0].shot}#{square[15].values[0].shot}"
    puts "==========="
  end

  def player_view(comp)
    square = comp.board.layout
    puts "==========="
    puts "Your Board"
    puts "==========="
    puts ".1234"
    puts "A#{square[0].values[0].shot}#{square[1].values[0].shot}#{square[2].values[0].shot}#{square[3].values[0].shot}"
    puts "B#{square[4].values[0].shot}#{square[5].values[0].shot}#{square[6].values[0].shot}#{square[7].values[0].shot}"
    puts "C#{square[8].values[0].shot}#{square[9].values[0].shot}#{square[10].values[0].shot}#{square[11].values[0].shot}"
    puts "D#{square[12].values[0].shot}#{square[13].values[0].shot}#{square[14].values[0].shot}#{square[15].values[0].shot}"

    puts "==========="
  end

  def game_play_loop(comp, player)
    while winner == nil
      player_view(comp)
      player_shot_sequence(comp)
      computer_view(player)
      # computer shoots
    end
  end

  def print_final_message
    if @winner == "player"
      puts "Congratulation, you won!"
    elsif @winner == "computer"
      puts "Sorry, you lost this time. Better luck next time!"
    end
  end

  def player_shot_sequence(comp)
    shot = get_player_shot
    good_shot = validate_on_board(shot)
    shots = []
    shoot(good_shot, comp, shots)
  end

  def get_player_shot
    puts "Which space do you want to shoot at?"
    shot = gets.chomp
    shot
  end

  def validate_on_board(shot)
    good_shot = /([A-D])([1-4])/
    match = good_shot.match(shot)
    if match && space.length == 2
      shot
    else
      puts "That is not a valid entry. Please try again."
      shot = get_player_shot
      validate_shoot(shot)
    end
  end

  def shoot(shot, comp, shots)
    square = comp.board.layout.find_square(shot)
    already_called = shots.include? do |coord|
      coord == shot
    end
    if already_called
      puts "You have already picked that square. Please select another."
      player_shot_sequence(comp)
    elsif square.values.occupied == true
      shots << shot
      square.values.shot = "H"
      puts "That is a hit!"
      if comp.destroyer.coordinates.include? {|coord| coord == shot}
        comp.destroyer.hit_points -= 1
      elsif comp.submarine.coordinates.include? {|coord| coord == shot}
        comp.destroyer.hit_points -= 1
      #need to add hit on ship and decide if game is over
      #destroyer and sub are now arrays in ship class
      #check to see if ship is at 0 health points and if there is a winner
    else
      shots << shot
      square.values.shot = "M"
      puts "That is a miss"
  end

end
