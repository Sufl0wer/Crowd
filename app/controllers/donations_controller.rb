class DonationsController < ApplicationController
  after_action :calculate_current_donations, only: :donate

  def index
    @invoice_link = invoice_link
  end

  def donate
    if (@donation = current_user.donations.find_by(company_id: params.dig(:company_id)))
      @donation.amount += params.dig(:donation, :amount).to_f
      @donation.save
    else
      create
    end

    redirect_back fallback_location: root_path
  end

  def create
    @donation = Donation.create amount: params.dig(:donation, :amount),
                                user_id: current_user.id,
                                company_id: params.dig(:company_id)
  end

  private

  def invoice_link
    @company = Company.find(params.dig(:company_id))
    @product = @company.products.find_by(price: params.dig(:price))
    @company.create_invoice(@product, current_user)
  end

  def calculate_current_donations
    @company = Company.find(params.dig(:company_id))
    @company.current_bank += @donation.amount
    @company.save

    check_for_rewards
  end

  def check_for_rewards
    @company.rewards.each do |reward|
      next if (current_user.rewards.include? reward)
      give_reward_to_user(reward) if (reward.price <= @donation.amount)
    end
  end

  def give_reward_to_user(reward)
    @paid_reward = PaidReward.create reward: reward,
                                     user: current_user
  end
end
