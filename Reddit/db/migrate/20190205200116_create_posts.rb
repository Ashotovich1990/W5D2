class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false 
      t.string :url 
      t.text :content
      t.integer :sub_id 
      t.integer :user_id
      t.timestamps
    end

    add_index :posts, :title, unique: true
    add_index :posts, :user_id, unique: true 
    add_index :posts, :sub_id, unique: true  
   
  end
end
