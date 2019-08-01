class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :name
      t.integer :user_id
      t.integer :designer_id
      t.timestamps null: false
    end
  end
end
