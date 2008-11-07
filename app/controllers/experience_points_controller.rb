class ExperiencePointsController < ApplicationController
  before_filter :load_character, :ensure_user_valid

  def add
  	@newexp = params[:newexp].to_i
  	@character.iGotzDaPowerUpz(@newexp)
    if @character.save
      render :layout => false
    else
      render :text => 'Failed to save character!'
    end
  end



end