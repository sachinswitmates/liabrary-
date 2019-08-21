class ChangePaymentTypeInBookings < ActiveRecord::Migration[5.2]
  def change
  	change_column :bookings, :payment, :string
  end
end
