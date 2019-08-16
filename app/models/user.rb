class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

            
  attr_accessor :avatar       
  
  #Validations

  # Associations
  #has_many :libraries
  has_one :image, :as => :imageable
  has_one :bank_account
  has_many :bookings
  has_many :libraries, :through => :bookings


  enum role: [:admin, :library_owner, :student]

  def user_name
    "#{self.first_name} #{self.last_name}"
  end

  def send_notification_email
    UserMailer.notify_admin(User.admin_user).deliver_now
    UserMailer.notify_library_owner(self).deliver_now
  end

  def self.admin_user
    self.where(role: 'admin').first
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    #user.skip_confirmation!
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
 
end

