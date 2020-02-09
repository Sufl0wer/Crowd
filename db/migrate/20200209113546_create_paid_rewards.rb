class CreatePaidRewards < ActiveRecord::Migration[6.0]
  def change
    change_table :rewards do |t|
      t.remove :user_id
    end

    create_table :paid_rewards do |t|
      t.belongs_to :users
      t.belongs_to :rewards
      t.timestamps
    end
  end
end
