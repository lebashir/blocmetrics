# Create Users
28.times do
  User.create!(
    email:    Faker::Internet.email,
    password: Faker::Internet.password(16, 32, true, true)
  )
end

exampleUser = User.create!(
  email: 'user@example.com',
  password: 'password',
  )

users = User.all


# Create Applications

75.times do
  RegisteredApplication.create!(
    user: exampleUser,
    name: Faker::App.name,
    url: Faker::Internet.url('example.com')
    )
end

registered_applications = RegisteredApplication.all

# Create Events

200.times do
  Event.create!(
    registered_application: registered_applications.sample,
    name: Faker::Hipster.sentence(2)
    )
end

puts "Seed finished!"
puts "#{User.count} Users created"
puts "#{RegisteredApplication.count} Applications created"
puts "#{Event.count} Events created"
