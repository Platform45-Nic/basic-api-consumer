Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'index', to: 'users#index'
  get 'todos/index', to: 'todos#index', as: 'todo_index'

  resources :sessions, only:[:new, :create]
  resources :users, only:[:new, :create, :destroy]
  resources :todos, only:[:show, :new, :create]

  # post '/sessions', to: 'sessions#create'
  # post '/sessions/new', to: 'sessions#new'
  # get '/sessions/new', to: 'sessions#new'
  # delete '/sessions/:id', to: 'sessions#destroy', as: 'session'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete  '/logout',  to: 'sessions#destroy'
end
