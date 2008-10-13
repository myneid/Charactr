# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def races
    Race.find(:all, :order => 'name desc').collect {|r| [r.name, r.id]}
  end
  
  def classes
    CharacterClass.find(:all, :order => 'name desc').collect {|c| [c.name, c.id]}
  end
  
  def campaigns
    Campaign.find(:all, :order => 'name desc').collect {|c| [c.name, c.id]}
  end
  
  def alignments
    ['lawful good', 'good', 'unaligned', 'evil', 'chaotic evil']
  end
  
end
