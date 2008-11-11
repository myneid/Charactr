class Skill < ActiveRecord::Base

  def self.ordered
    find(:all, :order => 'name')
  end

end
