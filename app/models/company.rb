class Company < ApplicationRecord
  include PgSearch::Model

  DONATION_OPTIONS = [ 5, 15, 50 ] # in $
  TAP2PAY_SERVICE_MULTIPLIER = 100

  acts_as_taggable_on :tags

  belongs_to :user

  has_many :rewards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_many :news_records, dependent: :destroy
  has_many :products, dependent: :destroy

  has_many_attached :images

  pg_search_scope :search, against: [:name, :description],
                  associated_against: {
                      news_records: [:heading, :content],
                      rewards: [ :name, :description ],
                      comments: [:content],
                      tags: [:name]
                  },
                  using: {
                      tsearch: {
                          prefix: true
                      }
                  }

  validates :name, uniqueness: true, presence: true, on: :create
  validates :goal, presence: true, numericality: { greater_than: 0 }, on: :create
  validates :expiration_date, presence: true, on: :create
  validates :description, presence: true, on: :create

  validate :expiration_date_cannot_be_in_the_past, on: :create

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end

  def create_payment_options
    DONATION_OPTIONS.each do |option|
      response = Faraday.new('https://secure.tap2pay.me/api/products',
                  params: {
                      "product": {
                          "name": "#{self.name} #{option}$ donation",
                          "price_value": option * TAP2PAY_SERVICE_MULTIPLIER,
                      }
                  },
                  headers: {
                      'Content-Type' => 'application/json',
                      'Accept' => 'application/json',
                      'Authorization' => "Bearer " + ENV['TAP2PAY_API_TOKEN']
                  }
      ).post

      product = Product.create name: "#{self.name} #{option}$ donation",
                               price: "#{option}",
                               payment_link: JSON.parse(response.body)["web_checkout_link"],
                               tap2pay_product_id: JSON.parse(response.body)["id"],
                               company: self

      product.save
    end
  end

  def create_invoice(product, user)
    responce = Faraday.new('https://secure.tap2pay.me/api/invoices',
                         params: {
                             "invoice": {
                                 "description": "user: #{user.id}",
                                 "gateway_name": "string",
                                 "custom": "string",
                                 "billing_agreement": {
                                     "title": "string",
                                     "description": "string"
                                 },
                                 "items": [
                                     {
                                         "name": "#{product.name}",
                                         "description": "string",
                                         "product_id": "#{product.tap2pay_product_id}",
                                         "quantity": 1,
                                         "price_value": product.price.to_i * TAP2PAY_SERVICE_MULTIPLIER,
                                         "price_currency": "USD"
                                     }
                                 ]
                             }
                         },
                         headers: { 'Content-Type' => 'application/json',
                                    'Accept' => 'application/json',
                                    'Authorization' => "Bearer " + ENV['TAP2PAY_API_TOKEN']
                         }
    ).post

    JSON.parse(responce.body)["web_checkout_link"]
  end
end
