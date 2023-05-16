class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :seller_url
      t.text :comment
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end
