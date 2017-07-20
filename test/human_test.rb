require './test/test_helper.rb'
require './lib/board'
require './lib/human'

class HumanTest < Minitest::Test

  def test_it_exists
    assert_instance_of Human, Human.new
  end

  def test_can_add_player_destroyer
    player = Human.new
    player.destroyer = player.make_player_destroyer(["A1", "A2"])
    assert_equal ["A1", "A2"], player.destroyer.coordinates
  end

  def test_can_add_player_sub
    player = Human.new
    player.submarine = player.make_player_sub(["A1", "B1", "C1"])
    assert_equal ["A1", "B1", "C1"], player.submarine.coordinates
  end

  def test_if_vertical_knows_coordinates_are_next_to_each_other
    player = Human.new
    next_coord = "A2 B2"
    assert player.vertical?(next_coord)
    new_coord = "B1 D1"
    refute player.vertical?(new_coord)
  end

  def test_if_horizontal_knows_coordinates_are_next_to_each_other

    player = Human.new
    next_coord = "A2 A3"
    assert player.horizontal?(next_coord)
    new_coord = "B1 B3"
    refute player.horizontal?(new_coord)
  end

  def test_knows_if_player_entered_coordinates_are_correctly_formatted
    player = Human.new
    coord = "D3 D4"
    assert_equal "D3 D4", player.evaluate_coordinates_form(coord)
  end

  def test_knows_if_player_entered_coordinates_are_next_to_each_other
    player = Human.new
    coord = "D3 D4"
    assert_equal "D3 D4", player.evaluate_coordinates_proximity(coord)
  end

  def test_if_vertical_knows_sub_coordinates_are_next_to_each_other
    player = Human.new
    next_coord = "A2 B2 C2"
    assert player.sub_vertical?(next_coord)
    new_coord = "B1 D1 A1"
    refute player.sub_vertical?(new_coord)
  end

  def test_if_horizontal_knows_sub_coordinates_are_next_to_each_other

    player = Human.new
    next_coord = "A2 A3 A4"
    assert player.sub_horizontal?(next_coord)
    new_coord = "B1 B3 B4"
    refute player.sub_horizontal?(new_coord)
  end

  def test_knows_if_player_entered_sub_coordinates_are_correctly_formatted
    player = Human.new
    coord = "D2 D3 D4"
    assert_equal "D2 D3 D4", player.evaluate_sub_coordinates_form(coord)
  end

  def test_knows_if_player_entered_sub_coordinates_are_next_to_each_other
    player = Human.new
    coord = "D2 D3 D4"
    assert_equal "D2 D3 D4", player.evaluate_sub_coordinates_proximity(coord)
  end
end
