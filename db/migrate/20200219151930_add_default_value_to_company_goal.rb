class AddDefaultValueToCompanyGoal < ActiveRecord::Migration[6.0]
  def change
    change_column_default :companies, :goal, 0
  end
end
