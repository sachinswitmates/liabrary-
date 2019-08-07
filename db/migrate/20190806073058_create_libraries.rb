class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :address
      t.string :open
      t.string :seats
      t.string :availability
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
