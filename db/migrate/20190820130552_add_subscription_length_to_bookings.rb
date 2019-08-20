class AddSubscriptionLengthToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :subscription_length, :string
  end
end
