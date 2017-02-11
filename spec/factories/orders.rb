FactoryGirl.define do
  factory :order do
    association :user
    total { Faker::Commerce.price 100..99_999 }
    tax_amount { Faker::Commerce.price 100..1_000 }
    delivery_fee { 500 * Random.rand(1..10) }
    cache_on_delivery_fee { [300, 400, 600, 1000].sample }
    delivery_time_zone { Random.rand 0..6 }
    delivery_date Time.now
    destination_name { Faker::Name.name }
    destination_zip_code { Faker::Address.zip_code }
    destination_address { Faker::Address.full_address }
  end
end
