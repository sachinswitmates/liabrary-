class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  attr_accessor :avatar       
  
  #Validations

  # Associations
  has_many :libraries
  has_one :image, :as => :imageable
  has_one :bank_account
  has_many :bookings
  #has_many :libraries, :through => :bookings


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
   

end
