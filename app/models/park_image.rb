class ParkImage < ApplicationRecord
  belongs_to :park
  mount_uploader :url, ParkImageUploader
end
