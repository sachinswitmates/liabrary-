class CreateQrcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :qrcodes do |t|
      t.string :code
      t.integer :booking_id
      t.timestamps
    end
  end
end
