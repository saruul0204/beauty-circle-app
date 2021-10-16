FactoryBot.define do
  factory :business do
    name { Faker::Company.name }
    description { Faker::Lorem.paragraphs(number: 1) }
    address { Faker::Address.street_address }
    country { Faker::Address.country }
    city { Faker::Address.city }
    open_hour { '8:00 am' }
    close_hour { '6:00 pm' }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.email }
    facebook_url { 'https://www.facebook.com/' }
    instagram_url { 'https://www.instagram.com/' }
  end
end
