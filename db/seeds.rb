# frozen_string_literal: true

require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

USERS = rand(10..15)

puts 'Seeding started'

puts 'Seeding users and businesses'
USERS.times do |i|
  user = i.zero? ? create(:user, email: 'user@test.com') : create(:user)

  # Create couple businesses per user
  rand(1..3).times { create(:business, user: user) }
end

puts 'Seeding treatments'
Business.all.each do |business|
  # Create couple treatments per business
rand(3..10).times { create(:treatment, business: business) }
end

puts 'Seeding completed'