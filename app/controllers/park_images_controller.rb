class ParkImagesController < ApplicationController
  def create
    @park = Park.find(params[:park_image][:park_id])
    @park_image = @park.park_images.build(park_image_params)
    binding.pry

    if @park_image.save
      flash[:success] = "画像を追加しました"
      redirect_to @park
    else
      flash[:danger] = "画像の追加に失敗しました"
      render 'parks/show', status: :unprocessable_entity
    end
  end

  private

  def park_image_params
    params.require(:park_image).permit(:url).merge(park_id: @park.id)
  end
end
