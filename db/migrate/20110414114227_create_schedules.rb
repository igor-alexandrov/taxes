class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.float :annual_amount
      t.string :type
      t.datetime :first_payment_at
    end
    
    add_index :schedules, :type
  end

  def self.down
    drop_table :schedules
  end
end
