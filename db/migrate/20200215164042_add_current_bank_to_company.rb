class AddCurrentBankToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :current_bank, :string
  end
end
