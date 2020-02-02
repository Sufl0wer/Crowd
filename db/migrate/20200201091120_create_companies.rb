class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.string :goal
      t.string :theme
      t.date :expiration_date

      t.timestamps
    end
  end
end
