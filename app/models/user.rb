class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  
  validates :nickname, :gender, :birthday, presence: true
  mount_uploader :image, ImagesUploader
  acts_as_followable
  acts_as_follower
  has_many :posts, dependent: :destroy
  has_many :sns_auths, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
    
      if user.present?
        sns = SnsAuth.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsAuth.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

   def self.with_sns_data(auth, snsauth)
    user = User.where(id: snsauth.user_id).first
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

   def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snsauth = SnsAuth.where(uid: uid, provider: provider).first
    if snsauth.present?
      user = with_sns_data(auth, snsauth)[:user]
      sns = snsauth
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end
  
end
