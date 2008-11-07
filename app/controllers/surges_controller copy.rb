class SurgesController < ApplicationController
  before_filter :load_character, :ensure_user_valid

  def add
    @character.current_surges_remaining += 1
    if @character.save
      render :text => @character.current_surges_remaining
    else
      render :text => 'Failed to save character!'
    end
  end

  def remove
    @character.current_surges_remaining -= 1
    if @character.save
      render :text => @character.current_surges_remaining
    else
      render :text => 'Failed to save character!'
    end    
  end

end