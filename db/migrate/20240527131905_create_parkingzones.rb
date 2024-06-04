class CreateParkingzones < ActiveRecord::Migration[6.0]
  def change
    create_table :parkingzones do |t|
      t.string :name
      t.decimal :latitude, precision: 10, scale: 7
      t.decimal :longitude, precision: 10, scale: 7
      t.integer :total_slots
      t.integer :free_slots
      t.integer :incharge_user_id
      t.integer :fare1 # < 6 hrs
      t.integer :fare2 # < 12 hrs
      t.integer :fare3 # >= 12 hrs 
      t.timestamps
    end
  end
end