
class OpenidsController < ApplicationController

  def new
    # just display the login form
  end
  
  def create
    openid_url = params[:openid_url]
    response = openid_consumer.begin openid_url
    
    response.add_extension_arg('sreg', 'required', 'email,nickname')
    trust_domain = home_url
    logger.debug "trust domain: #{trust_domain}" if logger.debug?
    redirect_url = response.redirect_url(trust_domain, complete_openid_url)
    redirect_to redirect_url and return
  end
  
  def complete
    response = openid_consumer.complete params.reject{|k,v|request.path_parameters[k]}, complete_openid_url
        
    if response.status == OpenID::Consumer::SUCCESS
      session[:openid] = response.identity_url
      cookies[:openid] = {:value => session[:openid]}
      @registration_info = response.extension_response('openid.sreg', true)
      logger.debug "reg info: #{@registration_info}" if logger.debug?
      
      u = User.find_by_openid_url(session[:openid])
      if(!u.nil?)
        session[:user_id] = u.id
        redirect_to characters_url and return
      end
      
      if(!@registration_info.nil?)
        u = User.new
        u.openid_url = session[:openid]
        u.name = @registration_info['nickname']
        u.email = @registration_info['email']
        if u.save
          redirect_to characters_url and return
        end
      end
      
      redirect_to new_user_url and return
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