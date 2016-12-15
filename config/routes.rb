Rails.application.routes.draw do
  root 'home#index'
  resources :skills, only: [:index, :show]

  get '/skills-search', to: 'skills#show'
  get '/professionals', to: 'professionals#index', as: 'professionals'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  resources :users, only: [:edit, :update, :create]
  get '/confirm' => 'confirmations#new', as: :user_confirmation
  patch '/confirm' => 'confirmations#update'

  namespace :professional do
    get '/dashboard', to: 'dashboard#show', as: :dashboard
  end
end
