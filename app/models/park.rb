class Park < ApplicationRecord
  has_many :park_reports
  has_many :park_tokyo_wards
  has_many :tokyo_wards, through: :park_tokyo_wards
  has_many :park_images

  validates :name, presence: true
end
