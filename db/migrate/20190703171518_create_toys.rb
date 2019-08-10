class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :name
      t.string :edition
      t.string :color
      t.string :designer
      t.string :brand
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
