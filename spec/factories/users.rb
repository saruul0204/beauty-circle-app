# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username.rjust(::User::MIN_LEN, 'q').truncate(::User::MAX_LEN).downcase }
    first_name { Faker::Name.first_name.rjust(::User::MIN_LEN, 'q').truncate(::User::MAX_LEN) }
    last_name do
      Faker::Name.last_name.rjust(::User::MIN_LEN, 'q').truncate(::User::MAX_LEN).parameterize(preserve_case: true)
    end
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
