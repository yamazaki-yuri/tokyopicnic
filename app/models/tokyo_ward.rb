class TokyoWard < ApplicationRecord
  has_many :park_tokyo_wards
  has_many :park_reports
  has_many :parks, through: :park_tokyo_wards
end
