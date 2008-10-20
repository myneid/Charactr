require 'test_helper'

class CharactersControllerTest < ActionController::TestCase

  def setup
    login_user(:myneid)
  end
  
  def test_should_require_valid_user
    @request.session[:openid] = nil
    @request.session[:user_id] = nil
    
    get :index
    assert_redirected_to login_url
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:characters)
    # should only see your own characters
    assigns(:characters).each do |char|
      assert_equal(users(:myneid), char.user)
    end
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_character
    # shouldn't need to specify current_hit_points, current_surges_remaining on create
    # owning user should come from the session
    character_data = {
      :name => 'Four',
      :campaign_id => campaigns(:online).id,
      :character_class_id => character_classes(:cleric).id,
      :race_id => races(:half_elf).id,
      :experience_points => 0,
      :level => 1,
      :sex => 'male',
      :max_hit_points => 27,
      :healing_surge_value => 8,
      :surges_per_day => 6,
      :current_action_points => 0,
      :alignment => 'good',
      :strength => 13,
      :dexterity => 12,
      :constitution => 12,
      :intelligence => 15,
      :wisdom => 17,
      :charisma => 17
    }
    assert_difference('Character.count') do
      post :create, :character => character_data
    end

    assert_redirected_to character_path(assigns(:character))
  end

  def test_should_show_character
    get :show, :id => characters(:flappy).id
    assert_response :success
    assert_equal(characters(:flappy), assigns(:character))
    assert_not_nil(assigns(:skills))
  end

  def test_should_get_edit
    get :edit, :id => characters(:flappy).id
    assert_response :success
    assert_equal(characters(:flappy), assigns(:character))
    assert_not_nil(assigns(:skills))
  end

  def test_should_update_character
    flappy = characters(:flappy)
    character_data = {
      :name => flappy.name,
      :campaign_id => flappy.campaign.id,
      :character_class_id => flappy.character_class.id,
      :race_id => flappy.race.id,
      :user_id => flappy.user.id,
      :experience_points => flappy.experience_points + 250,
      :level => flappy.level,
      :sex => 'male',
      :max_hit_points => flappy.max_hit_points,
      :healing_surge_value => flappy.healing_surge_value,
      :surges_per_day => flappy.surges_per_day,
      :current_action_points => flappy.current_action_points + 1,
      :alignment => flappy.alignment,
      :strength => flappy.strength,
      :dexterity => flappy.dexterity,
      :constitution => flappy.constitution,
      :intelligence => flappy.intelligence,
      :wisdom => flappy.wisdom,
      :charisma => flappy.charisma
    }
    put :update, :id => characters(:flappy).id, :character => character_data
    assert_redirected_to character_path(assigns(:character))
  end

  def test_should_destroy_character
    assert_difference('Character.count', -1) do
      delete :destroy, :id => characters(:flappy).id
    end

    assert_redirected_to characters_path
  end
end
