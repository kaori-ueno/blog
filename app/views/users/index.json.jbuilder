json.array!(@users) do |user|
  json.extract! user, :id, :name, :encrypted_password, :created_at, :updated_at
  json.url user_url(user, format: :json)
end
