Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'index', to: 'users#index'

  resources :sessions, only: :create
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout',  to: 'sessions#destroy', as: 'logout'

  resources :users, only:[:new, :create, :destroy]

  resources :todos, only:[:show, :new, :create]
  get 'todos/index', to: 'todos#index', as: 'todo_index'

  get 'signup', to: 'users#new', as: 'signup'
end
