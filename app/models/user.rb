class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #validates :status, presence: true
  after_create :send_email
  has_many :wishlists, dependent: :destroy
  has_many :orders
  has_many :addresses
  devise :omniauthable, :omniauth_providers => [:facebook,:google_oauth2,:twitter]
  has_many :cart_items
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.firstname = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end
  
  def send_email
    UserMailer.welcome_email(self).deliver
  end       
end
