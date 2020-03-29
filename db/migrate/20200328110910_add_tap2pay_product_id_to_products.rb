class AddTap2payProductIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :tap2pay_product_id, :string
  end
end
