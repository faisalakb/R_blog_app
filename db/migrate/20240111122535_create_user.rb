class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.string :name
      t.string :photo
      t.string :text
      t.integer :postCounter

      t.timestamps
    end
  end
end
