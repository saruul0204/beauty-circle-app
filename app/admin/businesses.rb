# frozen_string_literal: true

ActiveAdmin.register Business do
  permit_params :name, :description, :address, :country, :open_hour, :close_hour, :phone_number, :email, :facebook_url, :instagram_url, :user_id, :city_id
end
