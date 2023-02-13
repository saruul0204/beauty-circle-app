# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    title { 'New' }
    client_name { Faker::Name.name }
    client_email { Faker::Internet.email }
    start_time { Faker::Time.between(from: Time.zone.now, to: Time.zone.now + 1.week) }
    end_time { start_time + 30.minutes }
    association :business, factory: :business
    association :user, factory: :user
    association :treatment, factory: :treatment
  end
end
