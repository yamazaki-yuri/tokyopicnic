class ParksController < ApplicationController
  def show
    @park = Park.find(params[:id])
    @park_image = ParkImage.new
    @park_images = @park.park_images
  end
end
