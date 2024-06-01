class TopsController < ApplicationController
  def index
    random_park = Park.pluck(:id).sample
    @park = Park.find(random_park)
    @park_images = @park.park_images
    @park_tokyo_ward = @park.tokyo_wards.first
  end

  def terms_of_service
  end

  def privacy_policy
  end
end
