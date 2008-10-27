class Character < ActiveRecord::Base

  belongs_to :user
  belongs_to :campaign
  belongs_to :character_class
  belongs_to :race
  has_many :character_skills, :include => :skill
  has_many :feats
  has_many :notes

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
  validates_presence_of :campaign_id
  
  validates_inclusion_of :alignment, :in => ['good', 'lawful good', 'unaligned', 'evil', 'chaotic evil']
  validates_inclusion_of :sex, :in => ['male', 'female']
  # if a PC has > 10 action points, something goofy is going on
  validates_inclusion_of :current_action_points, :in => 0..10

  ABILITIES = ['Strength', 'Dexterity', 'Constitution', 'Intelligence', 'Wisdom', 'Charisma']

  # Automatically generate xxx_modifier, xxx_modifier_with_level methods for each ability
  ABILITIES.map(&:downcase).each do |a|    
    class_eval "
    def #{a}_modifier
      Character.ability_modifier_for(#{a})
    end
    
    def #{a}_modifier_with_level
      #{a}_modifier + half_level_modifier
    end"
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
  
  def total_skill_bonus(skill)
    #ugh... this ended up getting messier than I would have liked, and has
    #some duplication w/ CharacterSkill.  any ideas on how to refactor?
    character_skill = character_skills.detect {|cs| cs.skill == skill}
    
    if character_skill.nil?    
      skill_modifier_method = "#{skill.key_ability.downcase}_modifier_with_level"
      base_bonus = send(skill_modifier_method.to_sym)
    else
      base_bonus = character_skill.total_bonus
    end
    
    if skill.subject_to_armor_check_penalty?
      base_bonus += self.armor_check_penalty
    end
    
    base_bonus
  end
  
  def character_skill_for(skill)
    character_skill = character_skills.detect {|cs| cs.skill == skill}
    return character_skill.nil? ? CharacterSkill.new(:character => self, :skill => skill) : character_skill
  end

  def trained?(skill)
    character_skill = character_skills.detect {|cs| cs.skill == skill}
    if character_skill
      return character_skill.trained?
    else
      return false
    end
  end
end

module Math
  def self.max(a, b)
    return a > b ? a : b
  end
end
