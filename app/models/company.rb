class Company < ApplicationRecord
  belongs_to :user

  validates :name, uniqueness: true, presence: true
end
