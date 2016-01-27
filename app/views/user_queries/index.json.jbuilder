json.array!(@user_queries) do |user_query|
  json.extract! user_query, :id, :product_id, :search_text
  json.url user_query_url(user_query, format: :json)
end
