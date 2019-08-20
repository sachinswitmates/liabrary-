class UserMailer < ApplicationMailer 
  def notify_admin(user)
    @user = user
    mail(to: @user.email, subject: 'Notification')
  end

  def notify_library_owner(user)
    @user = user
    mail(to: @user.email, subject: 'your library has created')
  end

  def notify_student(user)
    @user = user
    mail(to: @user.email, subject: 'Your Booking Has Done')
  end

  def notify_booking_library_owner(user)
    @user = user
    mail(to: @user.email, subject: 'Library has booked')
  end

end
