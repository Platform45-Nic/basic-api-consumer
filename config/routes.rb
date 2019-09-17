Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'index', to: 'users#index'
  resources :sessions, only:[:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
