Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#guestfeed"
  get 'newest', to: 'home#newest'
  get 'feed', to: 'home#feed'
  get 'discover', to: 'home#discover'
  get 'get_album', to: "users#get_album"

  resources :users, only: :show do
    resources :photos, :albums, only: :index
  end

  resources :photos ,except: ['show']
  resources :albums ,except: ['show']

  namespace :admins, only: :show do
    resources :users,:photos,:albums, only: [:index,:edit,:update,:destroy]
  end
  post 'follow', to: 'users#follow'
  post 'like', to: 'users#like'
end
