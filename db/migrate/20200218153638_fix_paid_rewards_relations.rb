class FixPaidRewardsRelations < ActiveRecord::Migration[6.0]
  def change
    rename_column :paid_rewards, :users_id, :user_id
    rename_column :paid_rewards, :rewards_id, :reward_id
  end
end
