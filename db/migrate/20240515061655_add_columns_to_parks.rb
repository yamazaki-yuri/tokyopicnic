class AddColumnsToParks < ActiveRecord::Migration[7.1]
  def change
    add_column :parks, :fee, :integer
    add_column :parks, :food_allowed, :integer, default: 2
    add_column :parks, :alcohol_allowed, :integer, default: 2
    add_column :parks, :sheet_available, :integer, default: 2
    add_column :parks, :bringing_in_play_equipment, :integer, default: 2
  end
end
