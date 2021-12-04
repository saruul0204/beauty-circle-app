# frozen_string_literal: true

class City < ApplicationRecord
  has_many :businesses, dependent: :destroy
  validates :name, presence: true
end
