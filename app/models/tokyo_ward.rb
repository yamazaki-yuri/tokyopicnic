class TokyoWard < ApplicationRecord
  has_many :park_tokyo_wards, dependent: :destroy
  has_many :park_reports, dependent: :destroy
  has_many :parks, through: :park_tokyo_wards, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil) 
    ["id"]
  end
end
