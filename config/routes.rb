ActionController::Routing::Routes.draw do |map|
  map.resources :schedules do |schedules|
    schedules.resources :payments,
      :member => {
        :override_estimated_amount => :get,
        :update_amount => :post,
        :payment_form_for => :get,
        :pay_for => :post
      }
  end
  
  map.root :controller => 'home', :action => 'index'
end
