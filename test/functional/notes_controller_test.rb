require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  def setup
    login_user(:myneid)
    @c = characters(:flappy)
  end

  def test_should_get_index
    get :index, :character_id => @c.id
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  def test_should_get_new
    get :new, :character_id => @c.id
    assert_response :success
  end

  def test_should_create_note
    assert_difference('Note.count') do
      post :create, {:note => {:details => 'blah blah blah blah' }, :character_id => @c.id}
    end

    assert_redirected_to character_path(@c)
  end

  def test_should_show_notes
    get :show, {:id => notes(:flappy_found_note).id, :character_id => @c.id}
    assert_response :success
  end

  def test_should_get_edit
    get :edit, {:id => notes(:flappy_found_note).id, :character_id => @c.id}
    assert_response :success
  end

  def test_should_update_notes
    put :update, {:id => notes(:flappy_found_note).id, :note => { }, :character_id => @c.id}
    assert_redirected_to character_path(@c)
  end

  def test_should_destroy_note
    assert_difference('Note.count', -1) do
      delete :destroy, {:id => notes(:flappy_found_note).id, :character_id => @c.id}
    end

    assert_redirected_to character_path(@c)
  end
end
