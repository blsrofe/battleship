class Game

  def initial_instructions
    puts "Welcome to BATTLESHIP"
    puts ""
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    beginning_input = gets.chomp.downcase
    beginning_input
  end

  def start_sequence(choice)
    if choice == "p" || choice == "play"
      puts "This will start the game"#change this later
    elsif choice == "i" or choice == "input"
      puts "instructions"
      #give_instructions
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
  end

end
