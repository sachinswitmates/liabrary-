class User < ApplicationRecord
  ratyrate_rater
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :first_name, presence: true
  validates :last_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook,:google_oauth2]
  
  attr_accessor :avatar       

  # Associations
  #has_many :libraries
  has_one :image, :as => :imageable
  has_one :bank_account
  has_many :bookings
  has_many :owned_libraries, class_name: 'Library'
  has_many :libraries, :through => :bookings
  has_many :reviews

  enum role: [:admin, :library_owner, :student]

  def user_name
    "#{self.first_name} #{self.last_name}"
  end

  def send_notification_email
    UserMailer.notify_library_owner(self).deliver_now
    UserMailer.notify_admin(User.admin_user).deliver_now
  end

  def self.admin_user
    self.where(role: 'admin').first
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
  end
end

