Rails.application.routes.draw do

  root 'home#show'
  get '/dashboard', to: 'dashboard#show'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end