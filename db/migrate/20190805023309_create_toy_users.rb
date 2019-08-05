class CreateToyUsers < ActiveRecord::Migration
  def change
    create_table :toy_users do |t|
      t.integer :toy_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
