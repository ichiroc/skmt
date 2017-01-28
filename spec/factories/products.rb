FactoryGirl.define do
  factory :product do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price }
    hidden nil
    sort_order { Faker::Number.positive }
    image nil
  end
end
