require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  
  def setup
    login_user(:sholder)
  end
  
  def test_should_require_user
    @request.session[:openid] = nil
    @request.session[:user_id] = nil
    
    get :index
    assert_redirected_to login_url
  end
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:campaigns)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_campaign
    assert_difference('Campaign.count') do
      # should take user id from session
      post :create, :campaign => {:name => 'test campaign'}
    end

    assert_redirected_to campaign_path(assigns(:campaign))
  end

  def test_should_show_campaign
    get :show, :id => campaigns(:online).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => campaigns(:online).id
    assert_response :success
  end

  def test_should_update_campaign
    put :update, :id => campaigns(:online).id, :campaign => {:description => 'updated description' }
    assert_redirected_to campaign_path(assigns(:campaign))
  end

  def test_should_destroy_campaign
    assert_difference('Campaign.count', -1) do
      delete :destroy, :id => campaigns(:online).id
    end

    assert_redirected_to campaigns_path
  end
end
