class CharacterSkillsController < ApplicationController
  before_filter :load_character, :ensure_user_valid

  def create
    @character_skill = CharacterSkill.new(params[:character_skill])
    @character_skill.character = @character
    if @character_skill.save
      @message = 'Skill data saved'
    else
      @message = 'Failed to save skill info!'
    end
  end

  def update
    @character_skill = CharacterSkill.find(params[:id])
    if @character_skill.update_attributes(params[:character_skill])
      @message = 'Skill data saved'
    else
      @message = 'Failed to save skill info!'
    end
  end

end