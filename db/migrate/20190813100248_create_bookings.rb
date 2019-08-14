class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :email
      t.string :contact_number
      t.integer :seats
      t.string :package
      t.references :user, foreign_key: true
      t.references :library, foreign_key: true
      
      t.timestamps
    end
  end
end
