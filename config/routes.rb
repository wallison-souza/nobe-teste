Rails.application.routes.draw do

  resources :account_movements
  resources :accounts, except: :new do
    get '/new/:client', to:'accounts#new', as:'new', on: :collection
  end
  devise_for :clients
  root to: 'accounts#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
