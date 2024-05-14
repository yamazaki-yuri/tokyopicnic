class ParksController < ApplicationController
  def index
    @parks = Park.all.includes(:park_images, park_tokyo_wards: :tokyo_ward)
    
  end

  def show
    @park = Park.find(params[:id])
    @park_image = ParkImage.new
    @park_images = @park.park_images
    @tokyo_ward = @park.tokyo_wards.first
    @park_reports = @park.park_reports.includes([:report_images, :user])
  end
end
