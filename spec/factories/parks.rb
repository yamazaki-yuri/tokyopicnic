FactoryBot.define do
  factory :park do
    name { 'テスト公園' }
    googlemaps_place_id { 'test_place_id' }
    website_url { 'https://example.com' }
    latitude { 35.6895 }
    longitude { 139.6917 }
  end
end