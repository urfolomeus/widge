Rails.application.routes.draw do
  # Authentication
  get    '/signup'   => 'users#new'
  post   '/users'    => 'users#create'
  get    '/signin'   => 'sessions#new'
  post   '/sessions' => 'sessions#create'
  delete '/signout'  => 'sessions#destroy'

  post   '/widgets/:widget' => 'widgets#send_data'

  get    '/info' => 'info#show', as: :info

  root 'welcome#index'
end
