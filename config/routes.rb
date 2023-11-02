Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/login', to: 'sessions#new', as: 'login'
  get 'dashboard', to: 'users#dashboard', as: 'dashboard'
  post 'blacklist', to: 'blacklisted_repos#create'
  get 'blacklisted_repos', to: 'blacklisted_repos#index'
  delete 'unblacklist', to: 'blacklisted_repos#destroy'
  root to: 'sessions#new'
end
