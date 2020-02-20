class AddDefaultValueToCompanyCurrentBank < ActiveRecord::Migration[6.0]
  def change
    change_column_default :companies, :current_bank, 0
  end
end
