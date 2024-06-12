class ParkReportsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :find_current_user_report, only: %i[edit update]
  before_action :find_report, only: %i[show destroy]
  
  def index
    @park_reports = current_user.park_reports.includes(:park, :report_images).order(created_at: :desc)
    @visited_wards_count = current_user.visited_tokyo_wards_count
    @visited_wards = current_user.visited_tokyo_wards
    @tokyo_wards = TokyoWard.all
    render partial: 'park_reports/index'
  end

  def show
    @report_image = ReportImage.new
  end

  def new
    @park_report = ParkReport.new
    @park_report.report_images.build
    @park_report.park_name = params[:park_name]
    @park_report.tokyo_ward_id = params[:tokyo_ward_id]
  end

  def edit; end

  def create
    @park_report = ParkReport.new(recieve_params)
    @park_name = params[:park_report][:park_name]
    @park = Park.find_by(name: @park_name)

    if @park
      @tokyo_ward = @park.tokyo_wards.first
      fetch_and_add_park_image(@park)
    else
      receive_tokyo_ward
    end

    if @park.nil?
      flash.now[:danger] = "指定された公園が見つかりませんでした。東京23区にある公園を入力してください。"
      @park_report.park_name = @park_name
      @park_report.tokyo_ward_id = params[:park_report][:tokyo_ward_id]
    else
      save_park_report
    end
  end

  def update
    if @park_report.update(edit_params)
      flash[:success] = t('flash_message.update.success', item: ParkReport.human_attribute_name(:report))
      redirect_to @park_report
    else
      flash[:danger] = t('flash_message.update.failure', item: ParkReport.human_attribute_name(:report))
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @park = @park_report.park
    if @park_report.destroy
      
      flash[:success] = t('flash_message.destroy.success', item: ParkReport.human_attribute_name(:report))
      redirect_to mypage_path
    else
      flash.now[:danger] = t('flash_message.destroy.failure', item: ParkReport.human_attribute_name(:report))
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

  def recieve_params
    params.require(:park_report).permit(:park_name, :tokyo_ward_id, :date, :title, :comment, report_images_attributes: [:url])
  end

  def report_params
    params.require(:park_report).permit(:date, :title, :comment, report_images_attributes: [:url]).merge(park_id: @park.id, tokyo_ward_id: @tokyo_ward.id)
  end

  def edit_params
    params.require(:park_report).permit(:date, :title, :comment)
  end

  def receive_tokyo_ward
    if params[:park_report][:tokyo_ward_id].present?
      @tokyo_ward = TokyoWard.find(params[:park_report][:tokyo_ward_id])
      create_park_and_associate_tokyo_ward
    else
      flash.now[:danger] = "区を選択してください"
      render :new, status: :unprocessable_entity
    end
  end

  def save_park_report
    @park_report = current_user.park_reports.build(report_params)
    if @park_report.save
      flash[:success] = t('flash_message.post.success')
      redirect_to park_path(@park)
    else
      flash[:danger] = t('flash_message.post.failure')
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
      if park_info.nil?
        flash[:danger] = "公園が東京23区にないか、区が間違っています。"
        render :new, status: :unprocessable_entity
        return
      end
    place_id = park_info['place_id']
    park_lat = park_info['geometry']['location']['lat']
    park_lng = park_info['geometry']['location']['lng']
    web_response = google_places_service.get_website(place_id)
    website = web_response['result']['website']
  
    @park = Park.create(name: @park_name, googlemaps_place_id: place_id, website_url: website, latitude: park_lat, longitude: park_lng)
    @park.tokyo_wards << @tokyo_ward

    add_image_to_park(google_places_service, park_info, @park)
  end

  def fetch_and_add_park_image(park)
    google_places_service = GooglePlacesService.new
    response = google_places_service.search("#{park.latitude},#{park.longitude}", park.name)

    park_info = response['results'].first
    return if park_info.nil?

    add_image_to_park(google_places_service, park_info, park)
  end

  def add_image_to_park(google_places_service, park_info, park)
    return unless park_info['photos'].present?

    photo_reference = park_info['photos'].first['photo_reference']
    image_url = google_places_service.get_photo_url(photo_reference)

    service = ImageDownloadService.new(image_url)
    temp_file = service.download_and_process

    if temp_file
      park_image = park.park_images.create(url: File.open(temp_file.path))
    end
  ensure
    temp_file.close if temp_file
    temp_file.unlink if temp_file
  end
end
