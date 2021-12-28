# frozen_string_literal: true

ActiveAdmin.register City do
  permit_params :name, :city_image

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)

    inputs 'Business' do
      f.input :name
      f.input :city_image, as: :file
    end
    f.actions
  end
end
