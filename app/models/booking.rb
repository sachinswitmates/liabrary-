class Booking < ApplicationRecord

  #validations
  validate :validate_package
   
  #associations
  belongs_to :user, optional:true
  belongs_to :library, optional:true
  has_one :qrcode

  # Callbacks
  after_create :update_availability
  after_create :update_subscription_date

  def update_availability
    if library.availability > 0
      library.decrement!(:availability)
      library.increment!(:booked_seats)
    end
  end 

  def update_subscription_date
    self.start_date = Time.now
    self.end_date = calcuate_subscription_end
    self.save
  end 
  
  def subscription_type
    if self.subscription_length == 'monthly'
      1
    elsif self.subscription_length == 'quaterly'
      3
    elsif self.subscription_length == 'halfyearly'
      6
    elsif self.subscription_length == 'yearly'
      12
    end
  end

  def calcuate_subscription_end
    if subscription_type == 1
      Time.now + 30.days
    elsif subscription_type == 3
      Time.now + 90.days
    elsif subscription_type == 6
      Time.now + 180.days
    elsif subscription_type == 12
      Time.now + 364.days
    end
  end


  def validate_package
    unless package.present? 
      errors.add(:package, "You have to pick atleast one package ")
    end
  end


  def send_booking_notification_email
    UserMailer.notify_student(self.user).deliver_now
    library_owner = User.find_by(id: self.library&.user_id)
    UserMailer.notify_booking_library_owner(library_owner).deliver_now if library_owner
  end


end
    