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
end
