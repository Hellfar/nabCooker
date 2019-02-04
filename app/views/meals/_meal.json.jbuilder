json.extract! meal, :id, :name, :category, :desc, :created_at, :updated_at
json.url meal_url(meal, format: :json)
