class CreateParkReports < ActiveRecord::Migration[7.1]
  def change
    create_table :park_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.references :park, null: false, foreign_key: true
      t.references :tokyo_ward, null: false, foreign_key: true

      t.date :date
      t.text :comment

      t.timestamps
    end
  end
end
