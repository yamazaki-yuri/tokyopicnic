class ReportImage < ApplicationRecord
  belongs_to :park_report
  mount_uploader :url, ReportImageUploader
end
