class ParkReportsController < ApplicationController
  def new
    @park_report = ParkReport.new
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

  private

  def report_params
    params.require(:park_report).permit(:date, :comment).merge(park_id: @park.id, tokyo_ward_id: @tokyo_ward.id)
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
