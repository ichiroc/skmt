# frozen_string_literal: true
u = User.new(name: 'Admin', email: 'admin@admin')
u.password = 'password'
u.skip_confirmation!
u.add_role :admin
u.save!
puts 'Default admin user is created.'

10.times do |i|
  u = User.new(name: "User#{i}", email: "user#{i}@user", password: 'password')
  u.skip_confirmation!
  u.save!
end
puts 'Sample users are created.'

30.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: [1980, 2980, 980, 580, 480, 8800, 4800].sample,
    hidden: nil,
    sort_order: [10, 20, 30, 40, 50].sample,
    image: File.new("#{Rails.root}/db/seeds/images/#{Random.rand(1..5)}.jpg")
  )
end
puts 'Sample products are created.'
