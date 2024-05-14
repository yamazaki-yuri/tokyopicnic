class ReportImagesController < ApplicationController
  def create
    @park_report = ParkReport.find(params[:report_image][:park_report_id])
    @report_image = @park_report.report_images.build(report_image_params)

    if @report_image.save
      flash[:success] = "画像を追加しました"
      redirect_to @park_report
    else
      flash[:danger] = "画像の追加に失敗しました"
      render 'park_reports/show', status: :unprocessable_entity
    end
  end

  def destroy
    @report_image = ReportImage.find(params[:id])
    @park_report = @report_image.park_report
    @report_image.remove_url!
    @report_image.destroy!
    flash.now[:success] = "画像を削除しました"
    redirect_to @park_report, status: :see_other
  end

  private

  def report_image_params
    params.require(:report_image).permit(:url).merge(park_report_id: @park_report.id)
  end
end
