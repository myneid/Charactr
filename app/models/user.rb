class User < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :openid_url
  validates_uniqueness_of :openid_url
  validates_uniqueness_of :name

  has_many :characters
  
end
