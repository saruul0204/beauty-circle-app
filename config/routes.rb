# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/pages/home'
  get '/pages/about'
  get '/pages/contact'
  post '/create_contact', to: 'pages#create_contact'
  root to: 'pages#home'
end
