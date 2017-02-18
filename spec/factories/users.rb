FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    destination_name { Faker::Name.name }
    destination_zip_code { Faker::Address.zip_code }
    destination_address { Faker::Address.full_address }

    after :build do |user|
      user.skip_confirmation!
      user.cart = build :cart
    end

    factory :admin do
      email 'admin@admin'
      password 'password'
      is_admin '1'
      after :build do |admin|
        admin.skip_confirmation!
      end
    end
  end
end
