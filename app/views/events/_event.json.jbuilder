json.extract! event, :id, :title, :time, :price, :bio, :venue_id, :created_at, :updated_at
json.url event_url(event, format: :json)
