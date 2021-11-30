# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :username, :first_name, :last_name
end
