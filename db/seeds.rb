require 'faker'

#Create Users
5.times do
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

#Create an member user
member = User.create(
  name: 'Member Name',
  email: 'member@example.com',
  password: 'helloworld'
)
member.skip_confirmation!
member.save

# Create Events
50.times do
  event = Event.create(
    user: users.sample,
    name: 'visit',
    url: Faker::Internet.url,
    created_on: rand(0..30).days.ago.to_date
  )
end
events = Event.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Event.count} events created"