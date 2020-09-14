Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#guestfeed"
  get 'newest', to: 'home#newest'
  get 'feed', to: 'home#feed'
  get 'discover', to: 'home#discover'
  resources :users, only: :show do
    resources :photos, :albums, only: :index
  end

  resources :photos ,except: ['show']
  resources :albums ,except: ['show']

  resources :admins, only: :show do
    get 'manage_photo', to: 'admins#manage_photo'
    get 'manage_album', to: 'admins#manage_album'
    get 'manage_user', to: 'admins#manage_user'
    resources :users, only: [:edit,:destroy]
  end
end
