class AddQrFieldToBill < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :qr_code, :string
  end
end