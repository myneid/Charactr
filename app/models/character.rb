class Character < ActiveRecord::Base

  belongs_to :user
  belongs_to :campaign
  belongs_to :character_class
  belongs_to :race

  validates_presence_of :name
  validates_presence_of :experience_points
  validates_presence_of :level
  validates_presence_of :max_hit_points
  validates_presence_of :current_hit_points
  validates_presence_of :healing_surge_value
  validates_presence_of :surges_per_day
  validates_presence_of :current_surges_remaining
  validates_presence_of :alignment
  validates_presence_of :strength
  validates_presence_of :dexterity
  validates_presence_of :constitution
  validates_presence_of :intelligence
  validates_presence_of :wisdom
  validates_presence_of :charisma
  
  validates_inclusion_of :alignment, :in => ['good', 'lawful good', 'unaligned', 'evil', 'chaotic evil']
  validates_inclusion_of :sex, :in => ['male', 'female']
  # if a PC has > 10 action points, something goofy is going on
  validates_inclusion_of :current_action_points, :in => 0..10

  ABILITIES = ['Strength', 'Dexterity', 'Constitution', 'Intelligence', 'Wisdom', 'Charisma']

  # Automatically generate xxx_modifier, xxx_modifier_with_level methods for each ability
  ABILITIES.map{|ability| ability.downcase}.each do |a|
    Character.send(:define_method, "#{a}_modifier") do
      score = send(a.to_sym)
      Character.ability_modifier_for(score)
    end
    
    Character.send(:define_method, "#{a}_modifier_with_level") do
      send("#{a}_modifier".to_sym) + half_level_modifier
    end
  end

  def self.ability_modifier_for(ability_score)
    (ability_score - 10) / 2
  end
  
  def half_level_modifier
    level / 2
  end
  
  def initiative_modifier
    half_level_modifier + dexterity_modifier + misc_initiative_bonus
  end

  # TODO(sholder) theres probably a way to refactor these to reduce duplication
  
  # WARNING: this is not technically correct, ability mod should only apply if
  # character is not wearing heavy armor
  def armor_class
    ability = Math.max(dexterity, intelligence)
    10 + Character.ability_modifier_for(ability) + half_level_modifier + misc_armor_class_bonus 
  end
  
  def reflex_defense
    ability = Math.max(dexterity, intelligence)
    10 + Character.ability_modifier_for(ability) + half_level_modifier + character_class.reflex_def_bonus + misc_reflex_bonus 
  end

  def will_defense
    ability = Math.max(wisdom, charisma)
    10 + Character.ability_modifier_for(ability) + half_level_modifier + character_class.will_def_bonus + misc_will_bonus
  end

  def fortitude_defense
    ability = Math.max(strength, constitution)
    10 + Character.ability_modifier_for(ability) + half_level_modifier + character_class.fortitude_def_bonus + misc_fortitude_bonus
  end

  # return true if we successfully healed, false otherwise
  # bonus amount can be used for the d6 bonus from Healing Word, etc.
  def heal(bonus_amount = 0)
  	if current_surges_remaining > 0
  	  if self.current_hit_points < 0
  	    self.current_hit_points = 0
	    end
  		self.current_surges_remaining = self.current_surges_remaining - 1
  		self.current_hit_points += (self.healing_surge_value + bonus_amount)
  		if self.current_hit_points > self.max_hit_points
  			self.current_hit_points = self.max_hit_points
  		end
			return true
  	end
  	return false
  end
  
  # inflict damage, starting with temp hp
  def damage(amount)
    self.temp_hit_points -= amount
    if self.temp_hit_points < 0
      self.current_hit_points += self.temp_hit_points
      self.temp_hit_points = 0
    end
  end

end

module Math
  def self.max(a, b)
    return a > b ? a : b
  end
end
