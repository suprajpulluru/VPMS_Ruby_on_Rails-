class CreateParkingslots < ActiveRecord::Migration[6.0]
  def change
    create_table :parkingslots do |t|
      t.integer :parkingzone_id
      t.integer :slot_number
      t.boolean :status, default: false
      t.timestamps
    end
  end
end
