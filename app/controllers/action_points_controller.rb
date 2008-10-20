class ActionPointsController < ApplicationController  
  before_filter :load_character, :ensure_user_valid
  
  def add
    @character.current_action_points += 1
    if @character.save
      render :text => @character.current_action_points
    else
      render :text => 'Failed to save character!'
    end
  end
  
  def remove
    @character.current_action_points -= 1
    if @character.save
      render :text => @character.current_action_points
    else
      render :text => 'Failed to save character!'
    end    
  end
  
end