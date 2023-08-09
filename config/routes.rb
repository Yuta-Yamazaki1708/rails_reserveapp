Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  get '/user/account', to: 'users/accounts#account'
  get '/user/profile', to: 'users/profiles#show'
  get '/user/profile/edit', to: 'users/profiles#edit'
  patch 'user/profile', to: 'users/profiles#update'
  get '/rooms/own', to: 'rooms#own'
  resources :rooms
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
