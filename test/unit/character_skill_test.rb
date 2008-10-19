require 'test_helper'

class CharacterSkillTest < ActiveSupport::TestCase

  def test_calculate_bonus_trained
    cs = character_skills(:flappy_bluff)
    assert_equal(7, cs.total_bonus)
  end
  
  def test_calculate_bonus_untrained
    cs = character_skills(:izzard_endurance)
    assert_equal(3, cs.total_bonus)
  end

end
