Rails.application.routes.draw do
  root 'pages#home'
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'login', to: "sessions#destroy"

  resources :parkingzones
  resources :parkingslots
  resources :bills

  get '/users/:id/history', to: 'users#history', as: 'user_history'
  get '/users/:id/active', to: 'users#active', as: 'user_active'
end
