class AddPublishedToLibrary < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :published, :boolean, default: false
  end
end
