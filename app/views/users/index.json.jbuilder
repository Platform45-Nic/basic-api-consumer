json.array!(@user) do |user|
  json.extract! user, :id
end