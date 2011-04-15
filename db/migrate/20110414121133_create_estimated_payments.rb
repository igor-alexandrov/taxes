class CreateEstimatedPayments < ActiveRecord::Migration
  def self.up
    create_table :estimated_payments do |t|
      t.integer :schedule_id
      
      t.float :estimated_amount
      t.float :amount
      
      t.date :raw_due_at
      t.date :due_at
      
      t.integer :payment_id
      
      t.timestamps
    end
    
    add_index :estimated_payments, :schedule_id
  end

  def self.down
    drop_table :estimated_payments
  end
end
