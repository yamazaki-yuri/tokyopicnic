class ParkReport < ApplicationRecord
  belongs_to :user
  belongs_to :park
  belongs_to :tokyo_ward
end
