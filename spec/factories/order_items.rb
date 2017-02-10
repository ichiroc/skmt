FactoryGirl.define do
  factory :order_item do
    association :cart_item
    association :order
    association :product
  end
end
