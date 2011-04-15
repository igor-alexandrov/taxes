class EstimatedPayment < ActiveRecord::Base
  belongs_to :schedule, :class_name => 'Schedule::Base'
  belongs_to :payment, :class_name => 'Payment::Base'
    
  named_scope :unpaid, :conditions => [ %Q{ "#{self.table_name}".'payment_id' IS NULL }]
  named_scope :paid, :conditions => [ %Q{ "#{self.table_name}".payment_id IS NOT NULL }]  
  
  def validate
    if self.amount_changed?
      if amount_was == nil
        self.errors.add_to_base(:amount_cannot_be_reduced) if (self.estimated_amount_was > self.amount)
      else
        self.errors.add_to_base(:amount_cannot_be_reduced) if (self.amount_was > self.amount)
      end
      
      self.errors.add_to_base(:amount_cannot_be_more_then_annual_amount) if (self.schedule.annual_amount < self.amount)
      self.errors.add_to_base(:amount_cannot_be_more_then_dept_amount) if (self.schedule.debt_amount < self.amount)
      self.errors.add_to_base(:amount_is_too_big) if (self.schedule.not_overriden_amount < self.amount)
    end
  end
  
  def before_create
    self.due_at = closest_business_day(self.raw_due_at)
  end
  
  def after_update
    if self.amount_changed?
      self.schedule.replan_estimated_payments!
    end
  end
  
  def amount
    self.read_attribute(:amount).nil? ? self.estimated_amount : self.read_attribute(:amount)
  end
  
  def overriden?
    self.read_attribute(:amount).present?
  end
  
  def unpaid?
    self.payment_id.nil?
  end
  
  def paid?
    !self.unpaid?
  end  
  
  def pay!(payment)
    self.payment_id = payment.id
    self.save(false)
  end
  
  protected
  def closest_business_day(date)    
    while (date.to_date.holiday?(:us) || !date.to_date.workday?) do
      date -= 1.day
    end     
    return date   
  end
end