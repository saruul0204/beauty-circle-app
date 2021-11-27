# frozen_string_literal: true

class Business < ApplicationRecord
  validates :name, :description, :address, :country, :open_hour,
            :close_hour, :phone_number, :email, presence: true
  belongs_to :user
  has_many :treatments, inverse_of: :business, dependent: :destroy
  belongs_to :city

  accepts_nested_attributes_for :treatments, reject_if: :all_blank, allow_destroy: true
  validates_associated :treatments

  def full_address
    "#{address}, #{city.name}, #{country}"
  end

  def self.search(params)
    joins(:treatments, :city).where('(businesses.name ILIKE ? OR treatments.name ILIKE ?) AND cities.name ILIKE ?', "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:city_name]}%").distinct
  end
end
