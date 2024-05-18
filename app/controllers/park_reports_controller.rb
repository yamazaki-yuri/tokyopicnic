class ParkReportsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :find_current_user_report, only: %i[edit update]
  before_action :find_report, only: %i[show destroy]
  
  def new
    @park_report = ParkReport.new
    2.times { @park_report.report_images.build }
  end

  def create
    @park_name = params[:park_report][:park_name]
    @park = Park.find_by(name: @park_name)

    if @park
      @tokyo_ward = @park.tokyo_wards.first
    else
      if params[:park_report][:tokyo_ward_id].present?
        @tokyo_ward = TokyoWard.find(params[:park_report][:tokyo_ward_id])
      else
        flash[:danger] = "区を選択してください"
        render :new, status: :unprocessable_entity
        return
      end

      create_park_and_associate_tokyo_ward
    end

    save_park_report
  end

  def edit; end

  def update
    if @park_report.update(edit_params)
      flash[:success] = "編集が完了しました"
      redirect_to @park_report
    else
      flash[:danger] = "編集に失敗しました"
      render 'park_reports/show', status: :unprocessable_entity
    end
  end


  def show
    @report_image = ReportImage.new
  end

  def destroy
    @park = @park_report.park
    if @park_report.destroy
      
      flash[:success] = "投稿を削除しました"
      redirect_to mypage_path
    else
      flash.now[:danger] = "投稿の削除に失敗しました"
      render :show, status: :unprocessable_entity
    end
  end

  private

  def find_current_user_report
    @park_report = current_user.park_reports.find(params[:id])
  end

  def find_report
    @park_report = ParkReport.includes(:report_images, :park).find(params[:id])
  end

  def report_params
    params.require(:park_report).permit(:date, :title, :comment, report_images_attributes: [:url]).merge(park_id: @park.id, tokyo_ward_id: @tokyo_ward.id)
  end

  def edit_params
    params.require(:park_report).permit(:date, :title, :comment)
  end

  def save_park_report
    @park_report = current_user.park_reports.build(report_params)
    if @park_report.save
      flash[:success] = "投稿しました"
      redirect_to park_path(@park)
    else
      flash[:danger] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def create_park_and_associate_tokyo_ward
    latitude = @tokyo_ward.latitude
    longitude = @tokyo_ward.longitude
    location = "#{latitude},#{longitude}"

    google_places_service = GooglePlacesService.new
    response = google_places_service.search(location, @park_name)

    park_info = response['results'].first
    place_id = park_info['place_id']

    web_response = google_places_service.get_website(place_id)
    website = web_response['result']['website']
    
    @park = Park.create(name: @park_name, googlemaps_place_id: place_id, website_url: website)
    @park.tokyo_wards << @tokyo_ward
  end
end
