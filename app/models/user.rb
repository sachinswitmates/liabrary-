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

  enum role: [:admin, :library_owner ]
   
end
