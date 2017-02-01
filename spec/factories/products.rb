# frozen_string_literal: true
FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price 1..10_000 }
    hidden nil
    sort_order { Faker::Number.positive }
  end
end
