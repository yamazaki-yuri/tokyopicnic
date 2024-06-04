class ParkImagesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    Rails.logger.info "Create action called"
    begin
      @park = Park.find(params[:park_image][:park_id])
      Rails.logger.info "Park found: #{@park.inspect}"
    rescue ActiveRecord::RecordNotFound
      Rails.logger.error "Park not found with id: #{params[:park_image][:park_id]}"
      flash[:danger] = "Park not found"
      redirect_to parks_path and return
    end

    # Tokyo Wardのチェックを除外
    # @tokyo_ward = @park.tokyo_wards.first
    # Rails.logger.info "Tokyo Ward found: #{@tokyo_ward.inspect}"

    # if @tokyo_ward.nil?
    #   Rails.logger.error "Tokyo Ward not found for park id: #{@park.id}"
    #   flash[:danger] = "Tokyo Ward not found"
    #   redirect_to parks_path and return
    # end

    @park_image = @park.park_images.build(park_image_params)
    Rails.logger.info "Park Image: #{@park_image.inspect}"

    if @park_image.save
      Rails.logger.info "Park Image saved successfully"
      flash[:success] = t('flash_message.image.success', item: ParkImage.human_attribute_name(:image))
      redirect_to @park
    else
      Rails.logger.error "Park Image save failed: #{@park_image.errors.full_messages.join(', ')}"
      flash[:danger] = t('flash_message.image.failure', item: ParkImage.human_attribute_name(:image))
      flash[:danger] += @park_image.errors.full_messages.join(', ')
      render 'parks/show', status: :unprocessable_entity
    end
  end

  private

  def park_image_params
    params.require(:park_image).permit(:url).merge(park_id: params[:park_image][:park_id])
  end
end
