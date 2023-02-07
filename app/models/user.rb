# frozen_string_literal: true

class User < ApplicationRecord
  MIN_LEN = 3
  MAX_LEN = 250
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :businesses, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates :email, email: { mode: :strict }
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minimum: MIN_LEN, maximum: MAX_LEN }
  validates :first_name, presence: true, length: { minimum: MIN_LEN, maximum: MAX_LEN }
  validates :last_name, presence: true, length: { minimum: MIN_LEN, maximum: MAX_LEN }

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update(deleted_at: Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    deleted_at ? :deleted_account : super
  end
end
