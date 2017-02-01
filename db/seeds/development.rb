u = User.find_or_initialize_by(name: 'Admin', email: 'admin@admin')
u.password = 'password'
u.skip_confirmation!
u.add_role :admin
u.save!
puts 'Default admin user is created.'
