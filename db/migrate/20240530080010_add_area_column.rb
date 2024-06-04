class AddAreaColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :parkingzones, :area, :string
  end
end
