# frozen_string_literal: true

class User < ApplicationRecord
  MIN_LEN = 3
  MAX_LEN = 250
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, email: { mode: :strict }
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minimum: MIN_LEN, maximum: MAX_LEN }
  validates :first_name, presence: true, length: { minimum: MIN_LEN, maximum: MAX_LEN }
  validates :last_name, presence: true, length: { minimum: MIN_LEN, maximum: MAX_LEN }
end
