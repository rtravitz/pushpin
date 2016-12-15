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
    get '/dashboard/:id', to: "dashboard#show", as: :dashboard
    put '/dashboard/:id', to: "dashboard#update_user", as: :update_user
  end
end
