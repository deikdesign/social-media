Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/friend-request', to: 'friendships#friend_request'
  post '/accept-request', to: 'friendships#accept_request'
  post '/reject-request', to: "friendships#reject_request"
end
