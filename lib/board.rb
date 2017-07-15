require './lib/square'

class Board

  attr_reader :layout

  def initialize
    @layout = [{"A1" => Square.new}, {"A2" => Square.new}, {"A3" => Square.new}, {"A4" => Square.new},
              {"B1" => Square.new}, {"B2" => Square.new}, {"B3" => Square.new}, {"B4" => Square.new},
              {"C1" => Square.new}, {"C2" => Square.new}, {"C4" => Square.new}, {"C4" => Square.new},
              {"D1" => Square.new}, {"D2" => Square.new}, {"D3" => Square.new}, {"D4" => Square.new}]
  end

end
