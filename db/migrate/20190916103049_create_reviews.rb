class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.integer :user_id
      t.integer :library_id
      t.timestamps
    end
    add_index :reviews, [:user_id, :library_id]
  end
end
