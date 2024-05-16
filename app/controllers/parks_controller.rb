class ParksController < ApplicationController
  def index
    @q = Park.ransack(params[:q])
    if params[:q].present? && (params[:q][:fee] == "paid" || params[:q][:fee] == "free")
      if params[:q][:fee] == "paid"
        @parks = @q.result.where.not(fee: nil)
      elsif params[:q][:fee] == "free"
        @parks = @q.result.where(fee: nil)
      end
    else
      @parks = @q.result(distinct: true).includes(:park_images, park_tokyo_wards: :tokyo_ward)
    end
  end

  def show
    @park = Park.find(params[:id])
    @park_image = ParkImage.new
    @park_images = @park.park_images
    @tokyo_ward = @park.tokyo_wards.first
    @park_reports = @park.park_reports.includes([:report_images, :user])
  end
end
