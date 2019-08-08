class AddContactNumberToLibrary < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :contact_number, :string
  end
end
