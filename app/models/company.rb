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
  validates :goal, presence: true, numericality: { greater_than: 0 }
  validates :expiration_date, presence: true
  validates :description, presence: true

  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if expiration_date.present? && expiration_date < Date.today
      errors.add(:expiration_date, "can't be in the past")
    end
  end
end
