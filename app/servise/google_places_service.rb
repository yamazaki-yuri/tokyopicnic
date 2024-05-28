require 'httparty'

class GooglePlacesService
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/place'

  def initialize
    @api_key = ENV['GOOGLE_API_KEY']
  end

  def search(location, keyword)
    options = {
      query: {
        location: location,
        keyword: keyword,
        radius: 5000,
        type: 'park',
        key: @api_key,
        language: 'ja'
      }
    }
    self.class.get("/nearbysearch/json", options)
  end

  def get_website(place_id)
    options = {
      query: {
        place_id: place_id,
        fields: ['website'],
        key: @api_key
      }
    }
    self.class.get("/details/json", options)
  end
end