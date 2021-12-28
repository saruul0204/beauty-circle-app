# frozen_string_literal: true

FactoryBot.define do
  link_to_files = Dir[Rails.root.join('spec/fixtures/cities/*')]
  attach_new_images = []
  city_name = CITY_NAMES.sample

  link_to_files.each do |img|
    attach_new_images.push(Rack::Test::UploadedFile.new(img, 'image/jpeg'))
  end

  byebug

  factory :city do
    name { city_name }
    city_image { attach_new_images.find { |img| img.original_filename.include?(city_name.downcase) } }
  end
end
