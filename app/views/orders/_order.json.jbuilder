json.extract! order, :id, :user_id, :total, :tax_amount, :delivery_fee, :cache_on_delivery_fee, :delivery_time_slot, :delivery_date, :destination_name, :destination_zip_code, :destination_address, :created_at, :updated_at
json.url order_url(order, format: :json)
