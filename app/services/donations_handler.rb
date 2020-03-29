class DonationsHandler
  class << self
    def handle_donation (data)
      @invoice_data = data
      @user = find_user
      @company = find_company
      if (@donation = @user.donations.find_by(company_id: @company))
        @donation.amount += data["data"]["items"][0]["price_value"] / 100
        @donation.save
      else
        create
      end

      calculate_current_donations
    end

    private

    def create
      @donation = Donation.create amount: @invoice_data["data"]["items"][0]["price_value"] / 100,
                                  user: @user,
                                  company: @company
    end

    def find_company
      Company.find(@invoice_data["data"]["description"].match(/company: (.*?)$/)[1].to_i)
    end

    def find_user
      User.find(@invoice_data["data"]["description"].match(/user: (.*?),/)[1].to_i)
    end

    def calculate_current_donations
      @company.current_bank += @donation.amount
      @company.save

      check_for_rewards
    end

    def check_for_rewards
      @company.rewards.each do |reward|
        next if (@user.rewards.include? reward)
        give_reward_to_user(reward) if (reward.price <= @donation.amount)
      end
    end

    def give_reward_to_user(reward)
      @paid_reward = PaidReward.create reward: reward,
                                       user: @user
    end
  end
end
