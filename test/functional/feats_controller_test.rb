require 'test_helper'

class FeatsControllerTest < ActionController::TestCase
  def setup
    login_user(:myneid)
    @c = characters(:izzard)
  end

  def test_should_get_index
    get :index, :character_id => @c.id
    assert_response :success
    assert_not_nil assigns(:feats)
  end

  def test_should_get_new
    get :new, :character_id => @c.id
    assert_response :success
    assert_not_nil assigns(:character)
  end

  def test_should_create_feat
    assert_difference('Feat.count') do
      post :create, {:character_id => @c.id, :feat => {:name => 'That one ice magic feat', 
        :description => '+1 damage for any Arcane power w/ Cold keyword', :level_gained_at => 1  }}
    end

    assert_redirected_to character_path(@c)
  end

  def test_should_show_feat
    get :show, {:character_id => @c.id, :id => feats(:flappy_improved_initiative).id}
    assert_response :success
  end

  def test_should_get_edit
    get :edit, {:character_id => @c.id, :id => feats(:flappy_improved_initiative).id}
    assert_response :success
  end

  def test_should_update_feat
    put :update, {:character_id => @c.id, :id => feats(:flappy_improved_initiative).id, :feat => {:name => 'improved initiative' }}
    assert_not_nil assigns(:feat)
    assert_redirected_to character_path(@c)
  end

  def test_should_destroy_feat
    assert_difference('Feat.count', -1) do
      delete :destroy, {:character_id => @c.id, :id => feats(:flappy_improved_initiative).id}
    end

    assert_redirected_to character_path(@c)
  end
end
