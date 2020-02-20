class ChangeMoneyCulumnsToFloat < ActiveRecord::Migration[6.0]
  def change
    remove_column :companies, :goal
    add_column :companies, :goal, :float, default: 0

    remove_column :companies, :current_bank
    add_column :companies, :current_bank, :float, default: 0

    remove_column :donations, :amount
    add_column :donations, :amount, :float

    remove_column :rewards, :price
    add_column :rewards, :price, :float
  end
end
