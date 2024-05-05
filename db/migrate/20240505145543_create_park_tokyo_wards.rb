class CreateParkTokyoWards < ActiveRecord::Migration[7.1]
  def change
    create_table :park_tokyo_wards do |t|
      t.references :park, null: false, foreign_key: true
      t.references :tokyo_ward, null: false, foreign_key: true

      t.timestamps
    end

    add_index :park_tokyo_wards, [:park_id, :tokyo_ward_id], unique: true
  end
end
