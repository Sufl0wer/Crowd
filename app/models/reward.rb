class Reward < ApplicationRecord
  belongs_to :company

  has_many :paid_rewards
  has_many :users, through: :paid_rewards
end
