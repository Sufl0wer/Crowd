class AdminsController < ApplicationController
  before_action :admin_check
  before_action :set_user, only: [:destroy, :change_role]

  def users_list
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_back fallback_location: root_path, notice: 'User was successfully deleted.'
  end

  def block_user

  end

  def change_role
    @user.role =
        if @user.role == 'user'
          'admin'
        else
          'user'
        end
    @user.save

    redirect_back fallback_location: root_path, notice: 'Admin was successfully added.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def admin_check
    if current_user.role != 'admin'
      render plain: "403 Permission Denied", status: 403
    end
  end
end

