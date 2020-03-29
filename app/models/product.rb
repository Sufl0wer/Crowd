class Product < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, on: :create
  validates :payment_link, presence: true, on: :create
end
