FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    zip_code { Faker::Address.zip_code }
    address { Faker::Address.full_address }

    before :build do |user|
      user.skip_confirmation!
    end

    after :build do |user|
      user.cart = build :cart
    end
  end
end
