class UsersController < ApplicationController
  def show
    @company = Company.new
    @companies = current_user.companies
    @rewards = current_user.rewards
  end
end
