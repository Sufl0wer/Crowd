class Company < ApplicationRecord
  include PgSearch::Model

  acts_as_taggable_on :tags

  belongs_to :user

  has_many :rewards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_many :news_records, dependent: :destroy

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

  validates :name, uniqueness: true, presence: true
  validates :goal, presence: true
  validates :expiration_date, presence: true
  validates :description, presence: true
end
