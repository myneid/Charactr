require 'test_helper'

class SurgesControllerTest < ActionController::TestCase

  def setup
    login_user(:myneid)
  end
  
  def test_should_require_valid_user
    @request.session[:openid] = nil
    @request.session[:user_id] = nil
    
    post :add, :character_id => characters(:flappy).id
    assert_redirected_to login_url
  end  
  
  def test_add_should_be_successful
    post :add, :character_id => characters(:flappy).id
    assert_response :success
  end
  
  def test_add_should_increment_user_action_points
    current_ap = characters(:flappy).current_surges_remaining
    post :add, :character_id => characters(:flappy).id
    assert_equal  current_ap + 1, Character.find(characters(:flappy).id).current_surges_remaining
  end
  
  def test_succesful_add_should_return_current_action_points
    Character.any_instance.expects(:current_surges_remaining).at_least(1).returns(2)
    post :add, :character_id => characters(:flappy).id
    assert_equal '2', @response.body
  end  
  
  def test_failing_add_should_respond_with_negative_message
    Character.any_instance.expects(:save).returns(false)
    post :add, :character_id => characters(:flappy).id
    assert_equal 'Failed to save character!', @response.body
  end
  
  def test_remove_should_be_successful
    post :add, :character_id => characters(:flappy).id
    assert_response :success
  end  

  def test_remove_should_increment_user_action_points
    current_ap = characters(:flappy).current_surges_remaining
    post :remove, :character_id => characters(:flappy).id
    assert_equal current_ap - 1, Character.find(characters(:flappy).id).current_surges_remaining
  end
  
  def test_succesful_remove_should_return_current_action_points
    Character.any_instance.expects(:current_surges_remaining).at_least(1).returns(0)
    post :remove, :character_id => characters(:flappy).id
    assert_equal '0', @response.body
  end
  
  def test_failing_remove_should_respond_with_negative_message
    Character.any_instance.expects(:save).returns(false)
    post :remove, :character_id => characters(:flappy).id
    assert_equal 'Failed to save character!', @response.body
  end  
end