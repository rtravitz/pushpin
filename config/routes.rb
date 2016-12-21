Rails.application.routes.draw do
  root 'home#index'
  resources :skills, only: [:index, :show]

  get '/skills-search', to: 'skills#show'

  # get '/professionals', to: 'professionals#index', as: 'professionals'
  # get '/professionals/:id', to: 'professionals#show'
  resources :professionals, only: [:index, :show]
  resources :requesters, only: [:show]
  resources :proposals, only: [:show] do
    resources :messages
  end

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

  resources :users, only: [:edit, :update, :create, :show]
  get '/confirm' => 'confirmations#new', as: :user_confirmation
  patch '/confirm' => 'confirmations#update'

  namespace :requester do
    get '/dashboard', to: "dashboard#show", as: :dashboard
    get '/proposals/:id', to: "proposals#show", as: 'proposal'
    resources :proposals, only: [:show, :edit, :update]
    get '/:project', to: "projects#show", as: 'project'
    get '/ratings', to: "ratings#new"
    post '/ratings', to: "ratings#create"
    resources :projects, only: [:new, :create, :update, :edit]
  end

  namespace :professional do
    get '/dashboard', to: 'dashboard#show', as: :dashboard
    resources :skills, only: [:new, :create, :destroy]
    resources :projects, only: [:index]
    resources :ratings, only: [:new, :create]
    get '/projects/:project', to: 'projects#show', as: 'project'
    resources :proposals, only: [:new, :create, :show, :destroy]
  end
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :messages, only: [:index, :create]
    end
  end
end
