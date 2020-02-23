class AdminsController < ApplicationController
  before_action :admin_check
  before_action :set_user, only: [:destroy, :make_user_admin]

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
    @user.role = 'admin'
    @user.save
    redirect_back fallback_location: root_path, notice: 'Admin was successfully added.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def admin_check
    if current_user.role != 'admin'
      render plain: "403 Permission Denied", status: 403
    end
  end
end

