class AddPlanIdToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :plan_id, :string
  end
end
