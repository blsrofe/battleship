class Ship

  attr_accessor :first_square,
                :hit_points,
                :second_square,
                :third_square


  def initialize(first_square, hit_points, second_square = nil, third_square = nil)
    @first_square = first_square
    @hit_points = hit_points
    @second_square = second_square
    @third_square = third_square
  end

end
