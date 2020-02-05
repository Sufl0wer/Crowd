class Company < ApplicationRecord
  belongs_to :user

  has_many :rewards, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end
