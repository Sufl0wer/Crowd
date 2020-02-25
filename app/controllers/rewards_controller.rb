class RewardsController < ApplicationController
  before_action :set_reward, only: [:edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

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

    if @reward.save
      redirect_to company_path(id:  params.dig(:company_id))
    else
      render 'rewards/new'
    end
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

  def check_owner
    if Company.find(params[:company_id]).user != current_user && current_user.role != 'admin'
      redirect_back fallback_location: root_path, alert: "You cannot do this on company that not belongs to you!"
    end
  end
end
