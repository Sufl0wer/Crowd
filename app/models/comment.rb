class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :user

  def as_json(options)
    # if self.image.attached?
      super(options).merge(username: user.username)
    # else
    #   super(options).merge(user_avatar_url: user.gravatar_url,
    #                        username: user.username)
    # end
  end
end
