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

  ABILITIES = ['Strength', 'Dexterity', 'Constitution', 'Intelligence', 'Wisdom', 'Charisma']

  # Automatically generate xxx_modifier methods for each ability
  ABILITIES.map{|ability| ability.downcase}.each do |a|
    Character.send(:define_method, "#{a}_modifier") do
      score = send(a.to_sym)
      Character.ability_modifier_for(score)
    end
  end

  def self.ability_modifier_for(ability_score)
    (ability_score - 10) / 2
  end

end
