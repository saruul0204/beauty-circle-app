# frozen_string_literal: true

Rails.application.routes.draw do
  resources :businesses, only: %i[index show]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get '/pages/home'
  get '/pages/about'
  get '/pages/contact'
  post '/create_contact', to: 'pages#create_contact'
  root to: 'pages#home'

  namespace :dashboard do
    resources :businesses
    root to: 'pages#home'
  end
end
