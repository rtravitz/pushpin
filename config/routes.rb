Rails.application.routes.draw do
  root "home#index"
  resources :skills, only: [:show]
end
