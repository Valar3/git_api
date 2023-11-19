# frozen_string_literal: true

Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new', as: 'login'
  get 'dashboard', to: 'users#dashboard', as: 'dashboard'
  resources :blacklisted_repos, only: [:create, :destroy, :index]
  root to: 'sessions#new'
end
