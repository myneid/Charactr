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
  
  # TODO calculate AC - need to know if character is wearing heavy armor or not (int/dex only applies w/ no armor)
  
  def test_calculate_reflex_defense_dex_higher
    # should be 10 + class + attribute + misc modifier (equipment inc. shield) + 1/2 level
    c = characters(:flappy)
    assert_equal(16, c.reflex_defense)
  end

  def test_calculate_reflex_defense_int_higher
    c = characters(:izzard)
    assert_equal(16, c.reflex_defense)
  end
  
  def test_calculate_will_defense_wis_higher
    c = characters(:izzard)
    assert_equal(16, c.will_defense)
  end

  def test_calculate_will_defense_cha_higher
    c = characters(:flappy)
    assert_equal(12, c.will_defense)
  end

  def test_calculate_fort_defense_str_higher
    c = characters(:flappy)
    assert_equal(11, c.fortitude_defense)
  end
  
  def test_calculate_fort_defense_con_higher
    c = characters(:izzard)
    assert_equal(12, c.fortitude_defense)
  end
  
  # TODO tests for calculating initiative, etc.

end
