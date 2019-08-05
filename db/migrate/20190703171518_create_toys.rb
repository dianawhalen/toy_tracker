class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :name
      t.string :edition
      t.integer :designer_id
      t.timestamps null: false
    end
  end
end
