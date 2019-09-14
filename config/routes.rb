Rails.application.routes.draw do
  root to: 'static_pages#index'

  get 'index', to: 'users#index'
end
