class AddPaymentIdToBookings < ActiveRecord::Migration[5.2]
  def change
  	add_column :bookings, :razorpay_payment_id, :string
  end
end
