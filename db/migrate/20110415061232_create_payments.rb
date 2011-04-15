class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :estimated_payment_id
      t.string :type
      t.string :check_number
      t.datetime :paid_at
      t.timestamps
    end    
  end

  def self.down
    drop_table :payments
  end
end
