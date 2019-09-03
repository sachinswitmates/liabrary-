class ChangePaymentMethodTypeInBookings < ActiveRecord::Migration[5.2]
  def change
  	change_column :bookings, :payment_method, :integer
  end
end
