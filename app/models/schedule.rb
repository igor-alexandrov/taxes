class Schedule < ActiveRecord::Base
  has_many :payments
  
  def after_create
    self.plan_payments!
  end
  
  
  
  def plan_payments!
    return if self.payments.any?
    
    per_payment_amount = (self.annual_amount  / 12.0).round(2)
    last_raw_due_at = self.first_payment_at
    3.times do
      sum = 0
      12.times do |i|
        if i != 11        
          payment = self.payments.new(:estimated_amount => per_payment_amount, :raw_due_at => last_raw_due_at)
        else
          payment = self.payments.new(:estimated_amount => (self.annual_amount - sum), :raw_due_at => last_raw_due_at)
        end        
        payment.save
        sum += payment.estimated_amount
      
        last_raw_due_at += 1.month
      end
    end
  end
end