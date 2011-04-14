ActionController::Routing::Routes.draw do |map|
  map.resources :schedules do |schedules|
    schedules.resources :payments,
      :member => [:override_estimated_amount, :update_estimated_amount]
  end
  
  map.root :controller => 'home', :action => 'index'
end
