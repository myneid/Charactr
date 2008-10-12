require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    # simulate logging in by default
    @request.session[:openid] = 'http://test.user.openid.com'
  end
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_user
    # should pull the open id url from the session
    @request.session[:openid] = 'http://test.user.openid.com'
    # should have been set by login process
    @request.session[:nickname] = 'tester'
    assert_difference('User.count') do
      post :create, :user => {}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_show_form_if_name_not_provided
    # should pull the open id url from the session
    @request.session[:openid] = 'http://test.user.openid.com'
    @request.session[:nickname] = nil
    
    post :create, :user => {}

    assert_response :success
    assert_template 'new'
  end

  def test_should_redirect_to_view_if_user_exists
    @request.session[:openid] = users(:sholder).openid_url
    @request.session[:nickname] = nil
    
    post :create, :user => {}
    
    assert_redirected_to user_path(users(:sholder))
  end

  def test_should_require_logged_in
    @request.session[:openid] = nil
    
    post :create, :user => {}
    
    assert_redirected_to login_url
  end

  def test_should_show_user
    get :show, :id => users(:sholder).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => users(:sholder).id
    assert_response :success
  end

  def test_should_update_user
    put :update, :id => users(:sholder).id, 
        :user => {:name => users(:sholder).name, 
                  :openid_url => users(:sholder).openid_url}
    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_destroy_user
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:sholder).id
    end

    assert_redirected_to users_path
  end
end
