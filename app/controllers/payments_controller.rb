class PaymentsController < ApplicationController
  before_filter :find_payment
  
  def override_estimated_amount    
    if request.xhr?
      render :partial => 'override_estimated_amount'
    end
  end
  
  def update_amount
    if @estimated_payment.update_attributes(params[:payment])
      respond_to do |format|
        format.js {
          render :update do |page|
            page << "window.location.replace('#{schedule_path(@estimated_payment.schedule_id)}');"
          end
        }
      end      
    else
      respond_to do |format|
        format.js {
          render :update do |page|
            page << "$('#estimated_payment-form-status').replaceWith('#{escape_javascript(render :partial => '/shared/errors', :locals => { :object => @estimated_payment })}');"
          end
        }
      end      
    end
  end
  
  def payment_form_for
    @payment = @estimated_payment.build_payment
    @payment.paid_at = @estimated_payment.due_at
    render :partial => 'payment_form_for'
  end
  
  def pay_for
    type = params[:payment].delete(:type)
    if type == 'check'
      @payment = Payment::Check.new(params[:payment])
    elsif type == 'transfer'
      @payment = Payment::Transfer.new(params[:payment])
    end
    @payment.estimated_payment_id = @estimated_payment.id
    
    if @payment.save
      @estimated_payment.pay!(@payment)
          
      respond_to do |format|
        format.js {
          render :update do |page|
            page << "window.location.replace('#{schedule_path(@estimated_payment.schedule_id)}');"
          end
        }
      end
    else
      respond_to do |format|
        format.js {
          render :update do |page|
            page << "$('#payment_base-form-status').replaceWith('#{escape_javascript(render :partial => '/shared/errors', :locals => { :object => @payment })}');"
          end
        }
      end            
    end
  end
  
  protected
  def find_payment
    @estimated_payment = EstimatedPayment.find(params[:id])
  end
end