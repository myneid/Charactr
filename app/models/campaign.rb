class Campaign < ActiveRecord::Base
  
  belongs_to :created_by_user, :class_name => 'User'
  
  validates_presence_of :name
  
end
