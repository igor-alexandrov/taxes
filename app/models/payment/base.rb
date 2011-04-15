class Payment::Base < ActiveRecord::Base
  set_table_name 'payments'
  
  validates_presence_of :estimated_payment_id
  validates_presence_of :paid_at
end