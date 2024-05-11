class CreateParkImages < ActiveRecord::Migration[7.1]
  def change
    create_table :park_images do |t|
      t.references :park, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
