# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110415061232) do

  create_table "estimated_payments", :force => true do |t|
    t.integer  "schedule_id"
    t.float    "estimated_amount"
    t.float    "amount"
    t.date     "raw_due_at"
    t.date     "due_at"
    t.integer  "payment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimated_payments", ["schedule_id"], :name => "index_estimated_payments_on_schedule_id"

  create_table "payments", :force => true do |t|
    t.integer  "estimated_payment_id"
    t.string   "type"
    t.string   "check_number"
    t.datetime "paid_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.float    "annual_amount"
    t.string   "type"
    t.datetime "first_payment_at"
  end

  add_index "schedules", ["type"], :name => "index_schedules_on_type"

end
