require 'test_helper'

class CharacterTest < ActiveSupport::TestCase

  def test_ability_modifier
    assert_equal(-3, Character.ability_modifier_for(4))
    assert_equal(-1, Character.ability_modifier_for(8))
    assert_equal(-1, Character.ability_modifier_for(9))
    assert_equal(0, Character.ability_modifier_for(10))
    assert_equal(0, Character.ability_modifier_for(11))
    assert_equal(1, Character.ability_modifier_for(12))
    assert_equal(1, Character.ability_modifier_for(13))
    assert_equal(4, Character.ability_modifier_for(18))
  end

  def test_generated_ability_modifier_methods
    c = Character.new
    c.level = 4
    Character::ABILITIES.map {|a| a.downcase }.each do |ability|
      c.send("#{ability}=".to_sym, 12)
      assert_equal(12, c.send(ability.to_sym))
      assert_equal(1, c.send("#{ability}_modifier".to_sym))
      assert_equal(3, c.send("#{ability}_modifier_with_level".to_sym))
    end
  end

  def test_half_level_modifier
    c = Character.new
    c.level = 1
    assert_equal(0, c.half_level_modifier)
    c.level = 2
    assert_equal(1, c.half_level_modifier)
    c.level = 9
    assert_equal(4, c.half_level_modifier)
    c.level = 10
    assert_equal(5, c.half_level_modifier)
  end
  
  # TODO tests for calculating defenses, initiative, etc.

end
