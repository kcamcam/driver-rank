Rails.application.routes.draw do
  get 'users/new'
  get 'welcome/index'
  resources :licenceplates do
    put :upvote
    put :downvote
  end
  resources :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
