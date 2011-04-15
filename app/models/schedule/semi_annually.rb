class Schedule::SemiAnnually < Schedule::Base
  def plan_estimated_payments!
    return if self.estimated_payments.any?

    per_payment_amount = (self.annual_amount  / 2.0).round(2)
    last_raw_due_at = self.first_payment_at
    ActiveRecord::Base.transaction do
      3.times do
        sum = 0
        2.times do |i|
          if i != 11        
            payment = self.estimated_payments.new(:estimated_amount => per_payment_amount, :raw_due_at => last_raw_due_at)
          else
            payment = self.estimated_payments.new(:estimated_amount => (self.annual_amount - sum), :raw_due_at => last_raw_due_at)
          end        
          payment.save
          sum += payment.estimated_amount

          last_raw_due_at += 6.month
        end
      end
    end
  end
end