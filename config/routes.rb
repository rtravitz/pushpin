Rails.application.routes.draw do
  root "home#index"
  resources :skills, only: [:show]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  resources :users, only: [:edit, :update, :create]
  get '/confirm' => 'confirmations#new', as: :user_confirmation
  post '/confirm' => 'confirmations#create'

end
