Rails.application.routes.draw do

  resources :account_movements
  resources :accounts
  devise_for :clients
  root to: 'accounts#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
