crumb :root do
  link "Home", root_path
end

crumb :product do |product|
  link product.name, product_path(product)
end

crumb :cart do
  link 'Cart', cart_items_path
end

crumb :order do
  link 'Order', new_order_path
  parent :cart
end

crumb :order_confirmation do
  link 'Order Confirmation'
  parent :order
end

crumb :orders do
  link 'Orders', orders_path
end

crumb :order_detail do
  link 'Order Details'
  parent :orders
end

crumb :account do
  link 'Account'
end
