class AddActiveFieldToParkingslot < ActiveRecord::Migration[6.0]
  def change
    add_column :parkingslots, :active, :boolean, default: true
  end
end
