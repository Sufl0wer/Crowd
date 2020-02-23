class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :user

  def as_json(options)
    super(options).merge(username: user.username, updated_at: self.updated_at.to_s)
  end
end
