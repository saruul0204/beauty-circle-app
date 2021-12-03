# frozen_string_literal: true

ActiveAdmin.register Business do
  permit_params :name, :description, :address, :country, :open_hour, :close_hour, :phone_number, :email, :facebook_url,
                :instagram_url, :user_id, :city_id

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)

    inputs 'Business' do
      f.input :user
      f.input :name
      f.input :description
      f.input :address
      f.input :country, as: :string
      f.input :city
      f.input :open_hour
      f.input :close_hour
      f.input :phone_number
      f.input :email
      f.input :facebook_url
      f.input :instagram_url
    end

    f.actions
  end
end
