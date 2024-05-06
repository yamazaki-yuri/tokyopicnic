class ParkReportsController < ApplicationController
  def new
    @park_report = ParkReport.new
  end

  def create
    @tokyo_ward = TokyoWard.find(params[:park_report][:tokyo_ward_id])
    latitude = @tokyo_ward.latitude
    longitude = @tokyo_ward.longitude
    location = "#{latitude},#{longitude}"

    query = params[:park_report][:park_name]
    google_places_service = GooglePlacesService.new
    response = google_places_service.search(location, query)

    park_info = response['results'].first
    place_id = park_info['place_id']

    web_response = google_places_service.get_website(place_id)
    website = web_response['result']['website']
    
    @park = Park.find_or_create_by(name: query, googlemaps_place_id: place_id, website_url: website)
    
    @park_report = current_user.park_reports.build(report_params)
    @park_report.save
  end

  private

  def report_params
    params.require(:park_report).permit(:tokyo_ward_id, :date, :comment).merge(park_id: @park.id)
  end
end
