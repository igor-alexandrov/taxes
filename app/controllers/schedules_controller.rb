class SchedulesController < ApplicationController
  def show
    @schedule = Schedule.find(params[:id])
  end
  
  def new
    @schedule = Schedule.new
  end
  
  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.save
      redirect_to schedule_url(@schedule)
    else
      render :action => :new
    end
  end  
end