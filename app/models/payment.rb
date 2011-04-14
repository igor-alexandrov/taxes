class Payment < ActiveRecord::Base
  
  class Payment::Status < ::Taxes::Status; end    
  Payment::Status::UNPAID = Payment::Status.new('u', 'Unpaid')  unless defined? UNPAID
  Payment::Status::PAID = Payment::Status.new('p', 'Paid')  unless defined? PAID
  
  default_value_for :status, Payment::Status::UNPAID.key
  
  def validate
    if self.amount_changed?
      if amount_was == nil
        self.errors.add_to_base(:amount_cannot_be_reduced) if (self.estimated_amount_was > self.amount)
      else
        self.errors.add_to_base(:amount_cannot_be_reduced) if (self.amount_was > self.amount)
      end
    end
  end
  
  def before_create
    self.due_at = closest_business_day(self.raw_due_at)
  end
  
  def after_update
    if self.amount_changed?
      
    end
  end
  
  def amount
    self.read_attribute(:amount).nil? ? self.estimated_amount : self.read_attribute(:amount)
  end
  
  protected
  def closest_business_day(date)    
    while (date.to_date.holiday?(:us) || !date.to_date.workday?) do
      date -= 1.day
    end     
    return date   
  end
end