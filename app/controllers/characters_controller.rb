class CharactersController < ApplicationController
  
  before_filter :ensure_user_valid
  
  # GET /characters
  # GET /characters.xml
  def index
    @characters = current_user.characters

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.xml
  def show
    @character = Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @character }
      format.js { render :json => @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.xml
  def new
    @character = Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @character = Character.find(params[:id])
  end

  # POST /characters
  # POST /characters.xml
  def create
    @character = Character.new(params[:character])
    # fill in default values
    @character.current_hit_points = @character.max_hit_points
    @character.current_action_points = 0
    @character.current_surges_remaining = @character.surges_per_day
    @character.user = current_user
    
    respond_to do |format|
      if @character.save
        flash[:notice] = 'Character was successfully created.'
        format.html { redirect_to(@character) }
        format.xml  { render :xml => @character, :status => :created, :location => @character }
      else
        @character.errors.each do |e|
          logger.debug e
        end
        
        format.html { render :action => "new" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.xml
  def update
    @character = Character.find(params[:id])

    respond_to do |format|
      if @character.update_attributes(params[:character])
        flash[:notice] = 'Character was successfully updated.'
        format.html { redirect_to(@character) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @character.errors, :status => :unprocessable_entity }
      end
    end
  end

  # TODO(sholder) really need a test for this
  def action_point
    @character = Character.find(params[:id])
    
    if 'true' == params[:add]
      @character.current_action_points += 1
    else
      @character.current_action_points -= 1
    end
    if @character.save
      render :text => @character.current_action_points
    else
      render :text => 'Failed to save character!'
    end
  end
  # TODO(sholder) really need a test for this
  def healing_surge_value
    @character = Character.find(params[:id])
    
    if 'true' == params[:add]
      @character.healing_surge_value += 1
    else
      @character.healing_surge_value -= 1
    end
    if @character.save
      render :text => @character.healing_surge_value
    else
      render :text => 'Failed to save character!'
    end
  end
  
  # DELETE /characters/1
  # DELETE /characters/1.xml
  def destroy
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(characters_url) }
      format.xml  { head :ok }
    end
  end
end
