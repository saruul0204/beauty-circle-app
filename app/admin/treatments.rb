# frozen_string_literal: true

ActiveAdmin.register Treatment do
  permit_params :name, :description, :price, :duration, :business_id
end
