# frozen_string_literal: true

class Business < ApplicationRecord
  validates :name, :description, :address, :country, :open_hour,
            :close_hour, :phone_number, :email, presence: true
  belongs_to :user
  has_many :treatments, inverse_of: :business, dependent: :destroy
  belongs_to :city
  has_many_attached :images, dependent: :destroy
  validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                     size: { less_than: 5.megabytes, message: 'must be less than 2MB in size' }
  accepts_nested_attributes_for :treatments, reject_if: :all_blank, allow_destroy: true
  validates_associated :treatments

  def full_address
    "#{address}, #{city.name}, #{country}"
  end

  def self.search(params)
    joins(:treatments, :city).where('(businesses.name ILIKE ? OR treatments.name ILIKE ?) AND cities.name ILIKE ?',
                                    "%#{params[:name]}%", "%#{params[:name]}%", "%#{params[:city_name]}%").distinct
  end

  scope :active, -> { where(deleted_at: nil) }
end
