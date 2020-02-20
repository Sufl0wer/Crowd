class AddDefaultValueToDonationAmount < ActiveRecord::Migration[6.0]
  def change
    change_column_default :donations, :amount, 0
  end
end
