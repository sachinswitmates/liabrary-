class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :email
      t.string :contact_number
      t.integer :seats
      t.string :package
      t.integer :user_id
      t.integer :library_id
      
      t.timestamps
    end
    add_index :bookings, [:user_id, :library_id]
  end
end
