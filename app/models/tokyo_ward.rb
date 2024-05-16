class TokyoWard < ApplicationRecord
  has_many :park_tokyo_wards
  has_many :park_reports
  has_many :parks, through: :park_tokyo_wards

  def self.ransackable_attributes(_auth_object = nil) 
    ["id"]
  end
end
