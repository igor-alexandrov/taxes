class PaymentsController < ApplicationController
  before_filter :find_payment
  
  def override_estimated_amount    
    if request.xhr?
      render :partial => 'override_estimated_amount'
    end
  end
  
  def update_estimated_amount
    if @payment.update_attributes(params[:payment])
      respond_to do |format|
        format.js {
          render :update do |page|
            page << "window.location.replace('#{schedule_path(@payment.schedule_id)}');"
          end
        }
      end      
    else
      respond_to do |format|
        format.js {
          render :update do |page|
            page << "$('#payment-form-status').replaceWith('#{escape_javascript(render :partial => '/shared/errors', :locals => { :object => @payment })}');"
          end
        }
      end      
    end
  end
  
  protected
  def find_payment
    @payment = Payment.find(params[:id])
  end
end