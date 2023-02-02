# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :businesses, only: %i[index show]
  get '/pages/home'
  get '/pages/about'
  get '/pages/contact'
  post '/create_contact', to: 'pages#create_contact'
  root to: 'pages#home'

  namespace :dashboard do
    resources :businesses
    resources :appointments
      root to: 'pages#home'
  end
end
