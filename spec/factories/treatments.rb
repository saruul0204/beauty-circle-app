# frozen_string_literal: true

FactoryBot.define do
  factory :treatment do
    association :business, factory: :business
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    price { Faker::Commerce.price(range: 0..10.0, as_string: true) }
    duration { Faker::Number.between(from: 30, to: 120) }
  end
end
