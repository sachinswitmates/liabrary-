class Booking < ApplicationRecord
  
  #validations
  validates :name, presence: true
  validates :email, presence: true
  validates :contact_number, presence: true
  validates :seats, presence: true
  validates :package, presence: true
   
  #associations
  belongs_to :user, optional:true
  belongs_to :library, optional:true

end
    