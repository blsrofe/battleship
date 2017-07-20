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
      time = game_play_loop(comp, player)
      print_final_message(time, comp, player)
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

  def game_play_loop(comp, player)#will not break out of game when a player wins
    start_time = Time.now
    until @winner != nil
      player_view(comp)
      player_shot_sequence(comp)
      winner?(comp)
      player_view(comp)
      enter_to_continue
      computer_shot_sequence(player)
      winner?(player)
    end
    end_time = Time.now
    final_time = (end_time - start_time).to_i
    final_time
  end

  def print_final_message(time, comp, player)
    if @winner == "player"
      puts "Congratulation, you won!"
      puts "It took you #{comp.shots.count} shots."
      puts "This game lasted #{time} seconds."
    elsif @winner == "computer"
      puts "Sorry, you lost this time. Better luck next time!"
      puts "It took your opponent #{player.shots.count} shots to sink your ships."
      puts "This game lasted #{time} seconds."
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
    if match && shot.length == 2
      shot
    else
      puts "That is not a valid entry. Please try again."
      shot = get_player_shot
      validate_on_board(shot)
    end
  end

  def shoot(shot, comp)
    square = comp.board.find_square(shot)
    already_called = comp.shots.include?(shot)
    if already_called
      puts "You have already picked that square. Please select another."
      player_shot_sequence(comp)
    elsif square.values[0].occupied == true
      comp.shots << shot
      square.values[0].shot = "H"
      puts "That is a hit!"
      if comp.destroyer.coordinates.include?(shot)
        comp.destroyer.hit_points -= 1
        destroyer_sunk(comp)
      elsif comp.submarine.coordinates.include?(shot)
        comp.submarine.hit_points -= 1
        sub_sunk(comp)
      end
    else
      comp.shots << shot
      square.values[0].shot = "M"
      puts "That is a miss"
    end
  end

  def destroyer_sunk(comp)
    if comp.destroyer.hit_points == 0
      puts "You sunk the destroyer!"
    end
  end

  def sub_sunk(comp)
    if comp.submarine.hit_points == 0
      puts "You sunk the sub!"
    end
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
    score = hit_or_miss(square_name, player)
    player_message(square_name, score)
    computer_view(player)
  end

  def find_random(player)
    random_square_name = player.board.layout.sample.keys.join
    already_called = player.shots.include?(random_square_name)
    if already_called
      find_random(player)
    else
      player.shots << random_square_name
      random_square_name
    end
  end

  def hit_or_miss(square_name, player)
    square = player.board.find_square(square_name)
    if square.values[0].occupied == true
    square.values[0].shot = "H"
    score = "hit"
      if player.destroyer.coordinates.include?(square_name)
        player.destroyer.hit_points -= 1
      elsif player.submarine.coordinates.include?(square_name)
        player.submarine.hit_points -= 1
      end
      score
    elsif square.values[0].occupied == false
      square.values[0].shot = "M"
      score = "miss"
      score
    end
  end

    def player_message(square_name, score)
      if score == "hit"
        puts "Your opponent got a hit on square #{square_name}!"
      else
        puts "Your opponent missed at square #{square_name}!"
      end
    end

end
