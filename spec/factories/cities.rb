# frozen_string_literal: true

FactoryBot.define do
  link_to_files = Dir[Rails.root.join('spec/fixtures/cities/*')]
  attach_new_images = []

  link_to_files.each do |img|
    attach_new_images.push(Rack::Test::UploadedFile.new(img, 'image/jpeg'))
  end

  factory :city do
    name { %w[Skopje Ohrid Struga Bitola Stip Strumica Kumanovo Tetovo Gostivar].sample }
    city_image { attach_new_images.sample }
  end
end
