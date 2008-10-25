class Feat < ActiveRecord::Base

  belongs_to :character

  validates_presence_of :name
  validates_presence_of :level_gained_at

end
