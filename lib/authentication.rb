module Authentication

  def evaluate_coordinates_form(coord)
    good_coords = /([A-D])([1-4])([ ])([A-D])([1-4])/
    match = good_coords.match(coord)
    if match && coord.length == 5
      coord
    else
      puts "That is not a valid entry. Make sure your entry follows this form A1 A2."
      coord = display_player_message
      evaluate_coordinates_form(coord)
    end
  end

  def evaluate_coordinates_proximity(coord)
    if horizontal?(coord) || vertical?(coord)
      coord
    else
      puts "These are not valid coordinates. Make sure your coordinates are next to each other."
      coord = display_player_message
      des_coords = evaluate_coordinates_form(coord)
      evaluate_coordinates_proximity(des_coords)
    end
  end

  def horizontal?(coord)
    split_coord_collection = coord.split(" ")
    first_coord = split_coord_collection[0]
    second_coord = split_coord_collection[1]
    difference = (first_coord[1].to_i - second_coord[1].to_i).abs
    if first_coord[0] == second_coord[0] && difference == 1
      true
    else
      false
    end
  end

  def vertical?(coord)
    split_coord_collection = coord.split(" ")
    first_coord = split_coord_collection[0]
    second_coord = split_coord_collection[1]
    difference = (first_coord[0].ord - second_coord[0].ord).abs
    if first_coord[1] == second_coord[1] && difference == 1
      true
    else
      false
    end
  end

  def evaluate_sub_coordinates_form(coord)
    good_coords = /([A-D])([1-4])([ ])([A-D])([1-4])([ ])([A-D])([1-4])/
    match = good_coords.match(coord)
    if match && coord.length == 8
      coord
    else
      puts "That is not a valid entry. Make sure your entry follows this form A1 A2 A3."
      coord = get_sub_coordinates
      evaluate_sub_coordinates_form(coord)
    end
  end

  def evaluate_sub_coordinates_proximity(coord)
    if sub_horizontal?(coord) || sub_vertical?(coord)
      coord
    else
      puts "These are not valid coordinates. Make sure your coordinates are next to each other."
      coord = display_player_message
      sub_coords = evaluate_sub_coordinates_form(coord)
      evaluate_sub_coordinates_proximity(sub_coords)
    end
  end

  def sub_horizontal?(coord)
    split_coord_collection = coord.split(" ")
    first_coord = split_coord_collection[0]
    second_coord = split_coord_collection[1]
    third_coord = split_coord_collection[2]
    difference = (first_coord[1].to_i - second_coord[1].to_i).abs
    difference_2 = (second_coord[1].to_i - third_coord[1].to_i).abs
    if first_coord[0] == second_coord[0] && difference == 1 && difference_2 == 1
      true
    else
      false
    end
  end

  def sub_vertical?(coord)
    split_coord_collection = coord.split(" ")
    first_coord = split_coord_collection[0]
    second_coord = split_coord_collection[1]
    third_coord = split_coord_collection[2]
    difference = (first_coord[0].ord - second_coord[0].ord).abs
    difference_1 = (second_coord[0].ord - third_coord[0].ord).abs
    if first_coord[1] == second_coord[1] && difference == 1 && difference_1 == 1
      true
    else
      false
    end
  end

end
