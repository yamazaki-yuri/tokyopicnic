class ParkImagesController < ApplicationController
  def create
    @park = Park.find(params[:park_image][:park_id])
    @park_image = @park.park_images.build(park_image_params)

    if @park_image.save
      flash[:success] = t('flash_message.image.success', item: ParkImage.human_attribute_name(:image))
      redirect_to @park
    else
      flash[:danger] = t('flash_message.image.failure', item: ParkImage.human_attribute_name(:image))
      render 'parks/show', status: :unprocessable_entity
    end
  end

  private

  def park_image_params
    params.require(:park_image).permit(:url).merge(park_id: @park.id)
  end
end
