Rails.application.routes.draw do
  root 'home#index'
  resources :skills, only: [:index, :show]

  get '/skills-search', to: 'skills#show'
  get '/professionals', to: 'professionals#index', as: 'professionals'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  namespace :admin do
    get '/dashboard/:id', to: 'dashboard#show', as: :dashboard
    put '/update_user/:id', to: 'update_user#update_status', as: :update_user
  end

  resources :users, only: [:edit, :update, :create]
  get '/confirm' => 'confirmations#new', as: :user_confirmation
  patch '/confirm' => 'confirmations#update'
end
