# frozen_string_literal: true

class Treatment < ApplicationRecord
  belongs_to :business, inverse_of: :treatments
  has_many :appointments, dependent: :destroy
  validates :name, :description, :price, :duration, presence: true
end
