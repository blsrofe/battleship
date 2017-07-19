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
      print_final_message
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
    while @winner == nil
      player_view(comp)
      player_shot_sequence(comp)
      break if winner?(comp)
      player_view(comp)
      enter_to_continue
      computer_shot_sequence(player)
      winner?(player)

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
    shoot(good_shot, comp)
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

  def shoot(shot, comp)
    square = comp.board.layout.find_square(shot)
    already_called = comp.shots.include? do |coord|
      coord == shot
    end
    if already_called
      puts "You have already picked that square. Please select another."
      player_shot_sequence(comp)
    elsif square.values.occupied == true
      comp.shots << shot
      square.values.shot = "H"
      puts "That is a hit!"
      if comp.destroyer.coordinates.include? {|coord| coord == shot}
        comp.destroyer.hit_points -= 1
        if comp.destoyer.hit_points == 0
          puts "You sunk the destroyer!"
        end
      elsif comp.submarine.coordinates.include? {|coord| coord == shot}
        comp.submarine.hit_points -= 1
        if comp.submarine.hit_points == 0
          puts "You sunk the sub!"
        end
      #destroyer and sub are now arrays in ship class
      #check to see if ship is at 0 health points and if there is a winner
    else
      comp.shots << shot
      square.values.shot = "M"
      puts "That is a miss"
  end

  def winner?(player)
    if player.submarine.hit_points == 0 && player.destroyer.hit_points == 0
      @winner = "player"
      true
    else
      false
    end
  end

  def enter_to_continue
    puts "Please press enter to continue"
    command = gets.chomp
    if command.empty?
      return
    else
      enter_to_continue
    end
  end

  def computer_shot_sequence(player)
    square_name = find_random(player)
    hit_or_miss(square_name, player)

  end

  def find_random(player)
    random_square_name = player.board.layout.sample.keys.join
    already_called = player.shots.include? do |shot|
      random_square_name == shot
    end
    if already_called
      find_random(player, shots)
    else
      player.shots << random_square_name
      random_square_name
    end
  end

  def hit_or_miss(square_name, player)
    square = player.board.layout.find_square(square_name)
    if square.values.occupied == true
    square.values.shot = "H"
      if player.destroyer.coordinates.include? {|coord| coord == square_name}
        player.destroyer.hit_points -= 1
      elsif player.submarine.coordinates.include? {|coord| coord == square_name}
        player.submarine.hit_points -= 1
      end
    else square.values.occupied == false
      square.values.shot = "M"
    end
  end
