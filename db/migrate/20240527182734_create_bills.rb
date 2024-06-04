class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :parkingslot_id
      t.string :vehicle_number
      t.timestamp :checkin_time
      t.timestamp :checkout_time
      t.integer :duration
      t.integer :amount
      t.timestamps
    end
  end
end
