class RemoveFare3Column < ActiveRecord::Migration[6.0]
  def change
    remove_column :parkingzones, :fare3
  end
end
