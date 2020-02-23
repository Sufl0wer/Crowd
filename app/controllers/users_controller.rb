class UsersController < ApplicationController
  def show
    @user = current_user
    @company = Company.new
    @companies = current_user.companies
    @rewards = current_user.rewards
  end

  def change_avatar
    current_user.avatar.attach(params.dig(:user, :avatar))
    current_user.save

    redirect_back fallback_location: root_path
  end
end
