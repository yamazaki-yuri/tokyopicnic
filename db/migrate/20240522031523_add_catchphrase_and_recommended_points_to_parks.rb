class AddCatchphraseAndRecommendedPointsToParks < ActiveRecord::Migration[7.1]
  def change
    add_column :parks, :catchphrase, :string
    add_column :parks, :recommended_points, :string
  end
end
