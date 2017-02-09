FactoryGirl.define do
  factory :order do
    user nil
    total 1
    tax_amount 1
    delivery_fee 1
    cache_on_delivery_fee 1
    delivery_time_zone 1
    delivery_date "2017-02-10"
    destination_name "MyString"
    destination_zip_code "MyString"
    destination_address "MyString"
  end
end
