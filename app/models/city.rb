# frozen_string_literal: true

class City < ApplicationRecord
  has_many :businesses, dependent: :destroy
  has_one_attached :city_image
  validates :name, presence: true
end
