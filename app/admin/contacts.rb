# frozen_string_literal: true

ActiveAdmin.register Contact do
  permit_params :full_name, :email, :message
end
