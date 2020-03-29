class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :payment_link
      t.belongs_to :company

      t.timestamps
    end
  end
end
