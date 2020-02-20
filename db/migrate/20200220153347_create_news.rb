class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news_record do |t|
      t.text :content
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
