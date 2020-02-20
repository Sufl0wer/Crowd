class DonationsController < ApplicationController
  after_action :calculate_current_donations

  def create
    @donation = Donation.create amount: params.dig(:donation, :amount),
                                user_id: current_user.id,
                                company_id: params.dig(:company_id)
  end

  private

  def calculate_current_donations
    @company = Company.find(params.dig(:company_id))
    @company.current_bank += @donation.amount
    @company.save
  end
end
