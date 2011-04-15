class Payment::Check < Payment::Base
  attr_accessible :estimated_payment_id, :check_number, :paid_at
  validates_presence_of :check_number
end