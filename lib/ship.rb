class Ship

  attr_accessor :hit_points,
                :coordinates


  def initialize(hit_points, coordinates = [])
    @hit_points = hit_points
    @coordinates = coordinates
  end

end
