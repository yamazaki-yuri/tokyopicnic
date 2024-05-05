class CreateTokyoWards < ActiveRecord::Migration[7.1]
  def change
    create_table :tokyo_wards do |t|
      t.string :name,               null: false
      t.float :latitude,            null: false
      t.float :longitude,           null: false

      t.timestamps
    end
  end
end
