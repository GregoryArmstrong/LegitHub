Rails.application.routes.draw do

  root 'home#show'
  get '/dashboard', to: 'dashboard#show'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :commits, only: [:index]
  resources :repositories, only: [:index]
  resources :organizations, only: [:index]
  resources :pull_requests, only: [:index]

end
