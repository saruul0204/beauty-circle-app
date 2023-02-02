# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :treatment
  belongs_to :user
end
