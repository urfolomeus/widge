Rails.application.routes.draw do
  # Authentication
  get    '/signup'  => 'users#new'
  post   '/users'   => 'users#create'
  get    '/signin'  => 'sessions#new'
  post   '/signin'  => 'sessions#create'
  delete '/signout' => 'sessions#destroy'

  root 'welcome#index'
end
