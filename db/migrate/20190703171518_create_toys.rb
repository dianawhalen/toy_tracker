class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|

      t.timestamps null: false
    end
  end
end
