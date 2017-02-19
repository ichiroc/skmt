# frozen_string_literal: true
Rails.application.routes.draw do
  root 'products#index'

  resources :orders
  resources :cart_items, only: [:index, :create, :update, :destroy]
  resources :products, only: [:show, :index]
  namespace :admin do
    resources :products
    resources :users, except: [:new, :create]
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
