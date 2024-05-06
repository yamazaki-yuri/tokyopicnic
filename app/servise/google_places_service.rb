require 'httparty'

class GooglePlacesService
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/place'

  def initialize
    @api_key = ENV['GOOGLE_API_KEY']
  end

  def search(location, query)
    options = {
      query: {
        location: location,
        query: query,
        radius: 5000,
        key: @api_key,
        language: 'ja'
      }
    }
    self.class.get("/textsearch/json", options)
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