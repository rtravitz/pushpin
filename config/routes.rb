Rails.application.routes.draw do
  root 'home#index'
  resources :skills, only: [:index, :show]

  get '/skills-search', to: 'skills#show'

  # get '/professionals', to: 'professionals#index', as: 'professionals'
  # get '/professionals/:id', to: 'professionals#show'
  resources :professionals, only: [:index, :show]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show', as: :dashboard
    put '/update_user/:id', to: 'update_user#update_status', as: :update_user
    delete '/delete_user/:id', to: 'update_user#destroy_user', as: :delete_user
  end

  resources :users, only: [:edit, :update, :create]
  get '/confirm' => 'confirmations#new', as: :user_confirmation
  patch '/confirm' => 'confirmations#update'

  namespace :requester do
    get '/dashboard', to: "dashboard#show", as: :dashboard
    resources :projects, only: [:new, :create]
    get '/:project', to: "projects#show", as: 'project'
  end

  namespace :professional do
    get '/dashboard', to: 'dashboard#show', as: :dashboard
    resources :skills, only: [:new, :create]
    resources :projects, only: [:index]
    get '/projects/:project', to: 'projects#show', as: 'project'
    get '/proposals/new', to: 'proposals#new'
    delete '/proposals/:id', to: 'proposals#destroy', as: 'proposal'
    # should the next route have the create in the path?
    post '/proposals', to: 'proposals#create', as: 'proposals'
  end
end
