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
        radius: 10000,
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

  def get_photo_url(photo_reference)
    options = {
      query: {
        maxwidth: 600,
        maxheight: 500,
        photoreference: photo_reference,
        key: @api_key
      }
    }
    response = self.class.get("/photo", options)
    response.request.last_uri.to_s if response.success?
  end
end