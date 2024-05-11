class CreateReportImages < ActiveRecord::Migration[7.1]
  def change
    create_table :report_images do |t|
      t.references :park_report, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
