# frozen_string_literal: true

require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

USERS = rand(10..15)
CITIES = %w[Skopje Ohrid Struga Bitola Stip Strumica Kumanovo Tetovo Gostivar]

puts 'Seeding started'

puts 'Seeding users and businesses'
USERS.times do |i|
  user = i.zero? ? create(:user, email: 'user@test.com') : create(:user)

  # Create couple businesses per user
  rand(1..3).times { create(:business, user: user, city: CITIES.sample) }
end

puts 'Seeding completed'