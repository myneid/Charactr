ActionController::Routing::Routes.draw do |map|
  map.resources :campaigns

  map.resources :users

  map.resources :characters

  map.resource :openid, :member => {:complete => :get}

  map.login ':controller/:action', :controller => 'openids', :action => 'new'
  map.home ':controller', :controller => 'openids', :action => 'new'
  map.add_action_point 'characters/:id/action_point/add', :controller => 'characters', :action => 'action_point', :add => 'true'
  map.remove_action_point 'characters/:id/action_point/remove', :controller => 'characters', :action => 'action_point', :add => 'false'
   map.add_healing_surge_value 'characters/:id/healing_surge_value/add', :controller => 'characters', :action => 'healing_surge_value', :add => 'true'
  map.remove_healing_surge_value 'characters/:id/healing_surge_value/remove', :controller => 'characters', :action => 'healing_surge_value', :add => 'false'

  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  
  map.connect '', :controller => 'openids', :action => :new
end
