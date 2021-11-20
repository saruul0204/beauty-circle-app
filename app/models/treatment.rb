# frozen_string_literal: true

class Treatment < ApplicationRecord
  belongs_to :business, inverse_of: :treatments
  validates :name, :description, :price, :duration, presence: true
end
