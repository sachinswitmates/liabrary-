class AddAddressToLibraries < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :address1, :string
    add_column :libraries, :address2, :string
    add_column :libraries, :street, :string
    add_column :libraries, :city, :string
    add_column :libraries, :landmark, :string
    add_column :libraries, :zip_code, :string
  end
end
