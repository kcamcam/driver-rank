Rails.application.routes.draw do
  get 'appstore/index'

  get 'sessions/new'
  get 'users/new'
  get 'welcome/index'
  get 'appstore/index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :licenceplates do
    put :downvote
    put :upvote
  end
  resources :appstore do
    put :downvote
    put :upvote
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
