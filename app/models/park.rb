class Park < ApplicationRecord
  has_many :park_reports, dependent: :destroy
  has_many :park_tokyo_wards, dependent: :destroy
  has_many :tokyo_wards, through: :park_tokyo_wards
  has_many :park_images, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true

  enum alcohol_allowed: { within_common_sense: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum food_allowed: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum sheet_available: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum bringing_in_play_equipment: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum dog_run: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true
  enum bbq_area: { possible: 0, impossible: 1, unspecified: 2 }, _prefix: true

  def self.ransackable_attributes(auth_object = nil)
    ["food_allowed", "alcohol_allowed", "sheet_available", "bringing_in_play_equipment", "fee",  "name", "dog_run", "bbq_area", "updated_at", "created_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tokyo_wards"]
  end
end
