FactoryGirl.define do
  factory :cart do
    association :user

    before :build do |cart|
      cart.user = build :user
    end
  end
end
