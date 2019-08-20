class AddPaymentToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :payment, :integer
  end
end
