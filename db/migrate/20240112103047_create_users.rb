class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :
      t.string :photo
      t.string :
      t.string :bio
      t.text :
      t.string :posts_counter
      t.integer :

      t.timestamps
    end
  end
end
