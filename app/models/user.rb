class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :sns_credentials, dependent: :destroy
  has_many :park_reports
  
  validates :name, presence: true

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
end
