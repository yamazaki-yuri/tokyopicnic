class ParksController < ApplicationController
  def index
    @q = Park.ransack(params[:q])
    if params[:q].present? && (params[:q][:fee] == "paid" || params[:q][:fee] == "free")
      if params[:q][:fee] == "paid"
        @parks = @q.result.where(fee: "あり")
      elsif params[:q][:fee] == "free"
        @parks = @q.result.where(fee: "なし")
      end
    else
      @parks = @q.result(distinct: true).includes(:park_images, park_tokyo_wards: :tokyo_ward)
      @parks_json = @parks.map { |o| park_to_hash(o) }.to_json
      @count = @parks.count
    end
  end

  def show
    @park = Park.find(params[:id])
    @park_image = ParkImage.new
    @park_images = @park.park_images
    @tokyo_ward = @park.tokyo_wards.first
    @park_reports = @park.park_reports.includes([:report_images, :user])
  end

  def autocomplete
    @parks = Park.where("name like ?", "%#{params[:q]}%")
    render partial: 'parks/park', locals: { parks: @parks }
  end

  def tokyo_ward_info
    park_id = params[:park_id]
    puts "Received request for park: #{park_id}" # デバッグメッセージ
    park = Park.find_by(id: park_id)
    if park
      tokyo_ward = park.tokyo_wards.first
      puts "Found park: #{park_id}, Tokyo ward: #{tokyo_ward.id}" # デバッグメッセージ
      render json: { tokyo_ward_id: tokyo_ward.id }
    else
      puts "Park not found: #{park_id}" # デバッグメッセージ
      render json: { error: 'Park not found' }, status: :not_found
    end
  end

  private

  def park_to_hash(park)
    { 
      id: park.id,
      tokyo_ward_id: park.tokyo_wards.first.id,
      name: park.name,
      lat: park.latitude,
      lng: park.longitude
    }
  end
end
