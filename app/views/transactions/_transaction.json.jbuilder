json.extract! transaction, :id, :user_id, :order_id, :orderitem_id, :token, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)