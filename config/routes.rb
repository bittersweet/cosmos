Cosmos::Application.routes.draw do
  devise_for :users

  resources :tracks do
    get :waveform, :on => :member
  end

  match '/login', to: 'sessions#new'
  match '/auth/facebook/callback', to: 'sessions#callback'
  match '/dashboard', to: 'dashboard#index'

  root :to => 'dashboard#index'
end
