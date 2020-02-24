class Donation < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
