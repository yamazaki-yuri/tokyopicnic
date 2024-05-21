class ParkReport < ApplicationRecord
  belongs_to :user
  belongs_to :park
  belongs_to :tokyo_ward
  has_many :report_images, dependent: :destroy
  accepts_nested_attributes_for :report_images
  attr_accessor :park_name, :tokyo_ward_id

  validates :title, presence: true
  validates :tokyo_ward_id, presence: true
end
