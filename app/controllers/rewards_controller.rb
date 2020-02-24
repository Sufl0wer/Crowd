class RewardsController < ApplicationController
  before_action :set_reward, only: [:edit, :update, :destroy]

  def new
    @reward = Reward.new
  end

  def edit
    @reward = Reward.find params.dig(:id)
  end

  def create
    @reward = Reward.create name: reward_params.dig(:name),
                            price: reward_params.dig(:price),
                            description: reward_params.dig(:description),
                            company_id:  params.dig(:company_id)

    @reward.save

    redirect_to company_path(id:  params.dig(:company_id))
  end

  def update
    @reward.update(reward_params)

    redirect_back fallback_location: root_path
  end

  def destroy
    @reward.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:name, :price, :description)
  end
end
