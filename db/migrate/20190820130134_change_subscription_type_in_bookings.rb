class ChangeSubscriptionTypeInBookings < ActiveRecord::Migration[5.2]
  def change
  	change_column :bookings, :subscription_length, :string
  end
end
