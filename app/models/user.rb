class User < ApplicationRecord
  has_many :companies, dependent: :destroy

  has_many :rewards

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  validates :username, uniqueness: true, presence: true

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      elsif (data = session['devise.vkontakte_data'] && session['devise.vkontakte_data']['extra']['raw_info'])
        byebug
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      unless (user.email = auth.info.email)
        user.email = 'noemail@gmail.com'
      end
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name # assuming the user model has a name
    end
  end
end
