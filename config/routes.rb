Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'index', to: 'users#index'
  resources :sessions, only:[:new, :create]
  delete  '/logout',  to: 'sessions#destroy'
  resources :users, only:[:new, :create, :destroy]
  # post '/sessions', to: 'sessions#create'
  # post '/sessions/new', to: 'sessions#new'
  # get '/sessions/new', to: 'sessions#new'
  # delete '/sessions/:id', to: 'sessions#destroy', as: 'session'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  # get 'logout', to: 'sessions#destroy', as: 'logout'
end
