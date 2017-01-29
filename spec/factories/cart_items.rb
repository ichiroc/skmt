FactoryGirl.define do
  factory :cart_item do
    association :cart
    association :product
    quantity 1
    after :build do |item|
      item.cart = build :cart
      item.product = build :product
    end
  end
end
