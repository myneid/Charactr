class Skill < ActiveRecord::Base

  def self.ordered
    Skill.find(:all, :order => 'name')
  end

end
