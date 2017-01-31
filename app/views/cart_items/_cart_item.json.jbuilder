json.extract! cart_item, :id, :quantity, :user_id, :product_id, :created_at, :updated_at
json.url cart_item_url(cart_item, format: :json)