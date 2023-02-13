# frozen_string_literal: true

class Appointment < ApplicationRecord
  validates :title, :client_name, :client_email, :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  belongs_to :treatment
  belongs_to :business
  belongs_to :user

  def time_name
    "#{start_time.strftime('%R')}: #{client_name}"
  end

  private

  def end_time_after_start_time
    return unless end_time && start_time
    return if end_time > start_time

    errors.add(:end_time, 'must be greater than start time')
  end
end
