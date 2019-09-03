class ChangePaymentInBookings < ActiveRecord::Migration[5.2]
  def change
  	change_column :bookings, :payment_method, :string
  	change_column :bookings, :payment_status, :integer
  end
end
