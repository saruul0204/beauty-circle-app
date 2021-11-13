# frozen_string_literal: true

class Business < ApplicationRecord
  validates :name, :description, :address, :city, :country, :open_hour,
            :close_hour, :phone_number, :email, presence: true
  belongs_to :user
  has_many :treatments, dependent: :destroy
  belongs_to :city
end
