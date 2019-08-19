class Booking < ApplicationRecord

  #validations
  validates :name, presence: true
  validates :email, presence: true
  validates :contact_number, presence: true
  #validates :seats, presence: true
  validates :package, presence: true
   
  #associations
  belongs_to :user, optional:true
  belongs_to :library, optional:true

  # Callbacks
  after_create :update_availability

  def update_availability
    if library.availability > 0
      library.decrement!(:availability)
      library.increment!(:booked_seats)
    end
  end  

end
    