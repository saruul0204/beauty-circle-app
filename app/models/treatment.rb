# frozen_string_literal: true

class Treatment < ApplicationRecord
  belongs_to :business
  validates :name, :description, :price, :duration, presence: true
end
