require './lib/square'

class Board

  attr_reader :row_1,
              :row_2,
              :row_3,
              :row_4

  def initialize
    @row_1 = [{"A1" => Square.new}, {"A2" => Square.new}, {"A3" => Square.new}, {"A4" => Square.new}]
    @row_2 = [{"B1" => Square.new}, {"B2" => Square.new}, {"B3" => Square.new}, {"B4" => Square.new}]
    @row_3 = [{"C1" => Square.new}, {"C2" => Square.new}, {"C4" => Square.new}, {"C4" => Square.new}]
    @row_4 = [{"D1" => Square.new}, {"D2" => Square.new}, {"D3" => Square.new}, {"D4" => Square.new}]
  end

end
