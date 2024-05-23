class AddDogRunAndBbqAreaToParks < ActiveRecord::Migration[7.1]
  def change
    add_column :parks, :dog_run, :integer, default: 2
    add_column :parks, :bbq_area, :integer, default: 2
  end
end