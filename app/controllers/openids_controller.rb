
class OpenidsController < ApplicationController

  def new
    # just display the login form
  end
  
  def create
    openid_url = params[:openid_url]
    response = openid_consumer.begin openid_url
    
    response.add_extension_arg('sreg', 'required', 'email,nickname')
    trust_domain = url_for(:controller => 'openid')
    logger.debug "trust domain: #{trust_domain}" if logger.debug?
    redirect_url = response.redirect_url(trust_domain, complete_openid_url)
    redirect_to redirect_url and return
  end
  
  def complete
    response = openid_consumer.complete params.reject{|k,v|request.path_parameters[k]}, complete_openid_url
        
    if response.status == OpenID::Consumer::SUCCESS
      session[:openid] = response.identity_url
      @registration_info = response.extension_response('sreg', false)
      logger.debug "reg info: #{@registration_info}" if logger.debug?
      
      redirect_to characters_url and return
    end
    
    # TODO(sholder) handle other states more gracefully
    flash[:error] = 'Could not log on with your OpenID'
    redirect_to new_openid_url
  end
  
  protected
  
  def openid_consumer
    @openid_consumer ||= OpenID::Consumer.new(session,
      OpenID::Store::Filesystem.new("#{RAILS_ROOT}/tmp/openid"))
  end

end