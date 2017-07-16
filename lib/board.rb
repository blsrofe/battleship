require './lib/square'

class Board

  attr_accessor :layout

  def initialize
    @layout = [{"A1" => Square.new}, {"A2" => Square.new}, {"A3" => Square.new}, {"A4" => Square.new},
              {"B1" => Square.new}, {"B2" => Square.new}, {"B3" => Square.new}, {"B4" => Square.new},
              {"C1" => Square.new}, {"C2" => Square.new}, {"C3" => Square.new}, {"C4" => Square.new},
              {"D1" => Square.new}, {"D2" => Square.new}, {"D3" => Square.new}, {"D4" => Square.new}]
  end

  def find_square(key)
    new_square = @layout.detect do |square|
      square.keys.join == key
    end
    new_square
  end

  def left_occupied?(key)
    if key[1] == "1"
      new_column = 1
    else
      new_column = key[1].to_i - 1
    end
    row = key[0]
    new_key = row += new_column.to_s
    new_square = find_square(new_key)
    if key[1] == "1" || new_square.values[0].occupied == true
      return true
    else
      false
    end
  end

  def right_occupied?(key)
    if key[1] == "4"
      new_column = 4
    else
      new_column = key[1].to_i + 1
    end
    row = key[0]
    new_key = row += new_column.to_s
    new_square = find_square(new_key)
    if key[1] == "4" || new_square.values[0].occupied == true
      return true
    else
      false
    end
  end

  def above_occupied?(key)
    if key[0] == "A"
      new_row = "A"
    else
      if key[0] == "B"
        new_row = "A"
      elsif key[0] == "C"
        new_row = "B"
      elsif key[0] == "D"
        new_row = "C"
      end
    end
    column = key[1]
    new_key = new_row += column
    new_square = find_square(new_key)
    if key[0] == "A" || new_square.values[0].occupied == true
      return true
    else
      false
    end
  end

  def below_occupied?(key)
    if key[0] == "D"
      new_row = "D"
    else
      if key[0] == "C"
        new_row = "D"
      elsif key[0] == "B"
        new_row = "C"
      elsif key[0] == "A"
        new_row = "B"
      end
    end
    column = key[1]
    new_key = new_row += column
    new_square = find_square(new_key)
    if key[0] == "D" || new_square.values[0].occupied == true
      return true
    else
      false
    end
  end

end
