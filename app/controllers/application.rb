# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_charactr_session_id'
  
  protected
  
  def is_logged_in?
    !session[:openid].nil?
  end
  
  def ensure_logged_in
    redirect_to login_url and return false unless is_logged_in?
    true
  end
  
  def ensure_user_valid
    if ensure_logged_in
      redirect_to new_user_url and return false unless !session[:user_id].nil?
    end
    true
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id])
    @current_user
  end
  
  def load_character
    @character = Character.find(params[:character_id])
  end
  
end
