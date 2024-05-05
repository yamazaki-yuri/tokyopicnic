class CreateParks < ActiveRecord::Migration[7.1]
  def change
    create_table :parks do |t|
      t.string :name,                    null: false
      t.string :googlemaps_place_id,     null: false
      t.string :website_url

      t.timestamps
    end
    add_index :parks, :googlemaps_place_id, unique: true
  end
end
