json.extract! account_movement, :id, :dt_movement, :operation, :value, :created_at, :updated_at
json.url account_movement_url(account_movement, format: :json)
