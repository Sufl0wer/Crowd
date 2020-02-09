class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]

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
    redirect_back fallback_location: root_path
  end

  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to @reward, notice: 'Reward was successfully updated.' }
        format.json { render :show, status: :ok, location: @reward }
      else
        format.html { render :edit }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Reward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:name, :price, :description)
  end
end
