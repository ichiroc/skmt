# frozen_string_literal: true
FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price 1..10_000 }
    status 0
    sort_order { Faker::Number.positive }
  end
end
