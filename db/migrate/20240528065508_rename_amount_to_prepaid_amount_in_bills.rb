class RenameAmountToPrepaidAmountInBills < ActiveRecord::Migration[6.0]
  def change
    rename_column :bills, :amount, :prepaid_amount
  end
end
