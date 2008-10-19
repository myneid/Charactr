class CharactersController < ApplicationController
  
  before_filter :ensure_user_valid
  before_filter :load_character, :except => [:index, :new, :create]
  
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
    @skills = Skill.find(:all, :order => 'name')
    
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
  def current_surges_remaining
    
    if 'true' == params[:add]
      @character.current_surges_remaining += 1
    else
      @character.current_surges_remaining -= 1
    end
    if @character.save
      render :text => @character.current_surges_remaining
    else
      render :text => 'Failed to save character!'
    end
  end
  
  def heal_healing_surge
  	
  	if @character.heal
  	  @character.save
	  end
	  # TODO(tdecourson) display an error message or something if the heal or save fails
  	render :layout => false
  end
  
  def damage    
    @damage = params[:amount].to_i
    
    @character.damage(@damage)
    if @character.save
      render :layout => false
    end
  end
  
  # DELETE /characters/1
  # DELETE /characters/1.xml
  def destroy
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(characters_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def load_character
      @character = Character.find(params[:id])
    end
end
