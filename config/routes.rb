Rails.application.routes.draw do
  root 'products#index'
  resources :cart_items
  resources :products, only: [:show, :index]
  namespace :admin do
    resources :products
    resources :users, except:[:new, :create]
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
