class TokyoWard < ApplicationRecord
  has_many :park_tokyo_wards
  has_many :parks, through: :park_distincts
  has_many :park_reports
end
