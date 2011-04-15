class SchedulesController < ApplicationController
  def show
    @schedule = Schedule::Base.find(params[:id], :include => { :estimated_payments => :payment })
  end
  
  def new
    @schedule = Schedule::Base.new
  end
  
  def create
    type = params[:schedule].delete(:type)
    if type.constantize.superclass == Schedule::Base
      @schedule = type.constantize.new(params[:schedule])
      if @schedule.save
        redirect_to schedule_url(@schedule)
      else
        render :action => :new
      end
    else
      @schedule = Schedule::Base.new
      @schedule.errors.add_to_base(:incorrect_type_of_schedule)
      render :action => :new
    end
  end  
end