class RenamePrepaidAmount < ActiveRecord::Migration[6.0]
  def change
    rename_column :bills, :prepaid_amount, :amount
  end
end
