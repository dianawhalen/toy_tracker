class CreateDesigners < ActiveRecord::Migration
  def change
    create_table :designers do |t|

      t.timestamps null: false
    end
  end
end
