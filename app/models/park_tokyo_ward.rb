class ParkTokyoWard < ApplicationRecord
  belongs_to :park
  belongs_to :tokyo_ward
end
