class Payment::Transfer < Payment::Base
  attr_accessible :estimated_payment_id, :paid_at
  
  def validate
    self.errors.add_to_base(:check_number_should_be_null_in_trasfer_payment) if self.check_number.present?
  end
end