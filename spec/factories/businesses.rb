# frozen_string_literal: true

FactoryBot.define do
  link_to_first_image = Rails.root.join('spec/fixtures/files/salon_photo.jpeg')
  link_to_2nd_image = Rails.root.join('spec/fixtures/files/about-image.jpg')
  link_to_3rd_image = Rails.root.join('spec/fixtures/files/nordic-spa1.jpg')

  factory :business do
    association :city, factory: :city
    association :user, factory: :user
    name { Faker::Company.name.parameterize.capitalize }
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    address { Faker::Address.street_address }
    country { Faker::Address.country }
    open_hour do
      Faker::Time.between_dates(from: Time.zone.today - 1, to: Time.zone.today, period: :morning).strftime('%I:%M %p')
    end
    close_hour do
      Faker::Time.between_dates(from: Time.zone.today - 1, to: Time.zone.today, period: :evening).strftime('%I:%M %p')
    end
    phone_number { Faker::PhoneNumber.cell_phone_with_country_code }
    email { Faker::Internet.email }
    facebook_url { 'https://www.facebook.com/' }
    instagram_url { 'https://www.instagram.com/' }
    images do
      [
        Rack::Test::UploadedFile.new(link_to_first_image, 'image/jpeg'),
        Rack::Test::UploadedFile.new(link_to_2nd_image, 'image/jpg'),
        Rack::Test::UploadedFile.new(link_to_3rd_image, 'image/jpg')
      ]
    end
  end
end
