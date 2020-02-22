class AddHeadingColumnToNewsRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :news_records, :heading, :string
  end
end
