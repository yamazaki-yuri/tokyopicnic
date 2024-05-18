class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :sns_credentials, dependent: :destroy
  has_many :park_reports
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_parks, through: :bookmarks, source: :park
  
  validates :name, presence: true
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    sns_credential = SnsCredential.find_by(provider: auth.provider, uid: auth.uid)
    if sns_credential
      return sns_credential.user
    else
      user = User.find_or_create_by(email: auth.info.email) do |u|
        u.name = auth.info.name
        u.password = Devise.friendly_token[0, 20]
      end
      user.sns_credentials.create(provider: auth.provider, uid: auth.uid)
      return user
    end
  end

  def own?(object)
    id == object&.user_id
  end

  def bookmark(park)
    bookmark_parks << park
  end

  def unbookmark(park)
    bookmark_parks.destroy(park)
  end

  def bookmark?(park)
    bookmark_parks.include?(park)
  end
end
