require 'faker'

5.times do
  user = User.new(
    name:       Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all 

# Users created to test user roles 
# Admin - Access to all features & Zero policy restrictions

admin = User.new(
  name:        'Richard Pryor',
  email:       'rick@example.com',
  password:    'password',
  role:        'admin'
  )
  admin.skip_confirmation!
  admin.save!

# Standard User - Default for all new users - Cannot create private wikis

standard = User.new(
  name:        'Robin Williams',
  email:       'mrsdoubtfire@example.com',
  password:    'password',
  role:        'standard'
  )
  standard.skip_confirmation!
  standard.save!

# Premium User - Paid upgrade for users - Allows creation of private wikis & collaboration

premium = User.new(
  name:        'Eddie Murphy',
  email:       'notcharliemurphy@example.com',
  password:    'password',
  role:        'premium'
  )
  premium.skip_confirmation!
  premium.save!


100.times do
  wiki = Wiki.new(
    user:      users.sample,
    title:     Faker::Lorem.sentence,
    body:      Faker::Lorem.paragraph
    )
  wiki.save!
end
wikis = Wiki.all




puts "Seeds Finished"
puts "#{User.count} users were created"
puts "#{Wiki.count} wikis were created"
puts "#{admin.name}"
puts "#{standard.name}"
puts "#{premium.name}"
