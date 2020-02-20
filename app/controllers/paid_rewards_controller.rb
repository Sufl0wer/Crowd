class PaidRewardsController < ApplicationController
  after_action :calculate_current_donations

  def create
    @paid_reward = PaidReward.create user_id: current_user.id,
                                     reward_id: params.dig(:reward_id)

  end

  private

  def calculate_current_donations

  end
end
