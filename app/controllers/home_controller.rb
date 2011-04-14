class HomeController < ApplicationController
  def index
    redirect_to :controller => 'schedules', :action => 'new'
  end
end