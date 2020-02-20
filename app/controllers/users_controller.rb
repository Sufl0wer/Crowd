class UsersController < ApplicationController
  def show
    @company = Company.new
    @companies = current_user.companies
  end
end
