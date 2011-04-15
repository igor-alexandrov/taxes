class Schedule::Base < ActiveRecord::Base
  set_table_name 'schedules'
  
  has_many :estimated_payments, :foreign_key => 'schedule_id'
  
  validates_presence_of :annual_amount
  
  def after_create
    self.plan_estimated_payments!
  end
  
  def total_amount
    self.annual_amount * 3
  end
  
  def paid_amount
    self.estimated_payments.paid.collect{ |p| p.amount.round(2) }.sum
  end
  
  def not_overriden_amount
    self.estimated_payments.unpaid.select{ |p| p.read_attribute(:amount).nil? }.sum(&:estimated_amount)
  end
  
  def debt_amount
    self.total_amount - self.paid_amount
  end
    
  def plan_estimated_payments!
    raise NotImplementedError, "Implement method 'plan_estimated_payments!' in a subclass."
  end  
    
  def replan_estimated_payments!
    return if self.estimated_payments.nil?
    
    not_overriden, overriden = self.estimated_payments.unpaid.partition{ |p| p.read_attribute(:amount).nil? }    
    if not_overriden.any?
      per_estimated_payment_amount = (self.debt_amount - overriden.sum(&:amount)).to_f.round(2) / not_overriden.size
    
      EstimatedPayment.update_all("estimated_amount = #{per_estimated_payment_amount}", :id => not_overriden.collect{ |p| p.id })    
    end
  end
end