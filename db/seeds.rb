# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

## Create X amount of users
## ----------------------------------------------
## We're not using the create! method as skipping
## confirmation is required at this stage
#
10.times do
  user = User.new(
    first_name: Faker::Name.name,
    last_name:  Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10),
    role:     'standard'
  )
  user.skip_confirmation!
  user.save!
end

testuserone = User.new(
  first_name: 'Testuser',
  last_name:  'One',
  email:      'testuserone@test.com',
  password:   'testuserone',
  role:       'standard'
)
testuserone.skip_confirmation!
testuserone.save!

testusertwo = User.new(
  first_name: 'Testuser',
  last_name:  'Two',
  email:      'testusertwo@test.com',
  password:   'testusertwo',
  role:       'standard'
)
testusertwo.skip_confirmation!
testusertwo.save!

testuserthree = User.new(
  first_name: 'Testuser',
  last_name:  'Three',
  email:      'testuserthree@test.com',
  password:   'testuserthree',
  role:       'standard'
)
testuserthree.skip_confirmation!
testuserthree.save!

users = User.all


## Create Wikis
## ----------------------------------------------
#
users.each do |user|
  6.times do
    Wiki.create!(
      user: user,
      title: Faker::Lorem.sentence,
      body:  Faker::Lorem.paragraph
    )
  end
end


## A little output
## ----------------------------------------------
#
puts "Database seeding complete"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
