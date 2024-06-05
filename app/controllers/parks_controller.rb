class ParksController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]

  def index
    @q = Park.ransack(params[:q])
    if params[:q].present? && params[:q][:fee].present?
      if params[:q][:fee] == "paid"
        @q.fee_eq = "あり"
      elsif params[:q][:fee] == "free"
        @q..fee_eq = "なし"
      end
    end
      @parks = @q.result(distinct: true).includes(:park_images, park_tokyo_wards: :tokyo_ward).page(params[:page]).per(12)
      @parks_json = @parks.map { |o| park_to_hash(o) }.to_json
      @count = @parks.count
  end

  def edit
  end

  def update
    @park = Park.find(params[:id])
    if @park.update(edit_params)
      flash[:success] = t('flash_message.post.success')
      redirect_to @park
    else
      flash[:danger] = t('flash_message.post.failure')
      render :show, status: :unprocessable_entity
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
    park = Park.find(park_id)
    if park
      tokyo_ward = park.tokyo_wards.first
      render json: { tokyo_ward_id: tokyo_ward.id }
    else
      render json: { error: 'Park not found' }, status: :not_found
    end
  end

  private

  def edit_params
    params.require(:park).permit(:catchphrase, :recommended_points)
  end

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
