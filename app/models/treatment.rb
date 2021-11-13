# frozen_string_literal: true

class Treatment < ApplicationRecord
  validates :name, :description, :price, :duration, presence: true

  belongs_to :business
end
