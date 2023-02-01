# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :full_name, :email, :message, presence: true
  validates :email, email: { mode: :strict }
end
