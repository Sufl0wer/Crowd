class RenameNewsToNewsRecord < ActiveRecord::Migration[6.0]
  def change
    rename_table :news, :news_records
  end
end
