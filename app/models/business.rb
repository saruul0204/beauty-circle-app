# frozen_string_literal: true

class Business < ApplicationRecord
  validates :name, :description, :address, :country, :open_hour,
            :close_hour, :phone_number, :email, presence: true
  belongs_to :user
  has_many :treatments, dependent: :destroy
  belongs_to :city

  accepts_nested_attributes_for :treatments, reject_if: :all_blank, allow_destroy: true
  validates_associated :treatments

  def full_address
    "#{address}, #{city.name}, #{country}"
  end
end
