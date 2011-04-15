class Schedule::Annually < Schedule::Base
  def plan_estimated_payments!
    return if self.estimated_payments.any?

    last_raw_due_at = self.first_payment_at
    ActiveRecord::Base.transaction do
      3.times do
        payment = self.estimated_payments.new(:estimated_amount => self.annual_amount.round(2), :raw_due_at => last_raw_due_at)
        payment.save
      
        last_raw_due_at += 12.month
      end
    end
  end
end