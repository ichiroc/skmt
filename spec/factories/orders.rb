FactoryGirl.define do
  factory :order do
    association :user
    total 1
    tax_amount 1
    delivery_fee 1
    cache_on_delivery_fee 1
    delivery_time_zone 1
    delivery_date "2017-02-10"
    destination_name { Faker::Name.name }
    destination_zip_code { Faker::Address.zip_code }
    destination_address { Faker::Address.full_address }
  end
end
