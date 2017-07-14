require 'simplecov'
require './lib/battleship'
require 'minitest/autorun'
require 'minitest/pride'
require "minitest/emoji"
require 'pry'

class BattleShipTest < Minitest::Test

  def test_it_exists
    assert_instance_of BattleShip, BattleShip.new
  end

end
