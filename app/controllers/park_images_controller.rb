class ParkImagesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    @park = Park.find(params[:park_image][:park_id])
    Rails.logger.info "Park: #{@park.inspect}"
    @park_image = @park.park_images.build(park_image_params)

    if @park_image.save
      flash[:success] = t('flash_message.image.success', item: ParkImage.human_attribute_name(:image))
      redirect_to @park
    else
      flash[:danger] = t('flash_message.image.failure', item: ParkImage.human_attribute_name(:image))
      redirect_to @park
    end
  end

  private

  def park_image_params
    params.require(:park_image).permit(:url).merge(park_id: params[:park_image][:park_id])
  end
end
