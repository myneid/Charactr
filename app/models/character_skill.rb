class CharacterSkill < ActiveRecord::Base
  belongs_to :character
  belongs_to :skill
  
  validates_presence_of :misc_bonus_description, :if => Proc.new {|cs| !cs.misc_bonus.nil? && cs.misc_bonus != 0}

  before_validation :set_defaults

  def total_bonus
    skill_modifier_method = "#{skill.key_ability.downcase}_modifier_with_level"
    character.send(skill_modifier_method.to_sym) + self.misc_bonus + (self.trained ? 5 : 0)
  end
  
  protected
  
  def set_defaults
    self.trained = false unless self.trained?
    true
  end

end
