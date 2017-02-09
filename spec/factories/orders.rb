FactoryGirl.define do
  factory :order do
    user nil
    total 1
    tax_amount 1
    delivery_charge 1
    cache_on_delivery_fee 1
    delivery_time 1
    delivery_date "2017-02-09"
    destination_name "MyString"
    destination_zip_code "MyString"
    destination_address "MyString"
  end
end
