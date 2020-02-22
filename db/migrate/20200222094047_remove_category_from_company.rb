class RemoveCategoryFromCompany < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :category
  end
end
