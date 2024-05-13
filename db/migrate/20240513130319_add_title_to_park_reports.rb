class AddTitleToParkReports < ActiveRecord::Migration[7.1]
  def change
    add_column :park_reports, :title, :string, null: false
  end
end
