class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :schedule_id
      
      t.string :status
      
      t.float :estimated_amount
      t.float :amount
      
      t.date :raw_due_at
      t.date :due_at
      
      t.timestamps
    end
    
    add_index :payments, :schedule_id
  end

  def self.down
    drop_table :payments
  end
end
