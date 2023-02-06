# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :treatment
  belongs_to :user

  def time_name
    "#{start_time.strftime('%R')}: #{client_name}"
  end
end
