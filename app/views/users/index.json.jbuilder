json.array!(@user) do |user|
  json.extract! user, :id
  json.url user_url(user, :id)
end