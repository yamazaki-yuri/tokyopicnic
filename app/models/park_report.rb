class ParkReport < ApplicationRecord
  belongs_to :user
  belongs_to :park
  belongs_to :tokyo_ward
  has_many :report_images
  accepts_nested_attributes_for :report_images

  validates :title, presence: true
end
