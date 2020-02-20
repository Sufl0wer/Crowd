class Company < ApplicationRecord
  include PgSearch::Model

  belongs_to :user

  has_many :rewards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_many :news_records, dependent: :destroy

  pg_search_scope :search, against: [:name, :category, :description],
                  associated_against: {
                      rewards: [ :name, :description ],
                      comments: [:content]
                  },
                  using: {
                      tsearch: {
                          prefix: true
                      }
                  }

  validates :name, uniqueness: true, presence: true
end
