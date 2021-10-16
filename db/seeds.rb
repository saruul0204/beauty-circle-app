# frozen_string_literal: true

require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

USERS = rand(6..15)
BUSINESSES = rand(6..15)

puts 'Seeding started'

puts 'Seeding users'
USERS.times do |i|
  user = i.zero? ? create(:user, email: 'user@test.com') : create(:user)
end

puts 'Seeding businesses'
BUSINESSES.times do |i|
    create(:business)
end

puts 'Seeding completed'