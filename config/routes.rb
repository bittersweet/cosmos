Cosmos::Application.routes.draw do
  devise_for :users

  root :to => 'sessions#new'
  match '/auth/facebook/callback', to: 'sessions#callback'

  match '/dashboard', to: 'dashboard#index'
end
