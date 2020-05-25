Rails.application.routes.draw do

  resources :account_movements, except: :index do
    get '/:account', to:'account_movements#index',as:'index',  on: :collection

  end
  resources :accounts, except: :new do
    get '/new/:client', to:'accounts#new', as:'new', on: :collection
    post 'deposit',  to:'accounts#deposit', as:'deposit',  on: :member
    post 'withdraw',  to:'accounts#withdraw', as:'withdraw',  on: :member
    post 'transfer',  to:'accounts#transfer', as:'transfer',  on: :member
  end
  devise_for :clients
  root to: 'accounts#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
