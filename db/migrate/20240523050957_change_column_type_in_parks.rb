class ChangeColumnTypeInParks < ActiveRecord::Migration[7.1]
  def change
    change_column :parks, :fee, :string
  end
end
