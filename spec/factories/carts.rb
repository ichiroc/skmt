FactoryGirl.define do
  factory :cart do
    factory :cart_with_user do
      association :user
    end
  end
end
