# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    name { CITY_NAMES.sample }

    after(:create) do |city|
      new_image = Rails.root.join("spec/fixtures/cities/#{city.name.downcase}.jpg")
      city.city_image.attach(
        io: File.open(new_image),
        filename: "#{city.name.downcase}.jpg",
        content_type: 'image/jpg',
        identify: false
      )
    end
  end
end
