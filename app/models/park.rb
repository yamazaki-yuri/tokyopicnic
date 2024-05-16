class Park < ApplicationRecord
  has_many :park_reports
  has_many :park_tokyo_wards
  has_many :tokyo_wards, through: :park_tokyo_wards
  has_many :park_images

  validates :name, presence: true

  enum food_allowed: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum alcohol_allowed: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum sheet_available: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum bringing_in_play_equipment: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true

  def self.ransackable_attributes(auth_object = nil)
    ["food_allowed", "alcohol_allowed", "sheet_available", "bringing_in_play_equipment", "fee",  "name", "updated_at", "created_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tokyo_wards"]
  end

  def display_permission_value(column)
    case self[column]
    when 'possible'
      '◯'
    when 'impossible'
      '×'
    when 'unspecified'
      '-'
    end
  end
end
