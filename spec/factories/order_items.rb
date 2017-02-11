FactoryGirl.define do
  factory :order_item do
    association :order
    association :product
    product_name { Faker::Commerce.product_name }
    product_price { Faker::Commerce.price 100..99_999 }
    quantity 1
  end
end
