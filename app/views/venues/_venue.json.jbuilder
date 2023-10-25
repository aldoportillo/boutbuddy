json.extract! venue, :id, :name, :lat, :lng, :created_at, :updated_at
json.url venue_url(venue, format: :json)
