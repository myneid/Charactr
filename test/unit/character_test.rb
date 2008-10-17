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
  
  def test_initiative_modifier
    c = Character.new(:dexterity => 10)
    c.level = 1
    assert_equal 0, c.initiative_modifier
    c.level = 2
    assert_equal 1, c.initiative_modifier
    c.dexterity = 12    
    assert_equal 2, c.initiative_modifier
    c.dexterity = 9    
    assert_equal 0, c.initiative_modifier
    c.misc_initiative_bonus = 2
    assert_equal 2, c.initiative_modifier
  end
  
  def test_heal
    c = characters(:flappy)
    c.current_hit_points = 1
    c.current_surges_remaining = 1
    
    assert c.heal
    
    assert_equal(1 + c.healing_surge_value, c.current_hit_points)
    assert_equal(0, c.current_surges_remaining)
  end

  def test_heal_with_bonus
    c = characters(:flappy)
    c.current_hit_points = 1
    c.current_surges_remaining = 1
    
    assert c.heal(4)
    
    assert_equal(1 + 4 + c.healing_surge_value, c.current_hit_points)
    assert_equal(0, c.current_surges_remaining)
  end
  
  def test_heal_exceeds_max_hp
    c = characters(:flappy)
    c.current_hit_points = c.max_hit_points - 1
    c.current_surges_remaining = 1
    
    assert c.heal(10)
    
    assert_equal(c.max_hit_points, c.current_hit_points)
    assert_equal(0, c.current_surges_remaining)
  end
  
  def test_heal_when_in_negative_hp
    # should go to 0 first, then apply the healing
    c = characters(:flappy)
    c.current_hit_points = -3
    c.current_surges_remaining = 1
    
    assert c.heal
    
    assert_equal(c.healing_surge_value, c.current_hit_points)
  end
  
  def test_heal_no_healing_surges_remain
    c = characters(:flappy)
    c.current_hit_points = 1
    c.current_surges_remaining = 0
    
    assert !c.heal
    
    assert_equal(1, c.current_hit_points)
    assert_equal(0, c.current_surges_remaining)
  end
  
  def test_take_damage
    c = characters(:flappy)
    c.current_hit_points = 15
    
    c.damage 5
    
    assert_equal(10, c.current_hit_points)
  end
  
  def test_take_damage_temp_hp_absorbs_all
    c = characters(:flappy)
    c.current_hit_points = 15
    c.temp_hit_points = 5
    
    c.damage 3
    
    assert_equal(2, c.temp_hit_points)
    assert_equal(15, c.current_hit_points)
  end
  
  def test_take_damge_temp_hp_not_enough
    c = characters(:flappy)
    c.current_hit_points = 15
    c.temp_hit_points = 5
    
    c.damage 10
    
    assert_equal(0, c.temp_hit_points)
    assert_equal(10, c.current_hit_points)
  end
  
  def test_take_damge_go_unconcious
    c = characters(:flappy)
    c.current_hit_points = 15
    
    c.damage 20
    
    assert_equal(-5, c.current_hit_points)
  end
  
  # TODO update AC calculation to not apply ability mod when wearing heavy armor
    
  def test_calculate_ac_dex_higher
    c = characters(:flappy)
    assert_equal(13, c.armor_class)
  end
  
  def test_calculate_ac_int_higher
    c = characters(:izzard)
    assert_equal(16, c.armor_class)
  end
  
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
