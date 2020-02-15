class Company < ApplicationRecord
  belongs_to :user

  has_many :rewards, dependent: :destroy
  has_many :comments

  validates :name, uniqueness: true, presence: true
end
