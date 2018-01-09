Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'welcome/index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :licenceplates do
    put :upvote
    put :downvote
  end
  resources :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
